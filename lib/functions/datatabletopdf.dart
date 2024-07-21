import 'dart:convert';
import 'dart:html' as html;
import 'package:deedsuser/controllers/resultsearch_controller.dart';
import 'package:deedsuser/functions/isEnglish.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:excel/excel.dart' as excel;

import '../utils/constant.dart';

Future<void> generatePdf() async {
  ResultSearchController resultSearchController =
      Get.put(ResultSearchController());
  var myexcel = excel.Excel.createExcel();

  // Add a sheet to the Excel file
  var sheet = myexcel['Sheet1'];
  // Your dynamic list

  sheet.appendRow(resultSearchController.headersForProperties);

  // Add data rows
  List data = resultSearchController.datarowsForProperties;

  // Load fonts
  final myFont =
      pw.Font.ttf(await rootBundle.load("assets/fonts/bnazanin.ttf"));
  final myFallbackFont =
      pw.Font.ttf(await rootBundle.load("assets/fonts/arialregular.ttf"));

  for (var row in data) {
    sheet.appendRow(row);
  }
  final pdf = pw.Document();

  // Chunk data into groups of 10
  List<List<dynamic>> rows = sheet.rows;
  int chunkSize = 20;
  List<List<List<dynamic>>> chunks = [];
  for (var i = 1; i < rows.length; i += chunkSize) {
    // Start from 1 to skip header
    chunks.add(rows.sublist(
        i, i + chunkSize > rows.length ? rows.length : i + chunkSize));
  }

  // Add a page for each chunk
  for (var i = 0; i < chunks.length; i++) {
    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4.landscape,
        build: (pw.Context context) {
          return pw.Directionality(
            textDirection: pw.TextDirection.rtl,
            child: pw.Column(
              children: [
                pw.Expanded(
                  child: pw.Table(
                    border: pw.TableBorder.all(),
                    children: [
                      // Header row
                      pw.TableRow(
                        children: resultSearchController.headersForProperties
                            .map((header) => pw.Container(
                                  alignment: pw.Alignment.center,
                                  padding:
                                      pw.EdgeInsets.all(kDefaultPadding / 4),
                                  child: pw.Text(
                                    header,
                                    textDirection:
                                        isEnglishText(header.toString())
                                            ? pw.TextDirection.ltr
                                            : pw.TextDirection.rtl,
                                    textAlign: isEnglishText(header.toString())
                                        ? pw.TextAlign.left
                                        : pw.TextAlign.right,
                                    style: isEnglishText(header.toString())
                                        ? pw.TextStyle(
                                            font: myFallbackFont,
                                            fontFallback: [myFont],
                                          )
                                        : pw.TextStyle(
                                            font: myFont,
                                            fontFallback: [myFallbackFont],
                                          ),
                                  ),
                                ))
                            .toList(),
                      ),
                      // Data rows
                      for (var row in chunks[i])
                        pw.TableRow(
                          children: row
                              .map((cell) => pw.Container(
                                    alignment: pw.Alignment.center,
                                    padding:
                                        pw.EdgeInsets.all(kDefaultPadding / 2),
                                    child: pw.Text(
                                      textDirection:
                                          isEnglishText(cell.value.toString())
                                              ? pw.TextDirection.ltr
                                              : pw.TextDirection.rtl,
                                      textAlign:
                                          isEnglishText(cell.value.toString())
                                              ? pw.TextAlign.left
                                              : pw.TextAlign.right,
                                      cell?.value.toString() ?? '',
                                      style:
                                          isEnglishText(cell.value.toString())
                                              ? pw.TextStyle(
                                                  font: myFallbackFont,
                                                  fontFallback: [myFont],
                                                )
                                              : pw.TextStyle(
                                                  font: myFont,
                                                  fontFallback: [
                                                    myFallbackFont
                                                  ],
                                                ),
                                    ),
                                  ))
                              .toList(),
                        ),
                    ],
                  ),
                ),
                pw.Container(
                  alignment: pw.Alignment.center,
                  padding: pw.EdgeInsets.all(8),
                  child: pw.Text(
                    'صفحه ${i + 1}',
                    style: pw.TextStyle(
                      font: myFont,
                      fontFallback: [myFont],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  // Save PDF
  final bytes = await pdf.save();
  final base64 = base64Encode(Uint8List.fromList(bytes));
  final blob = html.Blob([base64]);
  final url = html.Url.createObjectUrlFromBlob(blob);
  // ignore: use_build_context_synchronously

  html.AnchorElement(href: 'data:application/pdf;base64,$base64')
    ..setAttribute('download', 'report.pdf')
    ..click();
  html.Url.revokeObjectUrl(url);
}
