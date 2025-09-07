import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:graphic/graphic.dart';
import 'package:maturity_model/providers.dart';
import 'content/content.dart';

class OrganizationalView extends StatefulWidget {
  const OrganizationalView(this.content, {super.key});

  final Content content;

  @override
  State<OrganizationalView> createState() => _OrganizationalViewState();
}

class _OrganizationalViewState extends State<OrganizationalView> {
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.5,
            child: _OverallChart(content: widget.content),
          ),
          Scrollbar(
            controller: _scrollController,
            thumbVisibility: true,
            thickness: 15,
            radius: const Radius.circular(8),
            child: SingleChildScrollView(
              controller: _scrollController, // This is what was missing
              child: Column(
                children: List.generate(
                  widget.content.domains.length,
                  (i) => _DomainChart(
                    domain: widget.content.domains[i],
                    index: i,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _OverallChart extends ConsumerWidget {
  final Content content;

  const _OverallChart({required this.content});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final level = ref.read(mmLevelProvider);

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

    return _RadarGraph(title: 'Maturity Assessment', data: overallData());
  }
}

class _DomainChart extends ConsumerWidget {
  final Domain domain;
  final int index;

  const _DomainChart({required this.domain, required this.index});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final level = ref.read(mmLevelProvider);

    List<Map<String, dynamic>> domainData() {
      final info = <Map<String, dynamic>>[];
      for (var group in domain.groups) {
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

    return Container(
      padding: const EdgeInsets.only(top: 30, bottom: 30),
      color: index % 2 == 0 ? Colors.grey[200] : Colors.lightBlue[50],
      width: MediaQuery.of(context).size.width * 0.4,
      child: _RadarGraph(title: domain.title, data: domainData()),
    );
  }
}

class _RadarGraph extends StatelessWidget {
  final String title;
  final List<Map<String, dynamic>> data;

  const _RadarGraph({required this.title, required this.data});

  @override
  Widget build(BuildContext context) {
    return Column(
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
                accessor: (Map<String, dynamic> map) => map['index'].toString(),
              ),
              'type': Variable(
                accessor: (Map<String, dynamic> map) => map['type'] as String,
              ),
              'value': Variable(
                accessor: (Map<String, dynamic> map) => map['value'] as num,
                scale: LinearScale(min: 0, max: 5),
              ),
            },
            marks: [
              LineMark(
                position: Varset('index') * Varset('value') / Varset('type'),
                shape: ShapeEncode(value: BasicLineShape(loop: true)),
                color: ColorEncode(variable: 'type', values: Defaults.colors10),
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
  }
}
