import 'package:maturity_model/generate/download_sheets.dart';

import 'api.dart';

/// Basic function for generating FHIR json from spreadsheets
///
/// [credentials] - json credentials for a serviceAccount from GCP
/// that has access to all of the necessary spreadsheets
///
/// [sheetId] - ID of google sheet storing the information

Future<void> main() async {
  final String sheetId = '1JwlvggKF4flcoPgSCPtCGBrygmM1SLJ0BkIehKyEg0E';

  final results = await downloadSheets(credentials, sheetId);
  results.forEach((key, value) {
    print('\n\n*************************************');
    print(key);
    print(value);
  });
}
