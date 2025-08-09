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

    // Load each framework type
    for (final frameworkType in FrameworkType.values) {
      try {
        final framework = await loadFramework(frameworkType);
        if (framework != null) {
          frameworks[frameworkType] = framework;
        }
      } catch (e) {
        print('Error loading framework ${frameworkType.name}: $e');
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
        return await _loadStandardFramework('adb.csv', type);
      case FrameworkType.eccmFacility:
        return await _loadStandardFramework('eccm_facility.csv', type);
      case FrameworkType.eccmOrganization:
        return await _loadStandardFramework('eccm_organization.csv', type);
      case FrameworkType.is4hInstitutional:
        return await _loadIs4hFramework(type, 'institute');
      case FrameworkType.is4hCountry:
        return await _loadIs4hFramework(type, 'country');
    }
  }

  /// Load standard question-based frameworks (ADB, ECCM)
  Future<Framework?> _loadStandardFramework(
    String fileName,
    FrameworkType type,
  ) async {
    try {
      final csvString = await rootBundle.loadString('csv/$fileName');
      final List<List<dynamic>> csvTable = const CsvToListConverter().convert(
        csvString,
      );

      if (csvTable.isEmpty) return null;

      final headers = csvTable[0].map((e) => e.toString().trim()).toList();
      final Map<String, Map<String, List<AssessmentItem>>> groupedData = {};

      // Process each row
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
          id: '${type.filePrefix}_${row['item_id'] ?? i}',
          frameworkId: type.filePrefix,
          domain: domain,
          subdomain: subdomain,
          itemType: row['item_type']?.toString() ?? 'question',
          questionText: row['question_text']?.toString() ??
              row['text_english']?.toString() ??
              '',
          maturityLevel: _parseMaturityLevel(row['maturity_level']),
          responseType: row['response_type']?.toString() ?? 'scale',
          scoringNote: row['scoring_note']?.toString(),
        );

        groupedData[domain]![subdomain]!.add(item);
      }

      // Convert grouped data to Domain structure
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

  /// Load IS4H frameworks (combines multiple CSV files)
  Future<Framework?> _loadIs4hFramework(
    FrameworkType type,
    String level,
  ) async {
    final Map<String, Map<String, List<AssessmentItem>>> allData = {};
    final domainFiles = ['dmit', 'mago', 'kmsh', 'inno'];

    for (final domainFile in domainFiles) {
      final fileName = 'is4h_${level}_$domainFile.csv';

      try {
        final csvString = await rootBundle.loadString('csv//$fileName');
        final List<List<dynamic>> csvTable = const CsvToListConverter().convert(
          csvString,
        );

        if (csvTable.isEmpty) continue;

        final headers = csvTable[0].map((e) => e.toString().trim()).toList();

        // Get the main domain name from the spider config
        final mainDomain = _getIs4hDomainName(domainFile);
        allData[mainDomain] ??= {};

        // Process each row
        for (int i = 1; i < csvTable.length; i++) {
          final Map<String, dynamic> row = {};
          for (int j = 0; j < headers.length && j < csvTable[i].length; j++) {
            row[headers[j]] = csvTable[i][j];
          }

          final subdomain = row['subdomain']?.toString() ?? 'General';

          allData[mainDomain]![subdomain] ??= [];

          final item = AssessmentItem(
            id: '${type.filePrefix}_${domainFile}_${row['item_id'] ?? i}',
            frameworkId: type.filePrefix,
            domain: mainDomain,
            subdomain: subdomain,
            itemType: row['item_type']?.toString() ?? 'question',
            questionText: row['question_text']?.toString() ??
                row['text_english']?.toString() ??
                '',
            maturityLevel: _parseMaturityLevel(row['maturity_level']),
            responseType: row['response_type']?.toString() ?? 'scale',
            scoringNote: row['scoring_note']?.toString(),
          );

          allData[mainDomain]![subdomain]!.add(item);
        }
      } catch (e) {
        print('Error loading $fileName: $e');
      }
    }

    // Convert to Domain structure
    final domains = _createDomainsFromGroupedData(allData);

    return Framework(
      type: type,
      name: type.displayName,
      description: _getFrameworkDescription(type),
      domains: domains,
    );
  }

  /// Load BPMN framework (special rubric format)
  Future<Framework?> _loadBpmnFramework() async {
    try {
      // For BPMN, we need to restructure the data differently
      // Each domain gets one item per maturity level
      final domains = <Domain>[];

      // BPMN domains from the spider config
      final bpmnDomains = [
        (
          'institutional_standards',
          'Institutional Standards/Guidelines/Policies',
        ),
        ('stakeholder_management', 'Stakeholder Management'),
        ('adoption_processes', 'Adoption Processes'),
        ('privacy_security', 'Privacy, Security, Confidentiality'),
        ('skills_expertise', 'Skills and Expertise'),
        ('knowledge_assets', 'Knowledge Assets, Tools and Automation'),
        ('goals_measurement', 'Goals and Measurement'),
      ];

      // Load the CSV to get the descriptions
      final csvString = await rootBundle.loadString('csv/bpmn.csv');
      final List<List<dynamic>> csvTable = const CsvToListConverter().convert(
        csvString,
      );

      Map<String, Map<int, String>> descriptions = {};

      if (csvTable.isNotEmpty) {
        final headers = csvTable[0].map((e) => e.toString().trim()).toList();

        // Process the CSV to extract descriptions for each domain and level
        for (int i = 1; i < csvTable.length; i++) {
          final Map<String, dynamic> row = {};
          for (int j = 0; j < headers.length && j < csvTable[i].length; j++) {
            row[headers[j]] = csvTable[i][j];
          }

          final domain = row['domain']?.toString();
          final maturityLevel = _parseMaturityLevel(row['maturity_level']);
          final description = row['text_english']?.toString() ?? '';

          if (domain != null && domain.isNotEmpty) {
            descriptions[domain] ??= {};
            descriptions[domain]![maturityLevel] = description;
          }
        }
      }

      // Create domains with special BPMN structure
      for (final (id, displayName) in bpmnDomains) {
        final items = <AssessmentItem>[];

        // Create a single item that represents all maturity levels for this domain
        // The question text will contain all level descriptions
        final domainDescriptions =
            descriptions[displayName] ?? descriptions[id] ?? {};

        // Create a comprehensive question that includes all levels
        final questionText = StringBuffer(
          'Select your organization\'s maturity level:\n\n',
        );
        for (int level = 1; level <= 5; level++) {
          final desc = domainDescriptions[level] ?? 'Level $level';
          questionText.writeln('Level $level: $desc\n');
        }

        items.add(
          AssessmentItem(
            id: 'bpmn_$id',
            frameworkId: 'bpmn',
            domain: displayName,
            subdomain: 'Assessment',
            itemType: 'rubric',
            questionText: questionText.toString(),
            maturityLevel: 1, // Default to 1
            responseType: 'maturity_level',
            scoringNote: 'Select a maturity level from 1-5',
          ),
        );

        domains.add(
          Domain(
            id: id,
            name: displayName,
            subdomains: [
              Subdomain(
                id: '${id}_assessment',
                name: 'Assessment',
                items: items,
              ),
            ],
          ),
        );
      }

      return Framework(
        type: FrameworkType.bpmn,
        name: 'BPMN Maturity Model',
        description: _getFrameworkDescription(FrameworkType.bpmn),
        domains: domains,
      );
    } catch (e) {
      print('Error loading BPMN framework: $e');
      return null;
    }
  }

  /// Helper to create domains from grouped data
  List<Domain> _createDomainsFromGroupedData(
    Map<String, Map<String, List<AssessmentItem>>> groupedData,
  ) {
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

  /// Parse maturity level from various formats
  static int _parseMaturityLevel(dynamic value) {
    if (value == null) return 1;
    if (value is int) return value;
    if (value is double) return value.round();
    if (value is String) {
      final parsed = double.tryParse(value);
      return parsed?.round() ?? 1;
    }
    return 1;
  }

  /// Get framework description
  String _getFrameworkDescription(FrameworkType type) {
    switch (type) {
      case FrameworkType.is4hInstitutional:
        return 'Comprehensive maturity assessment for healthcare institutions';
      case FrameworkType.is4hCountry:
        return 'National-level health information systems assessment';
      case FrameworkType.eccmFacility:
        return 'Essential capabilities for facility-level systems';
      case FrameworkType.eccmOrganization:
        return 'Essential capabilities for organizational systems';
      case FrameworkType.bpmn:
        return 'Business process maturity assessment using BPMN standards';
      case FrameworkType.adb:
        return 'Asian Development Bank digital health readiness framework';
    }
  }

  /// Map ECCM domains to spider graph categories
  Map<String, String> getEccmDomainMapping() {
    return {
      // You'll need to verify these mappings based on actual CSV content
      'HIT Infrastructure': 'hit_learning',
      'Interoperability': 'interoperability',
      'Patient-Centered Care': 'patient_centered',
      'Technical Resources': 'tech_resources',
      'Data Quality': 'data_quality',
      'Analytics': 'analytics',
    };
  }

  /// Map ADB domains to spider graph categories
  Map<String, String> getAdbDomainMapping() {
    return {
      // You'll need to verify these mappings based on actual CSV content
      'Core': 'core',
      'Technology': 'tech',
      'Learning': 'learning',
      'Society': 'societal',
    };
  }
}
