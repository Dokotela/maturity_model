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

  /// Load all frameworks for a session
  Future<Map<FrameworkType, Framework>> loadAllFrameworks() async {
    final Map<FrameworkType, Framework> frameworks = {};

    for (final frameworkType in FrameworkType.values) {
      try {
        final framework = await loadFramework(frameworkType);
        if (framework != null) {
          frameworks[frameworkType] = framework;
          print(
              '✓ Loaded ${frameworkType.displayName}: ${framework.domains.length} domains');
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
      case FrameworkType.bpmn:
        return await _loadBpmnFramework();
      case FrameworkType.adb:
        return await _loadAdbFramework();
      case FrameworkType.eccmFacility:
        return await _loadEccmFramework('eccm_facility.csv', type);
      case FrameworkType.eccmOrganization:
        return await _loadEccmFramework('eccm_organization.csv', type);
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
      case FrameworkType.eccmFacility:
        return 'eccm_facility';
      case FrameworkType.eccmOrganization:
        return 'eccm_organization';
      case FrameworkType.adb:
        return 'adb';
      case FrameworkType.bpmn:
        return 'bpmn';
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
              frameworkId: _getFrameworkId(type), // Use helper method
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
              frameworkId: _getFrameworkId(type), // Use helper method
              domain: mainDomain,
              subdomain: subdomain,
              itemType: 'question',
              questionText: row['question_text']?.toString() ?? '',
              responseType: row['response_type']?.toString() ?? 'scale',
              scoringNote: row['scoring_note']?.toString(),
            );

            allData[mainDomain]![subdomain]!.add(item);
          }
        }
      } catch (e) {
        print('Error loading $fileName: $e');
      }
    }

    final domains = _createDomainsFromGroupedData(allData);

    return Framework(
      type: type,
      name: type.displayName,
      description: _getFrameworkDescription(type),
      domains: domains,
    );
  }

  /// Load ECCM frameworks
  Future<Framework?> _loadEccmFramework(
      String fileName, FrameworkType type) async {
    try {
      final csvString = await rootBundle.loadString('assets/csv/$fileName');
      final List<List<dynamic>> csvTable =
          const CsvToListConverter().convert(csvString);

      if (csvTable.isEmpty) return null;

      final headers = csvTable[0].map((e) => e.toString().trim()).toList();
      final Map<String, Map<String, List<AssessmentItem>>> groupedData = {};

      for (int i = 1; i < csvTable.length; i++) {
        final Map<String, dynamic> row = {};
        for (int j = 0; j < headers.length && j < csvTable[i].length; j++) {
          row[headers[j]] = csvTable[i][j];
        }

        final domain = row['domain']?.toString() ?? 'General';
        final subdomain = row['subdomain']?.toString() ?? 'General';

        groupedData[domain] ??= {};
        groupedData[domain]![subdomain] ??= [];

        final item = AssessmentItem(
          id: row['item_id']?.toString() ?? '',
          frameworkId: _getFrameworkId(type), // Use helper method
          domain: domain,
          subdomain: subdomain,
          itemType: row['item_type']?.toString() ?? 'assessment',
          questionText: row['text_english']?.toString() ?? '',
          maturityLevel: _parseMaturityLevel(row['maturity_level']),
          responseType: row['response_type']?.toString() ?? 'checkbox',
          scoringNote: row['scoring_note']?.toString(),
        );

        groupedData[domain]![subdomain]!.add(item);
      }

      final domains = _createDomainsFromGroupedData(groupedData);

      return Framework(
        type: type,
        name: type.displayName,
        description: _getFrameworkDescription(type),
        domains: domains,
      );
    } catch (e) {
      print('Error loading $fileName: $e');
      return null;
    }
  }

  /// Load ADB framework
  Future<Framework?> _loadAdbFramework() async {
    try {
      final csvString = await rootBundle.loadString('assets/csv/adb.csv');
      final List<List<dynamic>> csvTable =
          const CsvToListConverter().convert(csvString);

      if (csvTable.isEmpty) return null;

      final headers = csvTable[0].map((e) => e.toString().trim()).toList();
      final Map<String, Map<String, List<AssessmentItem>>> groupedData = {};

      for (int i = 1; i < csvTable.length; i++) {
        final Map<String, dynamic> row = {};
        for (int j = 0; j < headers.length && j < csvTable[i].length; j++) {
          row[headers[j]] = csvTable[i][j];
        }

        final domain = row['domain']?.toString() ?? 'General';
        final subdomain = row['subdomain']?.toString() ?? 'General';

        groupedData[domain] ??= {};
        groupedData[domain]![subdomain] ??= [];

        final item = AssessmentItem(
          id: row['item_id']?.toString() ?? '',
          frameworkId: 'adb',
          domain: domain,
          subdomain: subdomain,
          itemType: row['item_type']?.toString() ?? 'statement',
          questionText: row['question_text']?.toString() ??
              row['text_english']?.toString() ??
              '',
          responseType: row['response_type']?.toString() ?? 'likert_1_5',
          scoringNote: row['scoring_note']?.toString(),
        );

        groupedData[domain]![subdomain]!.add(item);
      }

      final domains = _createDomainsFromGroupedData(groupedData);

      return Framework(
        type: FrameworkType.adb,
        name: 'ADB Digital Health Readiness',
        description: _getFrameworkDescription(FrameworkType.adb),
        domains: domains,
      );
    } catch (e) {
      print('Error loading ADB: $e');
      return null;
    }
  }

  /// Load BPMN framework (now with consolidated CSV structure like other frameworks)
  Future<Framework?> _loadBpmnFramework() async {
    try {
      final csvString = await rootBundle.loadString('assets/csv/bpmn.csv');
      final List<List<dynamic>> csvTable =
          const CsvToListConverter().convert(csvString);

      if (csvTable.isEmpty) return null;

      final headers = csvTable[0].map((e) => e.toString().trim()).toList();
      final Map<String, Map<String, List<AssessmentItem>>> groupedData = {};

      for (int i = 1; i < csvTable.length; i++) {
        final Map<String, dynamic> row = {};
        for (int j = 0; j < headers.length && j < csvTable[i].length; j++) {
          row[headers[j]] = csvTable[i][j];
        }

        final domain = row['domain']?.toString() ?? '';
        final subdomain = row['subdomain']?.toString() ?? 'Assessment';

        // Build maturity descriptions from the maturity_1 through maturity_5 columns
        final maturityDescriptions = <int, String>{};
        for (int level = 1; level <= 5; level++) {
          final description = row['maturity_$level']?.toString() ?? '';
          if (description.isNotEmpty) {
            maturityDescriptions[level] = description;
          }
        }

        groupedData[domain] ??= {};
        groupedData[domain]![subdomain] ??= [];

        final item = AssessmentItem(
          id: row['item_id']?.toString() ?? '',
          frameworkId: 'bpmn',
          domain: domain,
          subdomain: subdomain,
          itemType: row['item_type']?.toString() ?? 'maturity_rubric',
          questionText: row['question_text']?.toString() ?? '',
          maturityDescriptions: maturityDescriptions,
          responseType: row['response_type']?.toString() ?? 'maturity_level',
          scoringNote: row['scoring_note']?.toString(),
        );

        groupedData[domain]![subdomain]!.add(item);
      }

      final domains = _createDomainsFromGroupedData(groupedData);

      print('BPMN loaded with ${domains.length} domains');
      for (final domain in domains) {
        print('  - ${domain.name}: ${domain.subdomains.length} subdomains');
        for (final subdomain in domain.subdomains) {
          print('    - ${subdomain.name}: ${subdomain.items.length} items');
        }
      }

      return Framework(
        type: FrameworkType.bpmn,
        name: 'BPM+ Clinical Practice Guideline',
        description: _getFrameworkDescription(FrameworkType.bpmn),
        domains: domains,
      );
    } catch (e) {
      print('Error loading BPMN: $e');
      print('Stack trace: ${StackTrace.current}');
      return null;
    }
  }

  /// Helper to create domains from grouped data
  List<Domain> _createDomainsFromGroupedData(
      Map<String, Map<String, List<AssessmentItem>>> groupedData) {
    return groupedData.entries.map((domainEntry) {
      final subdomains = domainEntry.value.entries.map((subdomainEntry) {
        return Subdomain(
          id: '${domainEntry.key}_${subdomainEntry.key}'
              .replaceAll(' ', '_')
              .toLowerCase(),
          name: subdomainEntry.key,
          items: subdomainEntry.value,
        );
      }).toList();

      return Domain(
        id: domainEntry.key.replaceAll(' ', '_').toLowerCase(),
        name: domainEntry.key,
        subdomains: subdomains,
      );
    }).toList();
  }

  /// Get IS4H domain name from file suffix
  String _getIs4hDomainName(String suffix) {
    switch (suffix) {
      case 'dmit':
        return 'Data Management and Information Technology';
      case 'mago':
        return 'Management and Governance';
      case 'kmsh':
        return 'Knowledge Management and Sharing';
      case 'inno':
        return 'Innovation';
      default:
        return suffix.toUpperCase();
    }
  }

  /// Parse maturity level
  static int? _parseMaturityLevel(dynamic value) {
    if (value == null) return null;
    if (value is int) return value;
    if (value is double) return value.round();
    if (value is String) {
      final parsed = double.tryParse(value);
      return parsed?.round();
    }
    return null;
  }

  /// Get framework description
  String _getFrameworkDescription(FrameworkType type) {
    switch (type) {
      case FrameworkType.bpmn:
        return 'Business Process Maturity Model for healthcare organizations';
      case FrameworkType.adb:
        return 'Asian Development Bank digital health readiness assessment';
      case FrameworkType.eccmFacility:
        return 'Essential Care Continuity Maturity Model for healthcare facilities';
      case FrameworkType.eccmOrganization:
        return 'Essential Care Continuity Maturity Model for organizations';
      case FrameworkType.is4hInstitutional:
        return 'Information Systems for Health maturity assessment for healthcare institutions';
      case FrameworkType.is4hCountry:
        return 'Information Systems for Health maturity assessment at country level';
    }
  }
}
