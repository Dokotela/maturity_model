import 'package:maturity_model/generate/download_sheets.dart';

import '../domain/content.dart';
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

  for (var file in fileStrings.keys) {
    content = content.copyWith(domains: [
      if (content.domains.isNotEmpty) ...content.domains,
      Domain(title: file, groups: [])
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
        var lastDomain = content.domains.removeLast();
        lastDomain = lastDomain.copyWith(groups: [
          if (lastDomain.groups.isNotEmpty) ...lastDomain.groups,
          Group(
            title: row[1].toString().split('::').first,
            subTitle: row[1].toString().split('::').last,
            level1: row[2],
            level2: row[3],
            level3: row[4],
            level4: row[5],
            level5: row[6],
            items: [],
          ),
        ]);
        content.domains.add(lastDomain);
      } else if (row[0] == 'subgroup') {
        var lastDomain = content.domains.removeLast();
        var lastGroup = lastDomain.groups.last;
        var newItems = lastGroup.items;
        newItems.add(Subgroup(text: row[1]));
        content.domains.add(lastDomain.copyWith(groups: [
          ...lastDomain.groups.sublist(0, lastDomain.groups.length - 1),
          lastGroup.copyWith(items: newItems),
        ]));
      } else if (row[0] == 'question') {
        var lastDomain = content.domains.removeLast();
        var lastGroup = lastDomain.groups.last;
        var newItems = lastGroup.items;
        newItems.add(Question(
          text: row[1],
          level1: row[2],
          level2: row[3],
          level3: row[4],
          level4: row[5],
          level5: row[6],
        ));
        content.domains.add(lastDomain.copyWith(groups: [
          ...lastDomain.groups.sublist(0, lastDomain.groups.length - 1),
          lastGroup.copyWith(items: newItems),
        ]));
      }
    }
  }
}
