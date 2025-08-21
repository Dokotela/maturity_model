// lib/models/framework_model.dart

import 'package:maturity_model/models/framework_type.dart' show FrameworkType;

/// Data class for spider graph points
class SpiderGraphPoint {
  final String label;
  final double value;
  final double maxValue;

  SpiderGraphPoint({
    required this.label,
    required this.value,
    required this.maxValue,
  });
}

/// Configuration for spider graph domains
class SpiderGraphConfig {
  final FrameworkType framework;
  final List<SpiderGraphDomain> domains;

  const SpiderGraphConfig({
    required this.framework,
    required this.domains,
  });
}

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

/// Spider graph configurations for each framework
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
  FrameworkType.bpmn: SpiderGraphConfig(
    framework: FrameworkType.bpmn,
    domains: [
      SpiderGraphDomain(
        name: 'Institutional Standards',
        displayName: 'Standards',
      ),
      SpiderGraphDomain(
        name: 'Stakeholder Management',
        displayName: 'Stakeholders',
      ),
      SpiderGraphDomain(
        name: 'Adoption Processes',
        displayName: 'Adoption',
      ),
      SpiderGraphDomain(
        name: 'Privacy Security',
        displayName: 'Security',
      ),
      SpiderGraphDomain(
        name: 'Skills and Expertise',
        displayName: 'Skills',
      ),
      SpiderGraphDomain(
        name: 'Knowledge Assets',
        displayName: 'Knowledge',
      ),
      SpiderGraphDomain(
        name: 'Goals and Measurement',
        displayName: 'Goals',
      ),
    ],
  ),
};
