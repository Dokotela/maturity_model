import 'package:maturity_model/models/subdomain.dart' show Subdomain;

/// Represents a domain within a framework
class Domain {
  final String id;
  final String name;
  final List<Subdomain> subdomains;

  Domain({
    required this.id,
    required this.name,
    required this.subdomains,
  });

  /// Calculate average score for this domain
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
