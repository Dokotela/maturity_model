import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:graphic/graphic.dart';
import 'package:maturity_model/providers.dart';
import 'content/content.dart';

class OrganizationalView extends ConsumerWidget {
  const OrganizationalView(this.content, {super.key});

  final Content content;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Widget radarGraph(String title, List<Map<String, dynamic>> data) => Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(title, style: const TextStyle(fontSize: 24)),
            Container(
              margin: const EdgeInsets.only(top: 10),
              width: 300,
              height: 300,
              child: Chart<Map<String, dynamic>>(
                data: data,
                variables: {
                  'index': Variable(
                    accessor: (Map<String, dynamic> map) =>
                        map['index'].toString(),
                  ),
                  'type': Variable(
                    accessor: (Map<String, dynamic> map) =>
                        map['type'] as String,
                  ),
                  'value': Variable(
                    accessor: (Map<String, dynamic> map) => map['value'] as num,
                    scale: LinearScale(min: 0, max: 5),
                  ),
                },
                marks: [
                  // Changed from 'elements' to 'marks'
                  LineMark(
                    position:
                        Varset('index') * Varset('value') / Varset('type'),
                    shape: ShapeEncode(value: BasicLineShape(loop: true)),
                    color: ColorEncode(
                        variable: 'type', values: Defaults.colors10),
                  ),
                ],
                coord: PolarCoord(),
                axes: [
                  Defaults.circularAxis,
                  Defaults.radialAxis,
                ],
                selections: {
                  'touchMove': PointSelection(
                    on: {
                      GestureType.scaleUpdate,
                      GestureType.tapDown,
                      GestureType.longPressMoveUpdate
                    },
                    dim: Dim.x,
                    variable: 'index',
                  )
                },
              ),
            ),
          ],
        );

    final textWidgetsList = <Widget>[];
    final level = ref.read(mmLevelProvider);

    for (var i = 0; i < content.domains.length; i++) {
      final domain = content.domains[i];

      List<Map<String, dynamic>> domainData() {
        final info = <Map<String, dynamic>>[];
        for (var j = 0; j < domain.groups.length; j++) {
          final group = domain.groups[j];
          final groupValue = ref.watch(groupProvider((level, group.title)));
          final numberOfItems =
              ref.watch(numberItemsProvider((level, group.title)));

          info.add({
            "type": domain.title,
            "index": group.title,
            "value": numberOfItems > 0 ? groupValue / numberOfItems : 0,
          });
        }
        return info;
      }

      textWidgetsList.add(
        Container(
          padding: const EdgeInsets.only(top: 30, bottom: 30),
          color: i % 2 == 0 ? Colors.grey[200] : Colors.lightBlue[50],
          width: MediaQuery.of(context).size.width * 0.4,
          child: radarGraph(domain.title, domainData()),
        ),
      );
    }

    List<Map<String, dynamic>> overallData() {
      final info = <Map<String, dynamic>>[];

      double domainTotal(Domain domain) {
        double sum = 0;
        int validGroups = 0;

        for (var i = 0; i < domain.groups.length; i++) {
          final group = domain.groups[i];
          final groupValue = ref.watch(groupProvider((level, group.title)));
          final numberOfItems =
              ref.watch(numberItemsProvider((level, group.title)));

          if (numberOfItems > 0) {
            sum += groupValue / numberOfItems;
            validGroups++;
          }
        }

        return validGroups > 0 ? sum / validGroups : 0;
      }

      for (var j = 0; j < content.domains.length; j++) {
        info.add({
          "type": 'maturity model',
          "index": content.domains[j].title,
          "value": domainTotal(content.domains[j]),
        });
      }

      return info;
    }

    return Scaffold(
      body: Row(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.5,
            child: radarGraph('Maturity Assessment', overallData()),
          ),
          SingleChildScrollView(
            child: Column(
              children: textWidgetsList,
            ),
          ),
        ],
      ),
    );
  }
}
