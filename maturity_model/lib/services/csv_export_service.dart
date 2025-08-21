// lib/services/csv_export_service.dart

import 'package:csv/csv.dart';
import 'package:maturity_model/maturity_model.dart'
    show FrameworkType, CsvLoaderService, AssessmentSession;

class CsvExportService {
  static final CsvExportService _instance = CsvExportService._internal();
  factory CsvExportService() => _instance;
  CsvExportService._internal();

  /// Export session data to CSV string
  String exportSessionToCsv(AssessmentSession session) {
    final rows = <List<dynamic>>[];

    // Add headers
    rows.add([
      'type',
      'session_id',
      'timestamp',
      'framework',
      'domain',
      'subdomain',
      'item_id',
      'response',
      'comment',
      'organization',
      'assessor',
      'location',
      'notes'
    ]);

    // Add metadata row
    rows.add([
      'metadata',
      session.sessionId,
      session.lastModified.toIso8601String(),
      '',
      '',
      '',
      '',
      '',
      '',
      session.organizationName ?? '',
      session.assessorName ?? '',
      session.location ?? '',
      session.additionalNotes ?? '',
    ]);

    // Add response rows
    for (final framework in session.frameworks.values) {
      for (final domain in framework.domains) {
        for (final subdomain in domain.subdomains) {
          for (final item in subdomain.items) {
            if (item.response != null && item.response! > 0) {
              rows.add([
                'response',
                session.sessionId,
                item.responseTimestamp?.toIso8601String() ?? '',
                framework.type.name,
                domain.name,
                subdomain.name,
                item.id,
                item.response,
                item.comment ?? '',
                '',
                '',
                '',
                '',
              ]);
            }
          }
        }
      }
    }

    // Convert to CSV
    return const ListToCsvConverter().convert(rows);
  }

  /// Import session data from CSV string
  Future<AssessmentSession?> importSessionFromCsv(String csvContent) async {
    try {
      final List<List<dynamic>> csvTable =
          const CsvToListConverter().convert(csvContent);

      if (csvTable.isEmpty) return null;

      final headers = csvTable[0].map((e) => e.toString()).toList();

      AssessmentSession? session;
      final Map<FrameworkType, Map<String, Map<String, Map<String, dynamic>>>>
          responses = {};

      // Process each row
      for (int i = 1; i < csvTable.length; i++) {
        final Map<String, dynamic> row = {};
        for (int j = 0; j < headers.length && j < csvTable[i].length; j++) {
          row[headers[j]] = csvTable[i][j];
        }

        if (row['type'] == 'metadata') {
          // Create session from metadata
          session = AssessmentSession(
            sessionId: row['session_id']?.toString(),
            createdAt: row['timestamp'] != null
                ? DateTime.tryParse(row['timestamp'].toString())
                : null,
            organizationName: row['organization']?.toString(),
            assessorName: row['assessor']?.toString(),
            location: row['location']?.toString(),
            additionalNotes: row['notes']?.toString(),
          );
        } else if (row['type'] == 'response') {
          // Collect responses to apply later
          final frameworkName = row['framework']?.toString();
          if (frameworkName != null) {
            final frameworkType = FrameworkType.values.firstWhere(
              (e) => e.name == frameworkName,
              orElse: () => FrameworkType.is4hInstitutional,
            );

            responses[frameworkType] ??= {};
            final domain = row['domain']?.toString() ?? '';
            responses[frameworkType]![domain] ??= {};
            final subdomain = row['subdomain']?.toString() ?? '';
            responses[frameworkType]![domain]![subdomain] ??= {};

            responses[frameworkType]![domain]![subdomain]![
                row['item_id']?.toString() ?? ''] = {
              'response': row['response'],
              'comment': row['comment']?.toString(),
              'timestamp': row['timestamp']?.toString(),
            };
          }
        }
      }

      if (session == null) {
        session = AssessmentSession();
      }

      // Load frameworks and apply responses
      final loader = CsvLoaderService();
      for (final entry in responses.entries) {
        final framework = await loader.loadFramework(entry.key);
        if (framework != null) {
          // Apply saved responses to the framework
          for (final domain in framework.domains) {
            final domainResponses = entry.value[domain.name];
            if (domainResponses != null) {
              for (final subdomain in domain.subdomains) {
                final subdomainResponses = domainResponses[subdomain.name];
                if (subdomainResponses != null) {
                  for (final item in subdomain.items) {
                    final itemResponse = subdomainResponses[item.id];
                    if (itemResponse != null) {
                      item.response = itemResponse['response'] as int?;
                      item.comment = itemResponse['comment'] as String?;
                      if (itemResponse['timestamp'] != null) {
                        item.responseTimestamp =
                            DateTime.tryParse(itemResponse['timestamp']);
                      }
                    }
                  }
                }
              }
            }
          }
          session.frameworks[entry.key] = framework;
        }
      }

      return session;
    } catch (e) {
      print('Error importing CSV: $e');
      return null;
    }
  }
}
