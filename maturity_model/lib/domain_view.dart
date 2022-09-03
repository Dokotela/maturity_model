import 'package:creator/creator.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:maturity_model/creators.dart';

import 'content/content.dart';

class DomainView extends StatelessWidget {
  const DomainView(this.domain, this.primary, {Key? key}) : super(key: key);

  final Domain domain;
  final bool primary;

  @override
  Widget build(BuildContext context) {
    double? getWidth(double? width, double fraction) =>
        width == null ? null : width * fraction;
    double columnFirst = 0.18;
    double columns = 0.12;
    double columnComments = 0.17;
    final scrollController = ScrollController();

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
    ]) =>
        Container(
            decoration: BoxDecoration(border: Border.all()),
            width: getWidth(MediaQuery.of(context).size.width, width),
            child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: name == null
                    ? Text(text)
                    : Watcher(
                        (context, ref, child) => TextButton(
                            onPressed: () {
                              if (ref.read(itemCreator(name)) == value) {
                                ref.set(itemCreator(name), 0);
                              } else {
                                ref.set(itemCreator(name), value);
                              }
                            },
                            child: Text(text,
                                style: TextStyle(
                                  fontWeight:
                                      ref.watch(itemCreator(name)) == value
                                          ? FontWeight.bold
                                          : FontWeight.normal,
                                  color: ref.watch(itemCreator(name)) == value
                                      ? Colors.blue
                                      : Colors.black,
                                ))),
                      )));

    Widget itemRow(Item item, String name) => IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              itemRowBox(columnFirst, item.text),
              itemRowBox(
                  columns,
                  item.map(subGroup: (_) => '', question: (_) => _.level1),
                  name,
                  1),
              itemRowBox(
                  columns,
                  item.map(subGroup: (_) => '', question: (_) => _.level2),
                  name,
                  2),
              itemRowBox(
                  columns,
                  item.map(subGroup: (_) => '', question: (_) => _.level3),
                  name,
                  3),
              itemRowBox(
                  columns,
                  item.map(subGroup: (_) => '', question: (_) => _.level4),
                  name,
                  4),
              itemRowBox(
                  columns,
                  item.map(subGroup: (_) => '', question: (_) => _.level5),
                  name,
                  5),
              itemRowBox(columnComments, ''),
            ],
          ),
        );

    return Watcher((context, ref, child) {
      return Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              dataTable,
              Expanded(
                child: Scrollbar(
                  controller: scrollController,
                  thumbVisibility: true,
                  child: SingleChildScrollView(
                    controller: scrollController,
                    child: Watcher(
                      (context, ref, child) {
                        var i = 0;
                        final widgets = <Widget>[];
                        for (var group in domain.groups) {
                          widgets.add(const Gap(24));
                          widgets.add(groupRow(group));
                          ref.read(groupCreator(group.title));
                          i = 0;
                          for (var item in group.items) {
                            widgets.add(const Gap(4));
                            item.map(
                              subGroup: (_) {
                                widgets.add(const Gap(8));
                                widgets.add(Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    itemRowBox(0.3, _.text),
                                  ],
                                ));
                              },
                              question: (_) {
                                widgets.add(itemRow(_, '${group.title}/$i'));
                                i++;
                              },
                            );
                          }
                          ref.set<int>(numberItemsCreator(group.title), i);
                        }
                        return Column(children: widgets);
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
