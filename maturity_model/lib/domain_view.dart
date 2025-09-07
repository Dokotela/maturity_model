import 'package:flutter/material.dart';
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

class _DomainViewState extends ConsumerState<DomainView> {
  late final ScrollController _scrollController;
  final List<Widget> _items = [];
  bool _itemsBuilt = false;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();

    // Initialize the number of items after the first frame
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initializeItemCounts();
      _buildItems();
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

  void _buildItems() {
    for (var group in widget.domain.groups) {
      _items.add(const Gap(24));
      _items.add(_GroupRow(group: group));

      int i = 0;
      for (var item in group.items) {
        _items.add(const Gap(4));

        if (item is Subgroup) {
          _items.add(const Gap(8));
          _items.add(_SubgroupHeader(subgroup: item));

          for (var question in item.questions) {
            _items.add(const Gap(4));
            _items.add(_ItemRow(
              question: question,
              name: '${group.title}/$i',
              key: ValueKey('${group.title}/$i'),
            ));
            i++;
          }
        } else if (item is Question) {
          _items.add(_ItemRow(
            question: item,
            name: '${group.title}/$i',
            key: ValueKey('${group.title}/$i'),
          ));
          i++;
        }
      }
    }

    setState(() {
      _itemsBuilt = true;
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
              child: !_itemsBuilt
                  ? const Center(child: CircularProgressIndicator())
                  : Scrollbar(
                      controller: _scrollController,
                      thumbVisibility: true,
                      thickness: 15, // Add this line
                      radius: const Radius.circular(8), // Add this line
                      child: ListView.builder(
                        controller: _scrollController,
                        itemCount: _items.length,
                        itemBuilder: (context, index) => _items[index],
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
    final columnFirst = 0.22;
    final columns = 0.14;

    Widget groupRowSizedBox(double width, Color color, String text) =>
        Container(
          decoration: BoxDecoration(color: color, border: Border.all()),
          width: MediaQuery.of(context).size.width * width,
          child: Text(text),
        );

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            color: Colors.grey[400]!,
            width: MediaQuery.of(context).size.width * columnFirst,
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
        Container(
          decoration: BoxDecoration(border: Border.all()),
          width: MediaQuery.of(context).size.width * 0.3,
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Text(subgroup.text),
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
    super.key,
    required this.question,
    required this.name,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final columnFirst = 0.22;
    final columns = 0.14;

    Widget itemRowBox(
      double width,
      String text, [
      int? value,
    ]) {
      return Container(
        decoration: BoxDecoration(border: Border.all()),
        width: MediaQuery.of(context).size.width * width,
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
