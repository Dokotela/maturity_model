import 'package:maturity_model/models/assessment_item.dart' show AssessmentItem;

/// Represents a subdomain within a domain
class Subdomain {
  final String id;
  final String name;
  final List<AssessmentItem> items;

  Subdomain({
    required this.id,
    required this.name,
    required this.items,
  });

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
