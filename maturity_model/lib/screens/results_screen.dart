// lib/screens/results_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:maturity_model/maturity_model.dart'
    show
        FrameworkType,
        allFrameworksCompletionProvider,
        Framework,
        SpiderChartResult,
        frameworkProvider,
        ScoringService,
        SpiderChart;

class ResultsScreen extends StatelessWidget {
  const ResultsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Results & Analytics'),
      ),
      body: const _ResultsBody(),
    );
  }
}

// Separate body widget that watches providers
class _ResultsBody extends ConsumerWidget {
  const _ResultsBody();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final completionMap = ref.watch(allFrameworksCompletionProvider);

    // Calculate statistics once
    final activeFrameworks =
        completionMap.entries.where((e) => e.value > 0).toList();

    final overallAverage = activeFrameworks.isEmpty
        ? 0.0
        : activeFrameworks.fold(0.0, (sum, e) => sum + e.value) /
            activeFrameworks.length;

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        // Overall Progress Card
        _OverallProgressCard(
          overallAverage: overallAverage,
          activeCount: activeFrameworks.length,
          totalCount: FrameworkType.values.length,
        ),

        const SizedBox(height: 16),

        // Individual Framework Results
        Text(
          'Framework Results',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: 12),

        if (activeFrameworks.isEmpty)
          const _EmptyStateMessage()
        else
          ...activeFrameworks.map((entry) => _FrameworkResultTile(
                frameworkType: entry.key,
                completion: entry.value,
              )),
      ],
    );
  }
}

// Overall progress card - doesn't watch providers
class _OverallProgressCard extends StatelessWidget {
  final double overallAverage;
  final int activeCount;
  final int totalCount;

  const _OverallProgressCard({
    required this.overallAverage,
    required this.activeCount,
    required this.totalCount,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Overall Progress',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${overallAverage.toStringAsFixed(1)}%',
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium
                            ?.copyWith(
                              color: _getColorForCompletion(overallAverage),
                            ),
                      ),
                      Text(
                        '$activeCount of $totalCount frameworks started',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                ),
                CircularProgressIndicator(
                  value: overallAverage / 100,
                  backgroundColor: Colors.grey[300],
                  valueColor: AlwaysStoppedAnimation<Color>(
                    _getColorForCompletion(overallAverage),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Color _getColorForCompletion(double completion) {
    if (completion < 25) return Colors.red;
    if (completion < 50) return Colors.orange;
    if (completion < 75) return Colors.yellow[700]!;
    return Colors.green;
  }
}

// Individual framework result tile
class _FrameworkResultTile extends ConsumerWidget {
  final FrameworkType frameworkType;
  final double completion;

  const _FrameworkResultTile({
    required this.frameworkType,
    required this.completion,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final framework = ref.watch(frameworkProvider(frameworkType));

    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        title: Text(frameworkType.displayName),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 8),
            LinearProgressIndicator(
              value: completion / 100,
              backgroundColor: Colors.grey[300],
              valueColor: AlwaysStoppedAnimation<Color>(
                _getColorForCompletion(completion),
              ),
            ),
          ],
        ),
        trailing: Text(
          '${completion.toStringAsFixed(1)}%',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: _getColorForCompletion(completion),
                fontWeight: FontWeight.bold,
              ),
        ),
        onTap: framework != null && completion > 0
            ? () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => FrameworkResultDetailScreen(
                      frameworkType: frameworkType,
                      framework: framework,
                    ),
                  ),
                );
              }
            : null,
      ),
    );
  }

  Color _getColorForCompletion(double completion) {
    if (completion < 25) return Colors.red;
    if (completion < 50) return Colors.orange;
    if (completion < 75) return Colors.yellow[700]!;
    return Colors.green;
  }
}

// Empty state message
class _EmptyStateMessage extends StatelessWidget {
  const _EmptyStateMessage();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Padding(
        padding: EdgeInsets.all(32),
        child: Text(
          'No assessments started yet.\nSelect an assessment to begin.',
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.grey),
        ),
      ),
    );
  }
}

/// Detailed results screen for a specific framework showing spider charts
class FrameworkResultDetailScreen extends StatelessWidget {
  final FrameworkType frameworkType;
  final Framework framework;

  const FrameworkResultDetailScreen({
    super.key,
    required this.frameworkType,
    required this.framework,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${frameworkType.displayName} Results'),
      ),
      body: _FrameworkResultDetailBody(
        frameworkType: frameworkType,
        framework: framework,
      ),
    );
  }
}

