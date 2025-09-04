// lib/widgets/frameworks.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:maturity_model/maturity_model.dart';

class FrameworkGrid extends ConsumerWidget {
  final bool isDesktop;
  final int gridColumns;
  final double childAspectRatio;

  const FrameworkGrid({
    super.key,
    required this.isDesktop,
    required this.gridColumns,
    required this.childAspectRatio,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Only watch what we need
    final completionMap = ref.watch(allFrameworksCompletionProvider);

    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final baseSpacing = textTheme.bodyMedium!.fontSize!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: baseSpacing * 1.5),
          child: Text(
            'Select IS4H Assessment Framework',
            style: textTheme.headlineLarge,
            textAlign: TextAlign.center,
          ),
        ),

        // Make the cards MUCH taller
        SizedBox(
          height: baseSpacing * 31.25,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: _FrameworkCard(
                  type: FrameworkType.is4hInstitutional,
                  completion:
                      completionMap[FrameworkType.is4hInstitutional] ?? 0.0,
                ),
              ),
              SizedBox(width: baseSpacing * 1.5),
              Expanded(
                child: _FrameworkCard(
                  type: FrameworkType.is4hCountry,
                  completion: completionMap[FrameworkType.is4hCountry] ?? 0.0,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// Individual framework card with ACTUALLY LARGE text
class _FrameworkCard extends ConsumerWidget {
  final FrameworkType type;
  final double completion;

  const _FrameworkCard({
    required this.type,
    required this.completion,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final framework = ref.watch(frameworkProvider(type));

    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final baseSpacing = textTheme.bodyMedium!.fontSize!;

    return Card(
      elevation: 6,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(baseSpacing * 1.25),
      ),
      child: InkWell(
        onTap: framework != null
            ? () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AssessmentScreen(
                      frameworkType: type,
                    ),
                  ),
                );
              }
            : null,
        borderRadius: BorderRadius.circular(baseSpacing * 1.25),
        child: Padding(
          padding: EdgeInsets.all(baseSpacing * 2),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // HUGE icon and title
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(baseSpacing * 1.25),
                    decoration: BoxDecoration(
                      color: theme.primaryColor.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(baseSpacing),
                    ),
                    child: Icon(
                      _getFrameworkIcon(type),
                      color: theme.primaryColor,
                      size: baseSpacing * 3.75,
                    ),
                  ),
                  SizedBox(width: baseSpacing * 1.5),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          type == FrameworkType.is4hInstitutional
                              ? 'Institutional'
                              : 'Country',
                          style: textTheme.headlineLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                        SizedBox(height: baseSpacing * 0.25),
                        Text(
                          type == FrameworkType.is4hInstitutional
                              ? 'Healthcare Facilities'
                              : 'National Health Systems',
                          style: textTheme.titleLarge?.copyWith(
                            color: Colors.grey[700],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              SizedBox(height: baseSpacing * 2),

              // LARGE readable description
              Expanded(
                child: Text(
                  _getFrameworkDescription(type),
                  style: textTheme.bodyLarge?.copyWith(
                    height: 1.6,
                    color: Colors.black87,
                  ),
                ),
              ),

              SizedBox(height: baseSpacing * 2),

              // BIG progress section
              Container(
                padding: EdgeInsets.all(baseSpacing * 1.25),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(baseSpacing * 0.75),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Completion',
                          style: textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.w600,
                            color: Colors.black87,
                          ),
                        ),
                        Text(
                          '${completion.toStringAsFixed(1)}%',
                          style: textTheme.headlineLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: _getColorForCompletion(completion),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: baseSpacing * 0.75),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(baseSpacing * 0.375),
                      child: LinearProgressIndicator(
                        value: completion / 100,
                        backgroundColor: Colors.grey[300],
                        valueColor: AlwaysStoppedAnimation<Color>(
                          _getColorForCompletion(completion),
                        ),
                        minHeight: baseSpacing,
                      ),
                    ),
                    if (framework != null && framework.unansweredCount > 0) ...[
                      SizedBox(height: baseSpacing * 0.75),
                      Text(
                        '${framework.unansweredCount} questions remaining',
                        style: textTheme.bodyLarge?.copyWith(
                          color: Colors.grey[700],
                        ),
                      ),
                    ],
                  ],
                ),
              ),

              SizedBox(height: baseSpacing * 2),

              // LARGE button
              SizedBox(
                width: double.infinity,
                height: baseSpacing * 4.375,
                child: ElevatedButton(
                  onPressed: framework != null
                      ? () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AssessmentScreen(
                                frameworkType: type,
                              ),
                            ),
                          );
                        }
                      : null,
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(baseSpacing * 0.75),
                    ),
                    backgroundColor: theme.primaryColor,
                    foregroundColor: Colors.white,
                    elevation: 2,
                  ),
                  child: Text(
                    completion > 0 ? 'Continue Assessment' : 'Start Assessment',
                    style: textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  IconData _getFrameworkIcon(FrameworkType type) {
    switch (type) {
      case FrameworkType.is4hInstitutional:
        return Icons.local_hospital;
      case FrameworkType.is4hCountry:
        return Icons.flag;
    }
  }

  String _getFrameworkDescription(FrameworkType type) {
    switch (type) {
      case FrameworkType.is4hInstitutional:
        return 'Comprehensive assessment for healthcare facilities, hospitals, and institutions to evaluate information systems maturity across key domains.';
      case FrameworkType.is4hCountry:
        return 'National and regional framework for evaluating country-level health information systems readiness and implementation maturity.';
    }
  }

  Color _getColorForCompletion(double completion) {
    if (completion == 0) return Colors.grey[600]!;
    if (completion < 25) return Colors.red;
    if (completion < 50) return Colors.orange;
    if (completion < 75) return Colors.amber[700]!;
    return Colors.green;
  }
}
