import 'package:deedsuser/controllers/resultsearch_controller.dart';
import 'package:get/get.dart';
import 'dart:html' as html;
import 'package:excel/excel.dart' as excel;

Future<void> exportToExcel() async {
  ResultSearchController resultSearchController =
      Get.put(ResultSearchController());
  var myexcel = excel.Excel.createExcel();

  // Add a sheet to the Excel file
  var sheet = myexcel['Sheet1'];

  sheet.appendRow(resultSearchController.headersForProperties);
  List data = resultSearchController.datarowsForProperties;

  for (var row in data) {
    sheet.appendRow(row);
  }

  // Save the Excel file to a temporary directory on the client side
  final bytes = myexcel.encode();

  final blob = html.Blob([bytes]);
  final url = html.Url.createObjectUrlFromBlob(blob);
  final anchor = html.AnchorElement(href: url);
  anchor.download = 'report.xlsx';
  anchor.click();

  // Clean up after the download
  html.Url.revokeObjectUrl(url);
}
