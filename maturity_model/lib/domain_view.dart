import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:maturity_model/providers.dart';
import 'content/content.dart';

class DomainView extends ConsumerStatefulWidget {
  const DomainView(this.domain, this.primary, {super.key});

  final Domain domain;
  final bool primary;

  @override
  ConsumerState<DomainView> createState() => _DomainViewState();
}

class _DomainViewState extends ConsumerState<DomainView>
    with AutomaticKeepAliveClientMixin {
  late final ScrollController _scrollController;
  late final FocusNode _focusNode;
  bool _initialized = false;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _focusNode = FocusNode();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initializeItemCounts();
      if (mounted) {
        setState(() {
          _initialized = true;
        });
        // Request focus after building
        _focusNode.requestFocus();
      }
    });
  }

  void _initializeItemCounts() {
    final level = ref.read(mmLevelProvider);

    for (var group in widget.domain.groups) {
      int itemCount = 0;
      for (var item in group.items) {
        if (item is Question) {
          itemCount++;
        } else if (item is Subgroup) {
          itemCount += item.questions.length;
        }
      }
      ref.read(numberItemsProvider((level, group.title)).notifier).state =
          itemCount;
    }
  }

  // Calculate total item count for ListView
  int _getTotalItemCount() {
    int count = 0;
    for (var group in widget.domain.groups) {
      count += 2; // Gap + Group header
      for (var item in group.items) {
        count++; // Gap before item
        if (item is Subgroup) {
          count += 2; // Extra gap + subgroup header
          count += item.questions.length * 2; // Gap + question for each
        } else {
          count++; // Question
        }
      }
    }
    return count;
  }

  // Build the widget at a specific index (true lazy loading)
  Widget _buildItemAtIndex(int index) {
    int currentIndex = 0;

    for (var group in widget.domain.groups) {
      // Gap before group
      if (currentIndex == index) return const Gap(24);
      currentIndex++;

      // Group header
      if (currentIndex == index) {
        return RepaintBoundary(
          child: _GroupRow(group: group),
        );
      }
      currentIndex++;

      int questionIndex = 0;
      for (var item in group.items) {
        // Gap before item
        if (currentIndex == index) return const Gap(4);
        currentIndex++;

        if (item is Subgroup) {
          // Extra gap before subgroup
          if (currentIndex == index) return const Gap(8);
          currentIndex++;

          // Subgroup header
          if (currentIndex == index) {
            return RepaintBoundary(
              child: _SubgroupHeader(subgroup: item),
            );
          }
          currentIndex++;

          for (var question in item.questions) {
            // Gap before question
            if (currentIndex == index) return const Gap(4);
            currentIndex++;

            // Question row
            if (currentIndex == index) {
              return RepaintBoundary(
                child: _ItemRow(
                  question: question,
                  name: '${group.title}/$questionIndex',
                ),
              );
            }
            currentIndex++;
            questionIndex++;
          }
        } else if (item is Question) {
          // Question row
          if (currentIndex == index) {
            return RepaintBoundary(
              child: _ItemRow(
                question: item,
                name: '${group.title}/$questionIndex',
              ),
            );
          }
          currentIndex++;
          questionIndex++;
        }
      }
    }

    return const SizedBox.shrink();
  }

  // FIXED: Proper signature for KeyboardListener.onKeyEvent
  KeyEventResult _handleKeyEvent(FocusNode node, KeyEvent event) {
    if (event is! KeyDownEvent) return KeyEventResult.ignored;

    final currentOffset = _scrollController.offset;
    const smallScroll = 100.0;
    final largeScroll = MediaQuery.of(context).size.height * 0.8;

    switch (event.logicalKey) {
      case LogicalKeyboardKey.arrowDown:
        _scrollController.jumpTo(
          (currentOffset + smallScroll).clamp(
            0.0,
            _scrollController.position.maxScrollExtent,
          ),
        );
        return KeyEventResult.handled;
      case LogicalKeyboardKey.arrowUp:
        _scrollController.jumpTo(
          (currentOffset - smallScroll).clamp(0.0, double.infinity),
        );
        return KeyEventResult.handled;
      case LogicalKeyboardKey.pageDown:
        _scrollController.jumpTo(
          (currentOffset + largeScroll).clamp(
            0.0,
            _scrollController.position.maxScrollExtent,
          ),
        );
        return KeyEventResult.handled;
      case LogicalKeyboardKey.pageUp:
        _scrollController.jumpTo(
          (currentOffset - largeScroll).clamp(0.0, double.infinity),
        );
        return KeyEventResult.handled;
      case LogicalKeyboardKey.home:
        _scrollController.jumpTo(0);
        return KeyEventResult.handled;
      case LogicalKeyboardKey.end:
        _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
        return KeyEventResult.handled;
      default:
        return KeyEventResult.ignored;
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    final columnFirst = 0.22;
    final columns = 0.14;

    Widget header(Color color, double width, String text) => Container(
        height: 50,
        width: MediaQuery.of(context).size.width * width,
        color: color,
        child: Center(
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ));

    final dataTable = Row(
      children: [
        header(Colors.grey[400]!, columnFirst, 'Question'),
        header(Colors.blue[50]!, columns, 'Level 1'),
        header(Colors.blue[100]!, columns, 'Level 2'),
        header(Colors.blue[200]!, columns, 'Level 3'),
        header(Colors.blue[300]!, columns, 'Level 4'),
        header(Colors.blue[400]!, columns, 'Level 5'),
      ],
    );

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            dataTable,
            Expanded(
              child: !_initialized
                  ? const Center(child: CircularProgressIndicator())
                  : Focus(
                      focusNode: _focusNode,
                      autofocus: true,
                      onKeyEvent:
                          _handleKeyEvent, // Focus widget uses this signature
                      child: GestureDetector(
                        onTap: () => _focusNode.requestFocus(),
                        child: Scrollbar(
                          controller: _scrollController,
                          thumbVisibility: true,
                          thickness: 15,
                          radius: const Radius.circular(8),
                          child: ListView.builder(
                            controller: _scrollController,
                            itemCount: _getTotalItemCount(),
                            itemBuilder: (context, index) =>
                                _buildItemAtIndex(index),
                            // Performance settings
                            cacheExtent: 1000,
                            physics: const ClampingScrollPhysics(),
                          ),
                        ),
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

class _GroupRow extends StatelessWidget {
  final Group group;

  const _GroupRow({required this.group});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final columnFirst = screenWidth * 0.22;
    final columns = screenWidth * 0.14;

    Widget groupRowSizedBox(double width, Color color, String text) =>
        Container(
          decoration: BoxDecoration(color: color, border: Border.all()),
          width: width,
          padding: const EdgeInsets.all(8.0),
          child: Text(text),
        );

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.grey[400]!,
              border: Border.all(),
            ),
            width: columnFirst,
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  group.title,
                  textAlign: TextAlign.start,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(group.subTitle)
              ],
            ),
          ),
          groupRowSizedBox(columns, Colors.grey[50]!, group.level1),
          groupRowSizedBox(columns, Colors.blue[100]!, group.level2),
          groupRowSizedBox(columns, Colors.blue[200]!, group.level3),
          groupRowSizedBox(columns, Colors.blue[300]!, group.level4),
          groupRowSizedBox(columns, Colors.blue[400]!, group.level5),
        ],
      ),
    );
  }
}

