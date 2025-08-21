// lib/screens/results_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:maturity_model/maturity_model.dart';

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
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 200,
              child: Center(
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    SizedBox(
                      width: 150,
                      height: 150,
                      child: CircularProgressIndicator(
                        value: overallAverage / 100,
                        strokeWidth: 15,
                        backgroundColor: Colors.grey[300],
                        valueColor: AlwaysStoppedAnimation<Color>(
                          _getColorForCompletion(overallAverage),
                        ),
                      ),
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          '${overallAverage.toStringAsFixed(1)}%',
                          style: Theme.of(context).textTheme.headlineMedium,
                        ),
                        Text(
                          'Complete',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 8),
            Center(
              child: Text(
                '$activeCount of $totalCount frameworks started',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
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
class _FrameworkResultTile extends StatelessWidget {
  final FrameworkType frameworkType;
  final double completion;

  const _FrameworkResultTile({
    required this.frameworkType,
    required this.completion,
  });

  @override
  Widget build(BuildContext context) {
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
        onTap: () {
          // TODO: Navigate to detailed results view with spider graph
        },
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
