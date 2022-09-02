import 'dart:convert';
import 'dart:io';

import 'package:maturity_model/generate/download_sheets.dart';

import '../content/content.dart';
import 'api.dart';
import 'package:csv/csv.dart';

/// Basic function for generating FHIR json from spreadsheets
///
/// [credentials] - json credentials for a serviceAccount from GCP
/// that has access to all of the necessary spreadsheets
///
/// [sheetId] - ID of google sheet storing the information

Future<void> main() async {
  const String sheetId = '1JwlvggKF4flcoPgSCPtCGBrygmM1SLJ0BkIehKyEg0E';

  final fileStrings = await downloadSheets(credentials, sheetId);

  var content = Content();

  String getName(String file) {
    switch (file) {
      case 'dmit.tsv':
        return 'Data Management and Information Technology';
      case 'mago.tsv':
        return 'Management and Governance';
      case 'kmsh.tsv':
        return 'Knowledge Management and Sharing';
      case 'inno.tsv':
        return 'Innovation';
      default:
        return '';
    }
  }

  for (var file in fileStrings.keys) {
    content = content.copyWith(domains: <Domain>[
      if (content.domains.isNotEmpty) ...content.domains,
      Domain(title: getName(file), groups: <Group>[])
    ]);

    /// Print the name to keep track
    print(file);

    /// Read the file's contents
    var newFile = fileStrings[file];

    /// Convert the contents to a list of rows
    final rows = const CsvToListConverter()
        .convert(newFile, fieldDelimiter: '\t', eol: '\n');

    for (var row in rows) {
      if (row[0] == 'group') {
        var lastDomain = content.domains.last;
        lastDomain = lastDomain.copyWith(groups: <Group>[
          if (lastDomain.groups.isNotEmpty) ...lastDomain.groups,
          Group(
            title: row[1].toString().split('::').first,
            subTitle: row[1].toString().split('::').last,
            level1: row[2],
            level2: row[3],
            level3: row[4],
            level4: row[5],
            level5: row[6],
            items: <Item>[],
          ),
        ]);
        content = content.copyWith(domains: [
          ...content.domains.sublist(0, content.domains.length - 1),
          lastDomain,
        ]);
      } else if (row[0] == 'subgroup') {
        Domain lastDomain = content.domains.last;
        Group lastGroup = lastDomain.groups.last;
        var newItems = lastGroup.items;
        newItems = [...newItems, Subgroup(text: row[1])];
        content = content.copyWith(domains: [
          ...content.domains.sublist(0, content.domains.length - 1),
          lastDomain.copyWith(groups: [
            ...lastDomain.groups.sublist(0, lastDomain.groups.length - 1),
            lastGroup.copyWith(items: newItems),
          ])
        ]);
      } else if (row[0] == 'question') {
        Domain lastDomain = content.domains.last;
        Group lastGroup = lastDomain.groups.last;
        var newItems = lastGroup.items;
        newItems = [
          ...newItems,
          Question(
            text: row[1],
            level1: row[2],
            level2: row[3],
            level3: row[4],
            level4: row[5],
            level5: row[6],
          )
        ];
        content = content.copyWith(domains: [
          ...content.domains.sublist(0, content.domains.length - 1),
          lastDomain.copyWith(groups: [
            ...lastDomain.groups.sublist(0, lastDomain.groups.length - 1),
            lastGroup.copyWith(items: newItems),
          ])
        ]);
      }
    }
  }

  const jsonEncoder = JsonEncoder.withIndent('    ');
  String jsonPrettyPrint(Map<String, dynamic> map) => jsonEncoder.convert(map);
  await File('content.dart').writeAsString(
      "import '../content/content.dart';\n\n"
      'final content = Content.fromJson(${jsonPrettyPrint(content.toJson())});');
}
