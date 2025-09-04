// lib/config/spider_graph.dart

import 'package:maturity_model/maturity_model.dart' show FrameworkType;

/// Configuration for spider graph visualization
class SpiderGraphConfig {
  final FrameworkType framework;
  final List<SpiderGraphDomain> domains;

  const SpiderGraphConfig({
    required this.framework,
    required this.domains,
  });
}

/// Represents a domain in the spider graph
class SpiderGraphDomain {
  final String name;
  final String displayName;
  final List<String>? subdomains;

  const SpiderGraphDomain({
    required this.name,
    required this.displayName,
    this.subdomains,
  });
}

/// Spider graph configurations for IS4H frameworks only
final Map<FrameworkType, SpiderGraphConfig> spiderConfigs = {
  FrameworkType.is4hInstitutional: SpiderGraphConfig(
    framework: FrameworkType.is4hInstitutional,
    domains: [
      SpiderGraphDomain(
        name: 'Management and Governance',
        displayName: 'Management',
        subdomains: ['Policy', 'Planning', 'Finance'],
      ),
      SpiderGraphDomain(
        name: 'Data Management and Information Technology',
        displayName: 'Data & IT',
        subdomains: ['Infrastructure', 'Applications', 'Standards'],
      ),
      SpiderGraphDomain(
        name: 'Knowledge Management and Sharing',
        displayName: 'Knowledge',
        subdomains: ['Capture', 'Sharing', 'Use'],
      ),
      SpiderGraphDomain(
        name: 'Innovation',
        displayName: 'Innovation',
        subdomains: ['Culture', 'Resources', 'Implementation'],
      ),
    ],
  ),
  FrameworkType.is4hCountry: SpiderGraphConfig(
    framework: FrameworkType.is4hCountry,
    domains: [
      SpiderGraphDomain(
        name: 'Management and Governance',
        displayName: 'Management',
        subdomains: ['Policy', 'Planning', 'Finance'],
      ),
      SpiderGraphDomain(
        name: 'Data Management and Information Technology',
        displayName: 'Data & IT',
        subdomains: ['Infrastructure', 'Applications', 'Standards'],
      ),
      SpiderGraphDomain(
        name: 'Knowledge Management and Sharing',
        displayName: 'Knowledge',
        subdomains: ['Capture', 'Sharing', 'Use'],
      ),
      SpiderGraphDomain(
        name: 'Innovation',
        displayName: 'Innovation',
        subdomains: ['Culture', 'Resources', 'Implementation'],
      ),
    ],
  ),
};
