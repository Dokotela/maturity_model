// Separate widget for framework grid - only this watches providers
import 'package:flutter/material.dart'
    show
        Widget,
        BuildContext,
        SizedBox,
        NeverScrollableScrollPhysics,
        EdgeInsets,
        TextStyle,
        IconData,
        Color,
        BoxConstraints,
        CrossAxisAlignment,
        Theme,
        Text,
        GridView,
        SliverGridDelegateWithFixedCrossAxisCount,
        Column,
        ConstrainedBox,
        Center,
        Navigator,
        MaterialPageRoute,
        BorderRadius,
        Icon,
        FontWeight,
        TextOverflow,
        Expanded,
        Row,
        Colors,
        LinearProgressIndicator,
        MainAxisAlignment,
        Padding,
        InkWell,
        Card,
        Icons;
import 'package:flutter_riverpod/flutter_riverpod.dart'
    show ConsumerWidget, WidgetRef;
import 'package:maturity_model/maturity_model.dart'
    show
        allFrameworksCompletionProvider,
        FrameworkType,
        frameworkProvider,
        AssessmentScreen;

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

    return Center(
      child: ConstrainedBox(
        constraints:
            BoxConstraints(maxWidth: isDesktop ? 1200 : double.infinity),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Select Assessment Framework',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),

            // Framework cards in grid layout
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: gridColumns,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: childAspectRatio,
              ),
              itemCount: FrameworkType.values.length,
              itemBuilder: (context, index) {
                final type = FrameworkType.values[index];
                return _FrameworkCard(
                  type: type,
                  completion: completionMap[type] ?? 0.0,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

// Individual framework card - watches only its specific framework
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

    return Card(
      elevation: 2,
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
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Icon and title row
              Row(
                children: [
                  Icon(
                    _getFrameworkIcon(type),
                    color: Theme.of(context).primaryColor,
                    size: 24,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      type.displayName,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),

              // Description
              Expanded(
                child: Text(
                  _getFrameworkDescription(type),
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),

              const SizedBox(height: 8),

              // Progress indicator
              LinearProgressIndicator(
                value: completion / 100,
                backgroundColor: Colors.grey[300],
                minHeight: 4,
              ),
              const SizedBox(height: 4),

              // Completion text
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${completion.toStringAsFixed(0)}%',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: _getColorForCompletion(completion),
                    ),
                  ),
                  if (framework != null && framework.unansweredCount > 0)
                    Text(
                      '${framework.unansweredCount} left',
                      style: TextStyle(
                        fontSize: 11,
                        color: Colors.grey[600],
                      ),
                    ),
                ],
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
      case FrameworkType.eccmFacility:
        return Icons.business;
      case FrameworkType.eccmOrganization:
        return Icons.corporate_fare;
      case FrameworkType.bpmn:
        return Icons.account_tree;
      case FrameworkType.adb:
        return Icons.trending_up;
    }
  }

  String _getFrameworkDescription(FrameworkType type) {
    switch (type) {
      case FrameworkType.is4hInstitutional:
        return 'For healthcare institutions';
      case FrameworkType.is4hCountry:
        return 'For country-level systems';
      case FrameworkType.eccmFacility:
        return 'Facility-level capabilities';
      case FrameworkType.eccmOrganization:
        return 'Organization-level capabilities';
      case FrameworkType.bpmn:
        return 'Business process maturity';
      case FrameworkType.adb:
        return 'Digital health readiness';
    }
  }

  Color _getColorForCompletion(double completion) {
    if (completion == 0) return Colors.grey;
    if (completion < 25) return Colors.red;
    if (completion < 50) return Colors.orange;
    if (completion < 75) return Colors.yellow[700]!;
    return Colors.green;
  }
}
