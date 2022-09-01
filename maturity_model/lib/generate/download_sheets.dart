// Package imports:
import 'package:gsheets/gsheets.dart';

Future<Map<String, String>> downloadSheets(
  Map credentials,
  String sheetId,
) async {
  print('downloading sheets');

  /// Assign the gsheets credentials
  final gsheets = GSheets(credentials);

  /// Get all of tabs/sheets at the stated location
  final ss = await gsheets.spreadsheet(sheetId);

  Map<String, String> fileStrings = {};

  /// For each tab in the sheets
  for (var sheet in ss.sheets) {
    print(sheet.title);

    /// Start with an empty string
    var string = '';

    /// Read all of the values for all of the rows, values is a list of rows
    var values = (await sheet.values.allRows());

    /// For each row, evaluate its values
    for (var v in values) {
      /// Join the values of each cell together separated by tabs
      string += v.join('\t');

      /// Separate each line with a carriage return
      string += '\n';
    }

    /// Write it to a file (just in case), if it's not the AnswerOptions or
    /// translation_testing tabs
    if (sheet.title[0] != '_') {
      fileStrings['${sheet.title.replaceAll('/', '_')}.tsv'] = string;
    }
  }
  return fileStrings;
}
