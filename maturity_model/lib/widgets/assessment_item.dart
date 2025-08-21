// lib/widgets/assessment_items.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:maturity_model/maturity_model.dart';

/// Helper function to get the scale label for a given level based on framework type
String _getScaleLabel(FrameworkType frameworkType, int level) {
  switch (frameworkType) {
    case FrameworkType.bpmn:
      switch (level) {
        case 1:
          return 'Level 1 Initial/ Inconsistent';
        case 2:
          return 'Level 2 Repeatable / Stabilized';
        case 3:
          return 'Level 3 Defined / Standardized';
        case 4:
          return 'Level 4 Quantitatively Managed';
        case 5:
          return 'Level 5 Learning Health System';
        default:
          return 'Level $level';
      }

    case FrameworkType.eccmFacility:
    case FrameworkType.eccmOrganization:
      // ECCM uses named levels
      switch (level) {
        case 1:
          return 'Level 1: Nascent';
        case 2:
          return 'Level 2: Emerging';
        case 3:
          return 'Level 3: Established';
        case 4:
          return 'Level 4: Institutional';
        case 5:
          return 'Level 5: Optimized';
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
      case 'likert_1_5':
      case 'maturity_level':
      default:
        return _LikertScale(
          item: item,
          frameworkType: frameworkType,
        );
    }
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
    // Use horizontal layout for ADB (just numbers)
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
