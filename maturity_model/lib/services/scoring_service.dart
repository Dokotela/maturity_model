// lib/services/scoring_service.dart

// ignore_for_file: avoid_print

import 'dart:math' as math;

import 'package:maturity_model/maturity_model.dart'
    show
        SpiderChartConfig,
        Framework,
        Domain,
        Subdomain,
        FrameworkType,
        SpiderChartDataPoint;

/// Service for calculating scores and generating spider chart data
class ScoringService {
  static final ScoringService _instance = ScoringService._internal();
  factory ScoringService() => _instance;
  ScoringService._internal();

  /// DEBUG: Calculate domain scores for a given framework with logging
  Map<String, double> calculateDomainScores(Framework framework) {
    final Map<String, double> domainScores = {};

    print('=== DOMAIN SCORING DEBUG ===');
    print('Framework: ${framework.name}');
    print('Total domains: ${framework.domains.length}');

    for (final domain in framework.domains) {
      final score = _calculateDomainScore(domain);
      domainScores[domain.name] = score;

      print('Domain: "${domain.name}" -> Score: $score');
      print('  Subdomains: ${domain.subdomains.length}');

      for (final subdomain in domain.subdomains) {
        final subScore = _calculateSubdomainScore(subdomain);
        print('    Subdomain: "${subdomain.name}" -> Score: $subScore');
        print('      Items: ${subdomain.items.length}');

        for (final item in subdomain.items) {
          final response = item.response ?? 0;
          print(
              '        Item: "${item.questionText.substring(0, math.min(50, item.questionText.length))}..." -> Response: $response');
        }
      }
    }

    print('Final domain scores: $domainScores');
    print('=== END DEBUG ===');

    return domainScores;
  }

  /// Calculate subdomain scores for a given domain (used for IS4H individual domain charts)
  Map<String, double> calculateSubdomainScores(Domain domain) {
    final Map<String, double> subdomainScores = {};

    for (final subdomain in domain.subdomains) {
      final score = _calculateSubdomainScore(subdomain);
      subdomainScores[subdomain.name] = score;
    }

    return subdomainScores;
  }

  /// Calculate score for a single domain
  double _calculateDomainScore(Domain domain) {
    if (domain.subdomains.isEmpty) return 0.0;

    double totalScore = 0.0;
    int totalSubdomains = 0;

    for (final subdomain in domain.subdomains) {
      final subdomainScore = _calculateSubdomainScore(subdomain);
      if (subdomainScore > 0) {
        totalScore += subdomainScore;
        totalSubdomains++;
      }
    }

    return totalSubdomains > 0 ? totalScore / totalSubdomains : 0.0;
  }

  /// Calculate score for a single subdomain
  double _calculateSubdomainScore(Subdomain subdomain) {
    if (subdomain.items.isEmpty) return 0.0;

    final answeredItems = subdomain.items
        .where((item) => item.response != null && item.response! > 0)
        .toList();

    if (answeredItems.isEmpty) return 0.0;

    final totalScore =
        answeredItems.fold(0.0, (sum, item) => sum + item.response!);
    return totalScore / answeredItems.length;
  }

  /// Get spider chart data for different framework types
  List<SpiderChartResult> getSpiderChartData(
      FrameworkType frameworkType, Framework framework) {
    switch (frameworkType) {
      case FrameworkType.bpmn:
        return _getBpmnSpiderCharts(framework);
      case FrameworkType.adb:
        return _getAdbSpiderCharts(framework);
      case FrameworkType.eccmFacility:
      case FrameworkType.eccmOrganization:
        return _getEccmSpiderCharts(framework);
      case FrameworkType.is4hInstitutional:
      case FrameworkType.is4hCountry:
        return _getIs4hSpiderCharts(framework);
    }
  }

  List<SpiderChartResult> _getBpmnSpiderCharts(Framework framework) {
    final domainScores = calculateDomainScores(framework);
    final dataPoints = SpiderChartConfig.getDataPointsForFramework(
      FrameworkType.bpmn,
      domainScores,
    );

    return [
      SpiderChartResult(
        title: 'BPM+ Clinical Practice Guideline Assessment',
        dataPoints: dataPoints,
        overallScore: _calculateOverallScore(domainScores),
      ),
    ];
  }

  List<SpiderChartResult> _getAdbSpiderCharts(Framework framework) {
    final domainScores = calculateDomainScores(framework);
    final dataPoints = SpiderChartConfig.getDataPointsForFramework(
      FrameworkType.adb,
      domainScores,
    );

    return [
      SpiderChartResult(
        title: 'ADB Digital Health Readiness',
        dataPoints: dataPoints,
        overallScore: _calculateOverallScore(domainScores),
      ),
    ];
  }

  List<SpiderChartResult> _getEccmSpiderCharts(Framework framework) {
    final domainScores = calculateDomainScores(framework);
    final dataPoints = SpiderChartConfig.getDataPointsForFramework(
      framework.type,
      domainScores,
    );

    final title = framework.type == FrameworkType.eccmFacility
        ? 'ECCM Facility Assessment'
        : 'ECCM Organization Assessment';

    return [
      SpiderChartResult(
        title: title,
        dataPoints: dataPoints,
        overallScore: _calculateOverallScore(domainScores),
      ),
    ];
  }

  List<SpiderChartResult> _getIs4hSpiderCharts(Framework framework) {
    final List<SpiderChartResult> results = [];

    // Create individual domain charts
    for (final domain in framework.domains) {
      final subdomainScores = calculateSubdomainScores(domain);
      final dataPoints = subdomainScores.entries
          .map((entry) => SpiderChartDataPoint(
                label: _truncateLabel(entry.key),
                value: entry.value,
                maxValue: 5.0,
              ))
          .toList();

      results.add(SpiderChartResult(
        title: domain.name,
        dataPoints: dataPoints,
        overallScore: _calculateOverallScore(subdomainScores),
      ));
    }

    // Create overall domain chart
    final domainScores = calculateDomainScores(framework);
    final overallDataPoints = SpiderChartConfig.getDataPointsForFramework(
      framework.type,
      domainScores,
    );

    results.add(SpiderChartResult(
      title: 'IS4H Overall Assessment',
      dataPoints: overallDataPoints,
      overallScore: _calculateOverallScore(domainScores),
      isOverallChart: true,
    ));

    return results;
  }

  /// Calculate overall score from domain scores
  double _calculateOverallScore(Map<String, double> scores) {
    if (scores.isEmpty) return 0.0;

    final validScores = scores.values.where((score) => score > 0).toList();
    if (validScores.isEmpty) return 0.0;

    return validScores.fold(0.0, (sum, score) => sum + score) /
        validScores.length;
  }

  /// Truncate long labels to fit better on the chart
  String _truncateLabel(String label) {
    if (label.length <= 25) return label;
    return '${label.substring(0, 22)}...';
  }
}

/// Result data for spider chart
class SpiderChartResult {
  final String title;
  final List<SpiderChartDataPoint> dataPoints;
  final double overallScore;
  final bool isOverallChart;

  const SpiderChartResult({
    required this.title,
    required this.dataPoints,
    required this.overallScore,
    this.isOverallChart = false,
  });
}
