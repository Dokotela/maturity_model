// lib/widgets/assessment_items.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:maturity_model/maturity_model.dart'
    show FrameworkType, AssessmentItem, sessionProvider;

/// Helper function to get the scale label for a given level based on framework type
String _getScaleLabel(FrameworkType frameworkType, int level) {
  // IS4H frameworks use these named levels
  switch (level) {
    case 1:
      return 'Initiated';
    case 2:
      return 'Developing';
    case 3:
      return 'Defined';
    case 4:
      return 'Integrated';
    case 5:
      return 'Optimized';
    default:
      return 'Level $level';
  }
}

/// Individual assessment item widget - handles all response types
class AssessmentItemWidget extends StatelessWidget {
  final AssessmentItem item;
  final FrameworkType frameworkType;

  const AssessmentItemWidget({
    super.key,
    required this.item,
    required this.frameworkType,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final baseSpacing = textTheme.bodyMedium!.fontSize!;

    final isAnswered = item.response != null && item.response! > 0;

    return Container(
      padding: EdgeInsets.all(baseSpacing),
      decoration: BoxDecoration(
        border: Border(
          left: BorderSide(
            color: isAnswered
                ? Colors.green.withValues(alpha: 0.5)
                : Colors.transparent,
            width: baseSpacing * 0.1875,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Question text
          Text(
            item.questionText,
            style: textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: baseSpacing * 0.75),

          // Response widget based on type
          _ResponseWidget(
            item: item,
            frameworkType: frameworkType,
          ),

          // Scoring note if available
          if (item.scoringNote != null && item.scoringNote!.isNotEmpty) ...[
            SizedBox(height: baseSpacing * 0.5),
            Text(
              item.scoringNote!,
              style: textTheme.bodySmall?.copyWith(
                fontStyle: FontStyle.italic,
                color: Colors.grey[600],
              ),
            ),
          ],
        ],
      ),
    );
  }
}

/// Response widget that determines which input type to show
class _ResponseWidget extends ConsumerWidget {
  final AssessmentItem item;
  final FrameworkType frameworkType;

  const _ResponseWidget({
    required this.item,
    required this.frameworkType,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    switch (item.responseType) {
      case 'yes_no':
        return _YesNoButtons(
          item: item,
          frameworkType: frameworkType,
        );
      case 'yes_no_planning':
        return _YesNoPlanningButtons(
          item: item,
          frameworkType: frameworkType,
        );
      case 'maturity_scale_1_5':
        return _MaturityDescriptionScale(
          item: item,
          frameworkType: frameworkType,
        );
      case 'likert_1_5':
      case 'maturity_level':
      case 'scale':
      default:
        // Check if this item has maturity descriptions (for IS4H maturity questions)
        if (item.hasMaturityDescriptions) {
          return _MaturityDescriptionScale(
            item: item,
            frameworkType: frameworkType,
          );
        }
        // Otherwise use the regular scale buttons
        return _LikertScale(
          item: item,
          frameworkType: frameworkType,
        );
    }
  }
}

/// Maturity scale with full descriptions (for IS4H maturity questions)
class _MaturityDescriptionScale extends ConsumerWidget {
  final AssessmentItem item;
  final FrameworkType frameworkType;

  const _MaturityDescriptionScale({
    required this.item,
    required this.frameworkType,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final baseSpacing = textTheme.bodyMedium!.fontSize!;

    return Column(
      children: List.generate(5, (index) {
        final level = index + 1;
        final isSelected = item.response == level;
        final levelLabel = _getScaleLabel(frameworkType, level);

        // Get the description for this level from maturityDescriptions
        final description = item.getMaturityDescription(level) ?? '';

        return Padding(
          padding: EdgeInsets.only(bottom: baseSpacing * 0.5),
          child: InkWell(
            onTap: () {
              ref.read(sessionProvider.notifier).updateResponse(
                    frameworkType,
                    item.id,
                    level,
                  );
            },
            borderRadius: BorderRadius.circular(baseSpacing * 0.5),
            child: Container(
              decoration: BoxDecoration(
                color: isSelected
                    ? theme.primaryColor.withValues(alpha: 0.1)
                    : null,
                border: Border.all(
                  color: isSelected ? theme.primaryColor : Colors.grey[300]!,
                  width: isSelected ? 2 : 1,
                ),
                borderRadius: BorderRadius.circular(baseSpacing * 0.5),
              ),
              padding: EdgeInsets.all(baseSpacing * 0.75),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Radio button style indicator
                  Container(
                    width: baseSpacing * 1.5,
                    height: baseSpacing * 1.5,
                    margin: EdgeInsets.only(
                      right: baseSpacing * 0.75,
                      top: baseSpacing * 0.125,
                    ),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color:
                            isSelected ? theme.primaryColor : Colors.grey[400]!,
                        width: 2,
                      ),
                    ),
                    child: isSelected
                        ? Center(
                            child: Container(
                              width: baseSpacing * 0.75,
                              height: baseSpacing * 0.75,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: theme.primaryColor,
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
                          'Level $level: $levelLabel',
                          style: textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: isSelected ? theme.primaryColor : null,
                          ),
                        ),
                        if (description.isNotEmpty) ...[
                          SizedBox(height: baseSpacing * 0.25),
                          Text(
                            description,
                            style: textTheme.bodySmall?.copyWith(
                              color: isSelected ? null : Colors.grey[600],
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}

/// Likert scale (1-5) response buttons for IS4H
class _LikertScale extends ConsumerWidget {
  final AssessmentItem item;
  final FrameworkType frameworkType;

  const _LikertScale({
    required this.item,
    required this.frameworkType,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final baseSpacing = textTheme.bodyMedium!.fontSize!;

    // For IS4H (without maturity descriptions), show vertical layout with names
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: List.generate(5, (index) {
        final value = index + 1;
        final isSelected = item.response == value;
        final label = _getScaleLabel(frameworkType, value);

        return Padding(
          padding: EdgeInsets.only(bottom: baseSpacing * 0.25),
          child: InkWell(
            onTap: () {
              ref.read(sessionProvider.notifier).updateResponse(
                    frameworkType,
                    item.id,
                    value,
                  );
            },
            borderRadius: BorderRadius.circular(baseSpacing * 0.5),
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: baseSpacing * 0.75,
                vertical: baseSpacing * 0.5,
              ),
              decoration: BoxDecoration(
                color: isSelected
                    ? theme.primaryColor.withValues(alpha: 0.1)
                    : null,
                border: Border.all(
                  color: isSelected ? theme.primaryColor : Colors.grey[300]!,
                  width: isSelected ? 2 : 1,
                ),
                borderRadius: BorderRadius.circular(baseSpacing * 0.5),
              ),
              child: Row(
                children: [
                  Container(
                    width: baseSpacing * 1.5,
                    height: baseSpacing * 1.5,
                    decoration: BoxDecoration(
                      color: isSelected ? theme.primaryColor : Colors.grey[400],
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        '$value',
                        style: textTheme.labelSmall?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: baseSpacing * 0.75),
                  Text(
                    label,
                    style: textTheme.bodyMedium?.copyWith(
                      fontWeight:
                          isSelected ? FontWeight.bold : FontWeight.normal,
                      color: isSelected ? theme.primaryColor : null,
                    ),
                  ),
                  if (isSelected) ...[
                    const Spacer(),
                    Icon(
                      Icons.check_circle,
                      color: theme.primaryColor,
                      size: baseSpacing * 1.25,
                    ),
                  ],
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}

/// Yes/No response buttons
class _YesNoButtons extends ConsumerWidget {
  final AssessmentItem item;
  final FrameworkType frameworkType;

  const _YesNoButtons({
    required this.item,
    required this.frameworkType,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final baseSpacing = textTheme.bodyMedium!.fontSize!;

    return Row(
      children: [
        Expanded(
          child: Padding(
            padding: EdgeInsets.only(right: baseSpacing * 0.25),
            child: _ResponseButton(
              label: 'Yes',
              isSelected: item.response == 5,
              onPressed: () {
                ref.read(sessionProvider.notifier).updateResponse(
                      frameworkType,
                      item.id,
                      5,
                    );
              },
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.only(left: baseSpacing * 0.25),
            child: _ResponseButton(
              label: 'No',
              isSelected: item.response == 1,
              onPressed: () {
                ref.read(sessionProvider.notifier).updateResponse(
                      frameworkType,
                      item.id,
                      1,
                    );
              },
            ),
          ),
        ),
      ],
    );
  }
}

/// Yes/No/Planning response buttons
class _YesNoPlanningButtons extends ConsumerWidget {
  final AssessmentItem item;
  final FrameworkType frameworkType;

  const _YesNoPlanningButtons({
    required this.item,
    required this.frameworkType,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final baseSpacing = textTheme.bodyMedium!.fontSize!;

    return Row(
      children: [
        Expanded(
          child: Padding(
            padding: EdgeInsets.only(right: baseSpacing * 0.125),
            child: _ResponseButton(
              label: 'Yes',
              isSelected: item.response == 5,
              isCompact: true,
              onPressed: () {
                ref.read(sessionProvider.notifier).updateResponse(
                      frameworkType,
                      item.id,
                      5,
                    );
              },
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: baseSpacing * 0.125),
            child: _ResponseButton(
              label: 'Planning',
              isSelected: item.response == 3,
              isCompact: true,
              onPressed: () {
                ref.read(sessionProvider.notifier).updateResponse(
                      frameworkType,
                      item.id,
                      3,
                    );
              },
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.only(left: baseSpacing * 0.125),
            child: _ResponseButton(
              label: 'No',
              isSelected: item.response == 1,
              isCompact: true,
              onPressed: () {
                ref.read(sessionProvider.notifier).updateResponse(
                      frameworkType,
                      item.id,
                      1,
                    );
              },
            ),
          ),
        ),
      ],
    );
  }
}

/// Reusable response button
class _ResponseButton extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onPressed;
  final bool isCompact;

  const _ResponseButton({
    required this.label,
    required this.isSelected,
    required this.onPressed,
    this.isCompact = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final baseSpacing = textTheme.bodyMedium!.fontSize!;

    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: isSelected ? theme.primaryColor : Colors.grey[200],
        foregroundColor: isSelected ? Colors.white : Colors.black87,
        padding: EdgeInsets.symmetric(
          vertical: isCompact ? baseSpacing * 0.5 : baseSpacing * 0.75,
          horizontal: isCompact ? baseSpacing * 0.25 : baseSpacing * 0.5,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(baseSpacing * 0.5),
        ),
      ),
      child: FittedBox(
        fit: BoxFit.scaleDown,
        child: Text(
          label,
          style: isCompact ? textTheme.bodySmall : textTheme.bodyMedium,
        ),
      ),
    );
  }
}
