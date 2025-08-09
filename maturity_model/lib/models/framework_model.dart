// lib/models/framework_model.dart

/// Enum for all available framework types
enum FrameworkType {
  is4hInstitutional('IS4H Institutional', 'is4h_inst'),
  is4hCountry('IS4H Country', 'is4h_country'),
  eccmFacility('ECCM Facility', 'eccm_f'),
  eccmOrganization('ECCM Organization', 'eccm_o'),
  bpmn('BPMN', 'bpmn'),
  adb('ADB', 'adb');

  final String displayName;
  final String filePrefix;

  const FrameworkType(this.displayName, this.filePrefix);
}

/// Represents a complete assessment framework
class Framework {
  final FrameworkType type;
  final String name;
  final String description;
  final List<Domain> domains;
  final DateTime lastModified;

  Framework({
    required this.type,
    required this.name,
    required this.description,
    required this.domains,
    DateTime? lastModified,
  }) : lastModified = lastModified ?? DateTime.now();

  /// Calculate overall completion percentage
  double get completionPercentage {
    if (domains.isEmpty) return 0.0;

    int totalQuestions = 0;
    int answeredQuestions = 0;

    for (final domain in domains) {
      for (final subdomain in domain.subdomains) {
        for (final item in subdomain.items) {
          totalQuestions++;
          if (item.response != null && item.response! > 0) {
            answeredQuestions++;
          }
        }
      }
    }

    return totalQuestions == 0
        ? 0.0
        : (answeredQuestions / totalQuestions) * 100;
  }

  /// Get number of unanswered questions
  int get unansweredCount {
    int count = 0;
    for (final domain in domains) {
      for (final subdomain in domain.subdomains) {
        for (final item in subdomain.items) {
          if (item.response == null || item.response == 0) {
            count++;
          }
        }
      }
    }
    return count;
  }
}

/// Represents a domain within a framework
class Domain {
  final String id;
  final String name;
  final List<Subdomain> subdomains;

  Domain({required this.id, required this.name, required this.subdomains});

  /// Calculate average score for this domain (for spider graphs)
  double get averageScore {
    int totalScore = 0;
    int scoredItems = 0;

    for (final subdomain in subdomains) {
      for (final item in subdomain.items) {
        if (item.response != null && item.response! > 0) {
          totalScore += item.response!;
          scoredItems++;
        }
      }
    }

    return scoredItems == 0 ? 0.0 : totalScore / scoredItems;
  }

  /// Get completion status for this domain
  bool get isComplete {
    for (final subdomain in subdomains) {
      for (final item in subdomain.items) {
        if (item.response == null || item.response == 0) {
          return false;
        }
      }
    }
    return true;
  }
}

/// Represents a subdomain within a domain
class Subdomain {
  final String id;
  final String name;
  final List<AssessmentItem> items;

  Subdomain({required this.id, required this.name, required this.items});

  /// Calculate average score for this subdomain
  double get averageScore {
    int totalScore = 0;
    int scoredItems = 0;

    for (final item in items) {
      if (item.response != null && item.response! > 0) {
        totalScore += item.response!;
        scoredItems++;
      }
    }

    return scoredItems == 0 ? 0.0 : totalScore / scoredItems;
  }
}

/// Represents a single assessment question/item
class AssessmentItem {
  final String id;
  final String frameworkId;
  final String domain;
  final String subdomain;
  final String itemType;
  final String questionText;
  final int maturityLevel;
  final String responseType;
  final String? scoringNote;

  // User response data
  int? response; // 1-5 scale
  String? comment;
  DateTime? responseTimestamp;

  AssessmentItem({
    required this.id,
    required this.frameworkId,
    required this.domain,
    required this.subdomain,
    required this.itemType,
    required this.questionText,
    required this.maturityLevel,
    required this.responseType,
    this.scoringNote,
    this.response,
    this.comment,
    this.responseTimestamp,
  });

  /// Create from CSV row data
  factory AssessmentItem.fromCsvRow(Map<String, dynamic> row) {
    return AssessmentItem(
      id: row['item_id']?.toString() ?? '',
      frameworkId: row['framework_id']?.toString() ?? '',
      domain: row['domain']?.toString() ?? '',
      subdomain: row['subdomain']?.toString() ?? '',
      itemType: row['item_type']?.toString() ?? '',
      questionText:
          row['question_text']?.toString() ??
          row['text_english']?.toString() ??
          '',
      maturityLevel: _parseMaturityLevel(row['maturity_level']),
      responseType: row['response_type']?.toString() ?? '',
      scoringNote: row['scoring_note']?.toString(),
    );
  }

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

  /// Convert to CSV row for export
  Map<String, dynamic> toCsvRow() {
    return {
      'framework_id': frameworkId,
      'item_id': id,
      'domain': domain,
      'subdomain': subdomain,
      'response': response ?? '',
      'comment': comment ?? '',
      'timestamp': responseTimestamp?.toIso8601String() ?? '',
    };
  }

