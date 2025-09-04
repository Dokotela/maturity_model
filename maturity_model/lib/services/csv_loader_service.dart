// lib/services/csv_loader_service.dart

// ignore_for_file: avoid_print

import 'package:flutter/services.dart';
import 'package:csv/csv.dart';
import 'package:maturity_model/maturity_model.dart'
    show FrameworkType, Framework, AssessmentItem, Domain, Subdomain;

class CsvLoaderService {
  static final CsvLoaderService _instance = CsvLoaderService._internal();
  factory CsvLoaderService() => _instance;
  CsvLoaderService._internal();

  /// Load all frameworks for a session - IS4H only
  Future<Map<FrameworkType, Framework>> loadAllFrameworks() async {
    final Map<FrameworkType, Framework> frameworks = {};

    for (final frameworkType in FrameworkType.values) {
      try {
        final framework = await loadFramework(frameworkType);
        if (framework != null) {
          frameworks[frameworkType] = framework;
          print(
              '✔ Loaded ${frameworkType.displayName}: ${framework.domains.length} domains');
        }
      } catch (e) {
        print('✗ Error loading ${frameworkType.displayName}: $e');
      }
    }

    return frameworks;
  }

  /// Load a specific framework
  Future<Framework?> loadFramework(FrameworkType type) async {
    switch (type) {
      case FrameworkType.is4hInstitutional:
        return await _loadIs4hFramework(type, 'institute');
      case FrameworkType.is4hCountry:
        return await _loadIs4hFramework(type, 'country');
    }
  }

  /// Get the framework ID string for a given type
  String _getFrameworkId(FrameworkType type) {
    switch (type) {
      case FrameworkType.is4hInstitutional:
        return 'is4h_institute';
      case FrameworkType.is4hCountry:
        return 'is4h_country';
    }
  }

  /// Load IS4H frameworks (consolidated maturity questions)
  Future<Framework?> _loadIs4hFramework(
      FrameworkType type, String level) async {
    final Map<String, Map<String, List<AssessmentItem>>> allData = {};
    final domainFiles = ['dmit', 'mago', 'kmsh', 'inno'];

    for (final domainFile in domainFiles) {
      final fileName = 'is4h_${level}_$domainFile.csv';

      try {
        final csvString = await rootBundle.loadString('assets/csv/$fileName');
        final List<List<dynamic>> csvTable =
            const CsvToListConverter().convert(csvString);

        if (csvTable.isEmpty) continue;

        final headers = csvTable[0].map((e) => e.toString().trim()).toList();
        final mainDomain = _getIs4hDomainName(domainFile);
        allData[mainDomain] ??= {};

        for (int i = 1; i < csvTable.length; i++) {
          final Map<String, dynamic> row = {};
          for (int j = 0; j < headers.length && j < csvTable[i].length; j++) {
            row[headers[j]] = csvTable[i][j];
          }

          final itemType = row['item_type']?.toString() ?? '';

          // Skip headings and subheadings
          if (itemType == 'heading' || itemType == 'subheading') {
            continue;
          }

          final subdomain = row['subdomain']?.toString() ?? 'General';
          allData[mainDomain]![subdomain] ??= [];

          // Handle maturity questions
          if (itemType == 'maturity_question') {
            final maturityDescriptions = <int, String>{};
            for (int level = 1; level <= 5; level++) {
              final description = row['maturity_$level']?.toString() ?? '';
              if (description.isNotEmpty) {
                maturityDescriptions[level] = description;
              }
            }

            final item = AssessmentItem(
              id: row['item_id']?.toString() ?? '',
              frameworkId: _getFrameworkId(type),
              domain: mainDomain,
              subdomain: subdomain,
              itemType: 'maturity_scale',
              questionText: row['question_text']?.toString() ?? '',
              maturityDescriptions: maturityDescriptions,
              responseType: row['response_type']?.toString() ?? 'scale',
              scoringNote: row['scoring_note']?.toString(),
            );

            allData[mainDomain]![subdomain]!.add(item);
          } else if (itemType == 'question') {
            // Regular question
            final item = AssessmentItem(
              id: row['item_id']?.toString() ?? '',
              frameworkId: _getFrameworkId(type),
              domain: mainDomain,
              subdomain: subdomain,
              itemType: itemType,
              questionText: row['question_text']?.toString() ?? '',
              responseType: row['response_type']?.toString() ?? 'text',
              scoringNote: row['scoring_note']?.toString(),
            );

            allData[mainDomain]![subdomain]!.add(item);
          }
        }
      } catch (e) {
        print('Error loading $fileName: $e');
      }
    }

    // Convert to Framework structure with CORRECT constructor parameters
    if (allData.isNotEmpty) {
      final domains = <Domain>[];

      for (final domainEntry in allData.entries) {
        final subdomains = <Subdomain>[];

        for (final subdomainEntry in domainEntry.value.entries) {
          subdomains.add(
            Subdomain(
              id: '${_getFrameworkId(type)}_${domainEntry.key}_${subdomainEntry.key}'
                  .replaceAll(' ', '_')
                  .toLowerCase(),
              name: subdomainEntry.key,
              items: subdomainEntry.value,
            ),
          );
        }

        domains.add(
          Domain(
            id: '${_getFrameworkId(type)}_${domainEntry.key}'
                .replaceAll(' ', '_')
                .toLowerCase(),
            name: domainEntry.key,
            subdomains: subdomains,
          ),
        );
      }

      return Framework(
        type: type, // Use the FrameworkType enum value
        name: type.displayName,
        description: type.description,
        domains: domains,
      );
    }

    return null;
  }

  /// Get IS4H domain names
  String _getIs4hDomainName(String domainCode) {
    switch (domainCode) {
      case 'dmit':
        return 'Data Management and Information Technology';
      case 'mago':
        return 'Management and Governance';
      case 'kmsh':
        return 'Knowledge Management and Sharing';
      case 'inno':
        return 'Innovation';
      default:
        return domainCode;
    }
  }
}
