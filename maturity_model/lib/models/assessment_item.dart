/// Represents a single assessment question/item
class AssessmentItem {
  final String id;
  final String frameworkId;
  final String domain;
  final String subdomain;
  final String itemType;
  final String questionText;
  final int? maturityLevel; // For ECCM items that have a specific level
  final String responseType;
  final String? scoringNote;

  // For maturity scale questions (IS4H, BPMN)
  final Map<int, String>? maturityDescriptions;

  // User response data
  int? response;
  String? comment;
  DateTime? responseTimestamp;

  AssessmentItem({
    required this.id,
    required this.frameworkId,
    required this.domain,
    required this.subdomain,
    required this.itemType,
    required this.questionText,
    this.maturityLevel,
    required this.responseType,
    this.scoringNote,
    this.maturityDescriptions,
    this.response,
    this.comment,
    this.responseTimestamp,
  });

  /// Check if this item has maturity descriptions
  bool get hasMaturityDescriptions =>
      maturityDescriptions != null && maturityDescriptions!.isNotEmpty;

  /// Get description for a specific maturity level
  String? getMaturityDescription(int level) => maturityDescriptions?[level];

  /// Update response
  void setResponse(int? value, {String? comment}) {
    response = value;
    this.comment = comment;
    responseTimestamp = DateTime.now();
  }

  /// Create a copy with updated values
  AssessmentItem copyWith({
    Map<int, String>? maturityDescriptions,
  }) {
    return AssessmentItem(
      id: id,
      frameworkId: frameworkId,
      domain: domain,
      subdomain: subdomain,
      itemType: itemType,
      questionText: questionText,
      maturityLevel: maturityLevel,
      responseType: responseType,
      scoringNote: scoringNote,
      maturityDescriptions: maturityDescriptions ?? this.maturityDescriptions,
      response: response,
      comment: comment,
      responseTimestamp: responseTimestamp,
    );
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
}