  /// Update response
  void setResponse(int? value, {String? comment}) {
    response = value;
    this.comment = comment;
    responseTimestamp = DateTime.now();
  }
}

/// Represents the entire session data
class AssessmentSession {
  final String sessionId;
  final DateTime createdAt;
  DateTime lastModified;

  // Organization info
  String? organizationName;
  String? assessorName;
  String? location;
  String? additionalNotes;

  // All frameworks in this session
  final Map<FrameworkType, Framework> frameworks;

  AssessmentSession({
    String? sessionId,
    DateTime? createdAt,
    this.organizationName,
    this.assessorName,
    this.location,
    this.additionalNotes,
    Map<FrameworkType, Framework>? frameworks,
  }) : sessionId =
           sessionId ?? DateTime.now().millisecondsSinceEpoch.toString(),
       createdAt = createdAt ?? DateTime.now(),
       lastModified = DateTime.now(),
       frameworks = frameworks ?? {};

  /// Get overall progress across all frameworks
  Map<FrameworkType, double> get progressByFramework {
    final progress = <FrameworkType, double>{};
    for (final entry in frameworks.entries) {
      progress[entry.key] = entry.value.completionPercentage;
    }
    return progress;
  }

  /// Export session to CSV format
  List<Map<String, dynamic>> exportToCsv() {
    final rows = <Map<String, dynamic>>[];

    // Add metadata row
    rows.add({
      'type': 'metadata',
      'session_id': sessionId,
      'created_at': createdAt.toIso8601String(),
      'last_modified': lastModified.toIso8601String(),
      'organization': organizationName ?? '',
      'assessor': assessorName ?? '',
      'location': location ?? '',
      'notes': additionalNotes ?? '',
    });

    // Add response rows
    for (final framework in frameworks.values) {
      for (final domain in framework.domains) {
        for (final subdomain in domain.subdomains) {
          for (final item in subdomain.items) {
            if (item.response != null && item.response! > 0) {
              rows.add({
                'type': 'response',
                'framework': framework.type.name,
                ...item.toCsvRow(),
              });
            }
          }
        }
      }
    }

    return rows;
  }

  /// Import session from CSV data
  static AssessmentSession fromCsvData(List<Map<String, dynamic>> rows) {
    // First row should be metadata
    final metadata = rows.firstWhere(
      (row) => row['type'] == 'metadata',
      orElse: () => {},
    );

    final session = AssessmentSession(
      sessionId: metadata['session_id'],
      createdAt: metadata['created_at'] != null
          ? DateTime.parse(metadata['created_at'])
          : DateTime.now(),
      organizationName: metadata['organization'],
      assessorName: metadata['assessor'],
      location: metadata['location'],
      additionalNotes: metadata['notes'],
    );

    // Process response rows
    // Note: This would need the actual framework structures to be loaded first
    // This is a placeholder for the import logic

    return session;
  }
}

/// Configuration for spider graph domains
class SpiderGraphConfig {
  final FrameworkType framework;
  final List<SpiderGraphDomain> domains;

  const SpiderGraphConfig({required this.framework, required this.domains});
}

class SpiderGraphDomain {
  final String name;
  final String displayName;
  final List<String>? subdomains; // For IS4H nested structure

  const SpiderGraphDomain({
    required this.name,
    required this.displayName,
    this.subdomains,
  });
}

