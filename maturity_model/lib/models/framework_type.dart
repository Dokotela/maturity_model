// lib/models/framework_type.dart

/// Enum representing different framework types
/// For workshop: Only IS4H frameworks are enabled
enum FrameworkType {
  is4hInstitutional,
  is4hCountry;

  String get displayName {
    switch (this) {
      case FrameworkType.is4hInstitutional:
        return 'IS4H Institutional';
      case FrameworkType.is4hCountry:
        return 'IS4H Country';
    }
  }

  String get description {
    switch (this) {
      case FrameworkType.is4hInstitutional:
        return 'Information Systems for Health - Institutional Level Assessment';
      case FrameworkType.is4hCountry:
        return 'Information Systems for Health - Country Level Assessment';
    }
  }

  String get shortName {
    switch (this) {
      case FrameworkType.is4hInstitutional:
        return 'Institutional';
      case FrameworkType.is4hCountry:
        return 'Country';
    }
  }

  /// Get the icon for this framework type
  String get iconName {
    switch (this) {
      case FrameworkType.is4hInstitutional:
        return 'local_hospital';
      case FrameworkType.is4hCountry:
        return 'flag';
    }
  }
}