class _FrameworkResultDetailBody extends StatelessWidget {
  final FrameworkType frameworkType;
  final Framework framework;

  const _FrameworkResultDetailBody({
    required this.frameworkType,
    required this.framework,
  });

  @override
  Widget build(BuildContext context) {
    final scoringService = ScoringService();
    final spiderChartResults =
        scoringService.getSpiderChartData(frameworkType, framework);

    // Responsive layout
    return LayoutBuilder(
      builder: (context, constraints) {
        final isWideScreen = constraints.maxWidth > 800;
        final crossAxisCount = isWideScreen ? 2 : 1;
        final chartSize = isWideScreen ? 350.0 : 300.0;

        return SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Summary card
              _ResultsSummaryCard(
                frameworkType: frameworkType,
                framework: framework,
                spiderChartResults: spiderChartResults,
              ),

              const SizedBox(height: 24),

              // Spider charts
              if (spiderChartResults.isNotEmpty) ...[
                Text(
                  'Assessment Results',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 16),
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: crossAxisCount,
                    childAspectRatio: 1.0,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                  ),
                  itemCount: spiderChartResults.length,
                  itemBuilder: (context, index) {
                    final result = spiderChartResults[index];
                    return _SpiderChartCard(
                      result: result,
                      chartSize: chartSize,
                    );
                  },
                ),
              ],
            ],
          ),
        );
      },
    );
  }
}

/// Summary card showing overall framework statistics
class _ResultsSummaryCard extends StatelessWidget {
  final FrameworkType frameworkType;
  final Framework framework;
  final List<SpiderChartResult> spiderChartResults;

  const _ResultsSummaryCard({
    required this.frameworkType,
    required this.framework,
    required this.spiderChartResults,
  });

  @override
  Widget build(BuildContext context) {
    final completion = framework.completionPercentage;
    final overallScore = spiderChartResults.isNotEmpty
        ? spiderChartResults.last.overallScore
        : 0.0;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Assessment Summary',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: _SummaryMetric(
                    label: 'Completion',
                    value: '${completion.toStringAsFixed(1)}%',
                    color: _getColorForCompletion(completion),
                  ),
                ),
                Expanded(
                  child: _SummaryMetric(
                    label: 'Average Score',
                    value: '${overallScore.toStringAsFixed(1)}/5.0',
                    color: _getColorForScore(overallScore),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: _SummaryMetric(
                    label: 'Domains',
                    value: '${framework.domains.length}',
                    color: Colors.blue,
                  ),
                ),
                Expanded(
                  child: _SummaryMetric(
                    label: 'Questions Answered',
                    value:
                        '${_getAnsweredCount(framework)}/${_getTotalItemCount(framework)}',
                    color: Colors.green,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Color _getColorForCompletion(double completion) {
    if (completion < 25) return Colors.red;
    if (completion < 50) return Colors.orange;
    if (completion < 75) return Colors.amber;
    return Colors.green;
  }

  Color _getColorForScore(double score) {
    if (score < 2) return Colors.red;
    if (score < 3) return Colors.orange;
    if (score < 4) return Colors.amber;
    return Colors.green;
  }

  /// Calculate answered count for a framework
  int _getAnsweredCount(Framework framework) {
    int count = 0;
    for (final domain in framework.domains) {
      for (final subdomain in domain.subdomains) {
        for (final item in subdomain.items) {
          if (item.response != null && item.response! > 0) {
            count++;
          }
        }
      }
    }
    return count;
  }

  /// Calculate total item count for a framework
  int _getTotalItemCount(Framework framework) {
    int count = 0;
    for (final domain in framework.domains) {
      for (final subdomain in domain.subdomains) {
        count += subdomain.items.length;
      }
    }
    return count;
  }
}

class _SummaryMetric extends StatelessWidget {
  final String label;
  final String value;
  final Color color;

  const _SummaryMetric({
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Colors.grey[600],
              ),
        ),
        Text(
          value,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: color,
                fontWeight: FontWeight.bold,
              ),
        ),
      ],
    );
  }
}

/// Individual spider chart card
class _SpiderChartCard extends StatelessWidget {
  final SpiderChartResult result;
  final double chartSize;

  const _SpiderChartCard({
    required this.result,
    required this.chartSize,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              result.title,
              style: Theme.of(context).textTheme.titleSmall,
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 8),
            Text(
              'Average: ${result.overallScore.toStringAsFixed(1)}/5.0',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Colors.grey[600],
                  ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: Center(
                child: SpiderChart(
                  dataPoints: result.dataPoints,
                  size: chartSize * 0.8,
                  showValues: true,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
