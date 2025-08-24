// lib/widgets/assessment_items.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:maturity_model/maturity_model.dart'
    show FrameworkType, AssessmentItem, sessionProvider;

/// Helper function to get the scale label for a given level based on framework type
String _getScaleLabel(FrameworkType frameworkType, int level) {
  switch (frameworkType) {
    case FrameworkType.bpmn:
      switch (level) {
        case 1:
          return 'Initial/Inconsistent';
        case 2:
          return 'Repeatable/Stabilized';
        case 3:
          return 'Defined/Standardized';
        case 4:
          return 'Quantitatively Managed';
        case 5:
          return 'Learning Health System';
        default:
          return 'Level $level';
      }

    case FrameworkType.eccmFacility:
    case FrameworkType.eccmOrganization:
      // ECCM uses named levels
      switch (level) {
        case 1:
          return 'Nascent';
        case 2:
          return 'Emerging';
        case 3:
          return 'Established';
        case 4:
          return 'Institutional';
        case 5:
          return 'Optimized';
        default:
          return 'Level $level';
      }

    case FrameworkType.is4hInstitutional:
    case FrameworkType.is4hCountry:
      // IS4H uses named levels
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

    case FrameworkType.adb:
      // ADB and others just use numbers
      return '$level';
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
    final isAnswered = item.response != null && item.response! > 0;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border(
          left: BorderSide(
            color: isAnswered
                ? Colors.green.withValues(alpha: 0.5)
                : Colors.transparent,
            width: 3,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Question text
          Text(
            item.questionText,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 12),

          // Response widget based on type
          _ResponseWidget(
            item: item,
            frameworkType: frameworkType,
          ),

          // Scoring note if available
          if (item.scoringNote != null && item.scoringNote!.isNotEmpty) ...[
            const SizedBox(height: 8),
            Text(
              item.scoringNote!,
              style: TextStyle(
                fontSize: 12,
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
    return Column(
      children: List.generate(5, (index) {
        final level = index + 1;
        final isSelected = item.response == level;
        final levelLabel = _getScaleLabel(frameworkType, level);

        // Get the description for this level from maturityDescriptions
        final description = item.getMaturityDescription(level) ?? '';

        return Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: InkWell(
            onTap: () {
              ref.read(sessionProvider.notifier).updateResponse(
                    frameworkType,
                    item.id,
                    level,
                  );
            },
            borderRadius: BorderRadius.circular(8),
            child: Container(
              decoration: BoxDecoration(
                color: isSelected
                    ? Theme.of(context).primaryColor.withValues(alpha: 0.1)
                    : null,
                border: Border.all(
                  color: isSelected
                      ? Theme.of(context).primaryColor
                      : Colors.grey[300]!,
                  width: isSelected ? 2 : 1,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              padding: const EdgeInsets.all(12),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Radio button style indicator
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
                          'Level $level: $levelLabel',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: isSelected
                                ? Theme.of(context).primaryColor
                                : null,
                          ),
                        ),
                        if (description.isNotEmpty) ...[
                          const SizedBox(height: 4),
                          Text(
                            description,
                            style: TextStyle(
                              fontSize: 13,
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

/// Likert scale (1-5) response buttons
class _LikertScale extends ConsumerWidget {
  final AssessmentItem item;
  final FrameworkType frameworkType;

  const _LikertScale({
    required this.item,
    required this.frameworkType,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // For ECCM and IS4H (without maturity descriptions), show vertical layout with names
    if (frameworkType == FrameworkType.is4hInstitutional ||
        frameworkType == FrameworkType.is4hCountry) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: List.generate(5, (index) {
          final value = index + 1;
          final isSelected = item.response == value;
          final label = _getScaleLabel(frameworkType, value);

          return Padding(
            padding: const EdgeInsets.only(bottom: 4),
            child: InkWell(
              onTap: () {
                ref.read(sessionProvider.notifier).updateResponse(
                      frameworkType,
                      item.id,
                      value,
                    );
              },
              borderRadius: BorderRadius.circular(8),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: isSelected
                      ? Theme.of(context).primaryColor.withValues(alpha: 0.1)
                      : null,
                  border: Border.all(
                    color: isSelected
                        ? Theme.of(context).primaryColor
                        : Colors.grey[300]!,
                    width: isSelected ? 2 : 1,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 24,
                      height: 24,
                      decoration: BoxDecoration(
                        color: isSelected
                            ? Theme.of(context).primaryColor
                            : Colors.grey[400],
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Text(
                          '$value',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Text(
                      label,
                      style: TextStyle(
                        fontWeight:
                            isSelected ? FontWeight.bold : FontWeight.normal,
                        color:
                            isSelected ? Theme.of(context).primaryColor : null,
                      ),
                    ),
                    if (isSelected) ...[
                      const Spacer(),
                      Icon(
                        Icons.check_circle,
                        color: Theme.of(context).primaryColor,
                        size: 20,
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

    // For ADB and BPMN, use horizontal buttons
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(5, (index) {
        final value = index + 1;
        final isSelected = item.response == value;
        final label = _getScaleLabel(frameworkType, value);

        return Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 2),
            child: _ResponseButton(
              label: label,
              isSelected: isSelected,
              onPressed: () {
                ref.read(sessionProvider.notifier).updateResponse(
                      frameworkType,
                      item.id,
                      value,
                    );
              },
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
    return Row(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(right: 4),
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
            padding: const EdgeInsets.only(left: 4),
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
    return Row(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(right: 2),
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
            padding: const EdgeInsets.symmetric(horizontal: 2),
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
            padding: const EdgeInsets.only(left: 2),
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
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor:
            isSelected ? Theme.of(context).primaryColor : Colors.grey[200],
        foregroundColor: isSelected ? Colors.white : Colors.black87,
        padding: EdgeInsets.symmetric(
          vertical: isCompact ? 8 : 12,
          horizontal: isCompact ? 4 : 8,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: FittedBox(
        fit: BoxFit.scaleDown,
        child: Text(
          label,
          style: TextStyle(
            fontSize: isCompact ? 13 : 14,
          ),
        ),
      ),
    );
  }
}
