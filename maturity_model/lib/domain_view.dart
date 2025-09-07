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

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();

    // Initialize the number of items after the first frame
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initializeItemCounts();
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

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double? getWidth(double? width, double fraction) =>
        width == null ? null : width * fraction;
    double columnFirst = 0.18;
    double columns = 0.12;
    double columnComments = 0.17;

    Widget header(Color color, double width, String text) => Container(
        height: 50,
        width: getWidth(MediaQuery.of(context).size.width, width),
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
        header(Colors.grey[300]!, columnComments, 'Comments'),
      ],
    );

    Widget groupRowSizedBox(double width, Color color, String text) =>
        Container(
          decoration: BoxDecoration(color: color, border: Border.all()),
          width: getWidth(MediaQuery.of(context).size.width, width),
          child: Text(text),
        );

    Widget groupRow(Group group) => IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                color: Colors.grey[400]!,
                width: getWidth(MediaQuery.of(context).size.width, columnFirst),
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
              groupRowSizedBox(columnComments, Colors.grey[300]!, ''),
            ],
          ),
        );

    Container itemRowBox(
      double width,
      String text, [
      String? name,
      int? value,
    ]) {
      return Container(
        decoration: BoxDecoration(border: Border.all()),
        width: getWidth(MediaQuery.of(context).size.width, width),
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: name == null
              ? Text(text)
              : Builder(
                  builder: (context) {
                    final level = ref.read(mmLevelProvider);
                    final currentValue = ref.watch(itemProvider((level, name)));

                    return TextButton(
                      onPressed: () {
                        if (currentValue == value) {
                          ref.read(itemProvider((level, name)).notifier).state =
                              0;
                        } else {
                          ref.read(itemProvider((level, name)).notifier).state =
                              value!;
                        }
                      },
                      child: Text(
                        text,
                        style: TextStyle(
                          fontWeight: currentValue == value
                              ? FontWeight.bold
                              : FontWeight.normal,
                          color: currentValue == value
                              ? Colors.blue
                              : Colors.black,
                        ),
                      ),
                    );
                  },
                ),
        ),
      );
    }

    Widget itemRow(Question question, String name) => IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              itemRowBox(columnFirst, question.text),
              itemRowBox(columns, question.level1, name, 1),
              itemRowBox(columns, question.level2, name, 2),
              itemRowBox(columns, question.level3, name, 3),
              itemRowBox(columns, question.level4, name, 4),
              itemRowBox(columns, question.level5, name, 5),
              itemRowBox(columnComments, ''),
            ],
          ),
        );

    // Build the widgets
    final widgets = <Widget>[];
    final level = ref.read(mmLevelProvider);

    for (var group in widget.domain.groups) {
      widgets.add(const Gap(24));
      widgets.add(groupRow(group));

      // Just read the group value, don't modify anything
      ref.watch(groupProvider((level, group.title)));

      int i = 0;
      for (var item in group.items) {
        widgets.add(const Gap(4));

        if (item is Subgroup) {
          widgets.add(const Gap(8));
          widgets.add(Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              itemRowBox(0.3, item.text),
            ],
          ));
          // Add the subgroup's questions
          for (var question in item.questions) {
            widgets.add(const Gap(4));
            widgets.add(itemRow(question, '${group.title}/$i'));
            i++;
          }
        } else if (item is Question) {
          widgets.add(itemRow(item, '${group.title}/$i'));
          i++;
        }
      }
    }

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            dataTable,
            Expanded(
              child: Scrollbar(
                controller: _scrollController,
                thumbVisibility: true,
                child: SingleChildScrollView(
                  controller: _scrollController,
                  child: Column(children: widgets),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
