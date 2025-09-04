// lib/providers/session_provider.dart

// ignore_for_file: avoid_print

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:maturity_model/maturity_model.dart'
    show
        CsvLoaderService,
        CsvExportService,
        AssessmentSession,
        FrameworkType,
        Framework,
        SessionNotifier,
        SpiderChartDataPoint,
        spiderConfigs;

/// Provider for the CSV loader service
final csvLoaderProvider = Provider<CsvLoaderService>((ref) {
  return CsvLoaderService();
});

/// Provider for the CSV export service
final csvExportProvider = Provider<CsvExportService>((ref) {
  return CsvExportService();
});

/// Main session state provider
final sessionProvider =
    StateNotifierProvider<SessionNotifier, AssessmentSession>((ref) {
  return SessionNotifier(ref);
});

// Computed providers for specific framework data

/// Provider for getting a specific framework
final frameworkProvider =
    Provider.family<Framework?, FrameworkType>((ref, type) {
  final session = ref.watch(sessionProvider);
  return session.frameworks[type];
});

/// Provider for framework completion percentage
final frameworkCompletionProvider =
    Provider.family<double, FrameworkType>((ref, type) {
  final framework = ref.watch(frameworkProvider(type));
  return framework?.completionPercentage ?? 0.0;
});

/// Provider for all framework completion statuses
final allFrameworksCompletionProvider =
    Provider<Map<FrameworkType, double>>((ref) {
  final session = ref.watch(sessionProvider);
  return session.progressByFramework;
});

/// Provider for spider graph data for IS4H frameworks
final spiderGraphDataProvider =
    Provider.family<List<SpiderChartDataPoint>, FrameworkType>((ref, type) {
  final framework = ref.watch(frameworkProvider(type));
  if (framework == null) return [];

  final config = spiderConfigs[type];
  if (config == null) return [];

  final points = <SpiderChartDataPoint>[];

  for (final configDomain in config.domains) {
    double score = 0.0;
    int count = 0;

    // IS4H frameworks have subdomains in the config
    for (final domain in framework.domains) {
      if (domain.name.toLowerCase().contains(configDomain.name.toLowerCase()) ||
          domain.id.toLowerCase().contains(configDomain.name.toLowerCase())) {
        if (configDomain.subdomains != null &&
            configDomain.subdomains!.isNotEmpty) {
          // Calculate score based on matching subdomains
          for (final subdomain in domain.subdomains) {
            for (final configSubdomain in configDomain.subdomains!) {
              if (subdomain.name
                  .toLowerCase()
                  .contains(configSubdomain.toLowerCase())) {
                final subScore = subdomain.averageScore;
                if (subScore > 0) {
                  score += subScore;
                  count++;
                }
                break;
              }
            }
          }
        } else {
          // Use overall domain average if no specific subdomains in config
          final domainScore = domain.averageScore;
          if (domainScore > 0) {
            score += domainScore;
            count++;
          }
        }
      }
    }

    points.add(SpiderChartDataPoint(
      label: configDomain.displayName,
      value: count > 0 ? score / count : 0.0,
      maxValue: 5.0,
    ));
  }

  return points;
});