// Spider graph configurations for each framework
const Map<FrameworkType, SpiderGraphConfig> spiderConfigs = {
  FrameworkType.bpmn: SpiderGraphConfig(
    framework: FrameworkType.bpmn,
    domains: [
      SpiderGraphDomain(
        name: 'institutional_standards',
        displayName: 'Institutional Standards/Guidelines/Policies',
      ),
      SpiderGraphDomain(
        name: 'stakeholder_management',
        displayName: 'Stakeholder Management',
      ),
      SpiderGraphDomain(
        name: 'adoption_processes',
        displayName: 'Adoption Processes',
      ),
      SpiderGraphDomain(
        name: 'privacy_security',
        displayName: 'Privacy, Security, Confidentiality',
      ),
      SpiderGraphDomain(
        name: 'skills_expertise',
        displayName: 'Skills and Expertise',
      ),
      SpiderGraphDomain(
        name: 'knowledge_assets',
        displayName: 'Knowledge Assets, Tools and Automation',
      ),
      SpiderGraphDomain(
        name: 'goals_measurement',
        displayName: 'Goals and Measurement',
      ),
    ],
  ),

  FrameworkType.eccmFacility: SpiderGraphConfig(
    framework: FrameworkType.eccmFacility,
    domains: [
      SpiderGraphDomain(
        name: 'hit_learning',
        displayName: 'HIT Learning Health System',
      ),
      SpiderGraphDomain(
        name: 'interoperability',
        displayName: 'Interoperability',
      ),
      SpiderGraphDomain(
        name: 'patient_centered',
        displayName: 'Patient Centeredness',
      ),
      SpiderGraphDomain(
        name: 'tech_resources',
        displayName: 'Management of Technical Resources',
      ),
      SpiderGraphDomain(
        name: 'data_quality',
        displayName: 'Data Ownership and Data Quality',
      ),
      SpiderGraphDomain(
        name: 'analytics',
        displayName: 'Analytics and Business Intelligence',
      ),
    ],
  ),

  FrameworkType.eccmOrganization: SpiderGraphConfig(
    framework: FrameworkType.eccmOrganization,
    domains: [
      SpiderGraphDomain(
        name: 'hit_learning',
        displayName: 'HIT Learning Health System',
      ),
      SpiderGraphDomain(
        name: 'interoperability',
        displayName: 'Interoperability',
      ),
      SpiderGraphDomain(
        name: 'patient_centered',
        displayName: 'Patient Centeredness',
      ),
      SpiderGraphDomain(
        name: 'tech_resources',
        displayName: 'Management of Technical Resources',
      ),
      SpiderGraphDomain(
        name: 'data_quality',
        displayName: 'Data Ownership and Data Quality',
      ),
      SpiderGraphDomain(
        name: 'analytics',
        displayName: 'Analytics and Business Intelligence',
      ),
    ],
  ),

  FrameworkType.adb: SpiderGraphConfig(
    framework: FrameworkType.adb,
    domains: [
      SpiderGraphDomain(name: 'core', displayName: 'Core Readiness'),
      SpiderGraphDomain(name: 'tech', displayName: 'Technological Readiness'),
      SpiderGraphDomain(name: 'learning', displayName: 'Learning Readiness'),
      SpiderGraphDomain(name: 'societal', displayName: 'Societal Readiness'),
    ],
  ),

  // IS4H Institutional - Has nested structure with domains and subdomains
  FrameworkType.is4hInstitutional: SpiderGraphConfig(
    framework: FrameworkType.is4hInstitutional,
    domains: [
      SpiderGraphDomain(
        name: 'dmit',
        displayName: 'Data Management and Information Technology',
        subdomains: [
          'Data Sources',
          'Information Products',
          'Standards for Quality and Interoperability',
          'Data Governance',
          'IT Infrastructure',
        ],
      ),
      SpiderGraphDomain(
        name: 'mago',
        displayName: 'Management and Governance',
        subdomains: [
          'Leadership',
          'Strategic Plans',
          'Organizational Structures',
          'Financial Resources',
          'Human Resources',
          'Multisectoral Collaboration',
          'Policy and Compliance',
          'Agreements',
        ],
      ),
      SpiderGraphDomain(
        name: 'kmsh',
        displayName: 'Knowledge Management and Sharing',
        subdomains: [
          'Knowledge Processes',
          'Knowledge Architecture',
          'Strategic Communications',
          'Social Participation',
          'Academic and Scientific Community',
          'Networks',
        ],
      ),
      SpiderGraphDomain(
        name: 'inno',
        displayName: 'Innovation',
        subdomains: [
          'Key Concepts',
          'Health Analysis for Decision Making',
          'Tools',
          'Digital Health',
          'E Government',
          'Open Government',
          'Preparedness and Resilience',
        ],
      ),
    ],
  ),

  // IS4H Country - Same structure as Institutional
  FrameworkType.is4hCountry: SpiderGraphConfig(
    framework: FrameworkType.is4hCountry,
    domains: [
      SpiderGraphDomain(
        name: 'dmit',
        displayName: 'Data Management and Information Technology',
        subdomains: [
          'Data Sources',
          'Information Products',
          'Standards for Quality and Interoperability',
          'Data Governance',
          'IT Infrastructure',
        ],
      ),
      SpiderGraphDomain(
        name: 'mago',
        displayName: 'Management and Governance',
        subdomains: [
          'Leadership',
          'Strategic Plans',
          'Organizational Structures',
          'Financial Resources',
          'Human Resources',
          'Multisectoral Collaboration',
          'Policy and Compliance',
          'Agreements',
        ],
      ),
      SpiderGraphDomain(
        name: 'kmsh',
        displayName: 'Knowledge Management and Sharing',
        subdomains: [
          'Knowledge Processes',
          'Knowledge Architecture',
          'Strategic Communications',
          'Social Participation',
          'Academic and Scientific Community',
          'Networks',
        ],
      ),
      SpiderGraphDomain(
        name: 'inno',
        displayName: 'Innovation',
        subdomains: [
          'Key Concepts',
          'Health Analysis for Decision Making',
          'Tools',
          'Digital Health',
          'E Government',
          'Open Government',
          'Preparedness and Resilience',
        ],
      ),
    ],
  ),
};
