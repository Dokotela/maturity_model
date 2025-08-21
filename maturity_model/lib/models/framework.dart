import 'package:maturity_model/models/domain.dart' show Domain;
import 'package:maturity_model/models/framework_type.dart' show FrameworkType;

/// Represents a complete framework
class Framework {
  final FrameworkType type;
  final String name;
  final String description;
  final List<Domain> domains;
  DateTime lastModified;

  Framework({
    required this.type,
    required this.name,
    required this.description,
    required this.domains,
    DateTime? lastModified,
  }) : lastModified = lastModified ?? DateTime.now();

  /// Calculate overall completion percentage
  double get completionPercentage {
    int totalItems = 0;
    int answeredItems = 0;

    for (final domain in domains) {
      for (final subdomain in domain.subdomains) {
        for (final item in subdomain.items) {
          totalItems++;
          if (item.response != null && item.response! > 0) {
            answeredItems++;
          }
        }
      }
    }

    return totalItems == 0 ? 0.0 : (answeredItems / totalItems) * 100;
  }

  /// Get count of unanswered questions
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

  /// Calculate average score (1-5 scale)
  double get averageScore {
    int totalScore = 0;
    int scoredItems = 0;

    for (final domain in domains) {
      for (final subdomain in domain.subdomains) {
        for (final item in subdomain.items) {
          if (item.response != null && item.response! > 0) {
            totalScore += item.response!;
            scoredItems++;
          }
        }
      }
    }

    return scoredItems == 0 ? 0.0 : totalScore / scoredItems;
  }
}
