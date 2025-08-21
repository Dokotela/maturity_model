import 'package:maturity_model/models/framework.dart' show Framework;
import 'package:maturity_model/models/framework_type.dart' show FrameworkType;

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
  })  : sessionId =
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

  /// Create a copy of this session with optional updated fields
  AssessmentSession copyWith({
    String? sessionId,
    DateTime? createdAt,
    DateTime? lastModified,
    String? organizationName,
    String? assessorName,
    String? location,
    String? additionalNotes,
    Map<FrameworkType, Framework>? frameworks,
  }) {
    return AssessmentSession(
      sessionId: sessionId ?? this.sessionId,
      createdAt: createdAt ?? this.createdAt,
      organizationName: organizationName ?? this.organizationName,
      assessorName: assessorName ?? this.assessorName,
      location: location ?? this.location,
      additionalNotes: additionalNotes ?? this.additionalNotes,
      frameworks: frameworks ?? this.frameworks,
    )..lastModified = lastModified ?? this.lastModified;
  }
}
