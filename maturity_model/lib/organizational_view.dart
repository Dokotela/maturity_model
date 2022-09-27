import 'package:creator/creator.dart';
import 'package:flutter/material.dart';
import 'package:graphic/graphic.dart';
import 'package:maturity_model/creators.dart';

import 'content/content.dart';

class OrganizationalView extends StatelessWidget {
  const OrganizationalView(this.content, {Key? key}) : super(key: key);

  final Content content;

  @override
  Widget build(BuildContext context) {
    final textWidgetsList = <Widget>[];

    Widget radarGraph(String title, List<Map<dynamic, dynamic>> data) => Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(title, style: const TextStyle(fontSize: 24)),
            Container(
              margin: const EdgeInsets.only(top: 10),
              width: 300,
              height: 300,
              child: Chart(
                data: data,
                variables: {
                  'index': Variable(
                    accessor: (Map map) => map['index'].toString(),
                  ),
                  'type': Variable(
                    accessor: (Map map) => map['type'] as String,
                  ),
                  'value': Variable(
                      accessor: (Map map) => map['value'] as num,
                      scale: LinearScale(min: 0, max: 5)),
                },
                elements: [
                  LineElement(
                    position:
                        Varset('index') * Varset('value') / Varset('type'),
                    shape: ShapeAttr(value: BasicLineShape(loop: true)),
                    color:
                        ColorAttr(variable: 'type', values: Defaults.colors10),
                  ),
                ],
                coord: PolarCoord(),
                axes: [
                  Defaults.circularAxis
                    ..labelMapper = null
                    ..label = LabelStyle(
                        maxLines: 2,
                        style: Defaults.textStyle.copyWith(fontSize: 16)),
                  Defaults.radialAxis
                    ..labelMapper = null
                    ..label = LabelStyle(
                        style: Defaults.textStyle.copyWith(fontSize: 16)),
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

    for (var domain in content.domains) {
      List<Map<dynamic, dynamic>> newData(Ref ref) {
        final info = <Map<dynamic, dynamic>>[];
        for (var i = 0; i < domain.groups.length; i++) {
          info.add({
            "type": domain.title,
            "index": domain.groups[i].title,
            "value": ref.watch(groupCreator(
                    ref.read(mmLevelCreator), domain.groups[i].title)) /
                ref.watch(numberItemsCreator(
                    ref.read(mmLevelCreator), domain.groups[i].title)),
          });
        }
        return info;
      }

      textWidgetsList.add(Watcher(
          (context, ref, child) => radarGraph(domain.title, newData(ref))));
    }

    Widget overallGraph(Ref ref, MmLevel level) {
      final info = <Map<dynamic, dynamic>>[];

      double domainTotal(Domain domain) {
        double sum = 0;
        for (var i = 0; i < domain.groups.length; i++) {
          sum += ref.watch(groupCreator(level, domain.groups[i].title)) /
              ref.watch(numberItemsCreator(level, domain.groups[i].title));
        }

        return sum / domain.groups.length;
      }

      for (var i = 0; i < content.domains.length; i++) {
        info.add({
          "type": 'maturity model',
          "index": content.domains[i].title,
          "value": domainTotal(content.domains[i]),
        });
      }

      return radarGraph('Maturity Assessment', info);
    }

    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: GridView.count(
              crossAxisCount: 2,
              childAspectRatio: 2,
              padding: EdgeInsets.zero,
              children: textWidgetsList,
            ),
          ),
          // Watcher(
          //   (context, ref, child) => overallGraph(ref),
          // )
        ],
      ),
    );
  }
}
