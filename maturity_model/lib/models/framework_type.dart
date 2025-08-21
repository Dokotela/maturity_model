/// Enum representing different framework types
enum FrameworkType {
  bpmn,
  adb,
  eccmFacility,
  eccmOrganization,
  is4hInstitutional,
  is4hCountry,
  ;

  String get displayName {
    switch (this) {
      case FrameworkType.bpmn:
        return 'BPM+ Clinical Practice';
      case FrameworkType.adb:
        return 'ADB Digital Health';
      case FrameworkType.eccmFacility:
        return 'ECCM Facility';
      case FrameworkType.eccmOrganization:
        return 'ECCM Organization';
      case FrameworkType.is4hInstitutional:
        return 'IS4H Institutional';
      case FrameworkType.is4hCountry:
        return 'IS4H Country';
    }
  }

  String get description {
    switch (this) {
      case FrameworkType.bpmn:
        return 'Business Process Model for Clinical Guidelines';
      case FrameworkType.adb:
        return 'Asian Development Bank Digital Health Readiness';
      case FrameworkType.eccmFacility:
        return 'Essential Care for Every Child - Facility Assessment';
      case FrameworkType.eccmOrganization:
        return 'Essential Care for Every Child - Organization Assessment';
      case FrameworkType.is4hInstitutional:
        return 'Information Systems for Health - Institutional Level Assessment';
      case FrameworkType.is4hCountry:
        return 'Information Systems for Health - Country Level Assessment';
    }
  }
}