class _SubgroupHeader extends StatelessWidget {
  final Subgroup subgroup;

  const _SubgroupHeader({required this.subgroup});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.3,
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Text(
              subgroup.text,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ],
    );
  }
}

class _ItemRow extends ConsumerWidget {
  final Question question;
  final String name;

  const _ItemRow({
    required this.question,
    required this.name,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final screenWidth = MediaQuery.of(context).size.width;
    final columnFirst = screenWidth * 0.22;
    final columns = screenWidth * 0.14;

    Widget itemRowBox(
      double width,
      String text, [
      int? value,
    ]) {
      return Container(
        decoration: BoxDecoration(border: Border.all()),
        width: width,
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: value == null
              ? Text(text)
              : _ItemButton(name: name, value: value, text: text),
        ),
      );
    }

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          itemRowBox(columnFirst, question.text),
          itemRowBox(columns, question.level1, 1),
          itemRowBox(columns, question.level2, 2),
          itemRowBox(columns, question.level3, 3),
          itemRowBox(columns, question.level4, 4),
          itemRowBox(columns, question.level5, 5),
        ],
      ),
    );
  }
}

class _ItemButton extends ConsumerWidget {
  final String name;
  final int value;
  final String text;

  const _ItemButton({
    required this.name,
    required this.value,
    required this.text,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final level = ref.read(mmLevelProvider);
    final currentValue = ref.watch(itemProvider((level, name)));

    return TextButton(
      onPressed: () {
        if (currentValue == value) {
          ref.read(itemProvider((level, name)).notifier).state = 0;
        } else {
          ref.read(itemProvider((level, name)).notifier).state = value;
        }
      },
      child: Text(
        text,
        style: TextStyle(
          fontWeight:
              currentValue == value ? FontWeight.bold : FontWeight.normal,
          color: currentValue == value ? Colors.blue : Colors.black,
        ),
      ),
    );
  }
}
