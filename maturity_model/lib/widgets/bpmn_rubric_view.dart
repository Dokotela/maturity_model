// lib/widgets/bpmn_rubric_view.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:maturity_model/maturity_model.dart';

/// Helper function to get BPMN level labels
String _getBpmnLevelLabel(int level) {
  switch (level) {
    case 1:
      return 'Level 1: Initial/Inconsistent';
    case 2:
      return 'Level 2: Repeatable/Stabilized';
    case 3:
      return 'Level 3: Defined/Standardized';
    case 4:
      return 'Level 4: Quantitatively Managed';
    case 5:
      return 'Level 5: Learning Health System';
    default:
      return 'Level $level';
  }
}

/// BPMN-specific rubric view for maturity level assessment
class BpmnRubricView extends ConsumerWidget {
  final Domain domain;
  final FrameworkType frameworkType;

  const BpmnRubricView({
    super.key,
    required this.domain,
    required this.frameworkType,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watch the framework to get updates
    final framework = ref.watch(frameworkProvider(frameworkType));

    if (framework == null) {
      return const Center(child: CircularProgressIndicator());
    }

    // Find the current domain in the watched framework
    final watchedDomain = framework.domains.firstWhere(
      (d) => d.id == domain.id,
      orElse: () => domain,
    );

    return ListView(
      padding: const EdgeInsets.all(16),
      children: watchedDomain.subdomains.expand((subdomain) {
        return subdomain.items.map((item) {
          return _BpmnRubricCard(
            item: item,
            subdomain: subdomain,
            frameworkType: frameworkType,
          );
        }).toList();
      }).toList(),
    );
  }
}

/// Individual BPMN rubric card for a single assessment item
class _BpmnRubricCard extends StatelessWidget {
  final AssessmentItem item;
  final Subdomain subdomain;
  final FrameworkType frameworkType;

  const _BpmnRubricCard({
    required this.item,
    required this.subdomain,
    required this.frameworkType,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Question header
            Text(
              item.questionText.isNotEmpty ? item.questionText : subdomain.name,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            Text(
              'Select the maturity level that best describes your organization:',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.grey[600],
                  ),
            ),
            const SizedBox(height: 16),

            // Display maturity levels
            _BpmnMaturityLevels(
              item: item,
              frameworkType: frameworkType,
            ),
          ],
        ),
      ),
    );
  }
}

/// The maturity level selection buttons for BPMN
class _BpmnMaturityLevels extends ConsumerWidget {
  final AssessmentItem item;
  final FrameworkType frameworkType;

  const _BpmnMaturityLevels({
    required this.item,
    required this.frameworkType,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: List.generate(5, (index) {
        final level = index + 1;
        final isSelected = item.response == level;

        // Get the description for this level from maturityDescriptions
        final description = item.maturityDescriptions?[level] ??
            'Level $level description not available';

        return Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: _MaturityLevelButton(
            level: level,
            description: description,
            isSelected: isSelected,
            onTap: () {
              ref.read(sessionProvider.notifier).updateResponse(
                    frameworkType,
                    item.id,
                    level,
                  );
            },
          ),
        );
      }),
    );
  }
}

/// Individual maturity level button
class _MaturityLevelButton extends StatelessWidget {
  final int level;
  final String description;
  final bool isSelected;
  final VoidCallback onTap;

  const _MaturityLevelButton({
    required this.level,
    required this.description,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        decoration: BoxDecoration(
          color: isSelected
              ? Theme.of(context).primaryColor.withValues(alpha: 0.1)
              : null,
          border: Border.all(
            color:
                isSelected ? Theme.of(context).primaryColor : Colors.grey[300]!,
            width: isSelected ? 2 : 1,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.all(12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Radio button
            Container(
              width: 24,
              height: 24,
              margin: const EdgeInsets.only(right: 12, top: 2),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected
                      ? Theme.of(context).primaryColor
                      : Colors.grey[400]!,
                  width: 2,
                ),
              ),
              child: isSelected
                  ? Center(
                      child: Container(
                        width: 12,
                        height: 12,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                    )
                  : null,
            ),
            // Level content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _getBpmnLevelLabel(level), // <-- THIS IS THE KEY CHANGE
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: isSelected ? Theme.of(context).primaryColor : null,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    description,
                    style: TextStyle(
                      fontSize: 14,
                      color: isSelected ? null : Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
