import 'dart:convert';

import 'package:deedsuser/controllers/full_report_controller.dart';
import 'package:deedsuser/controllers/json_controller.dart';
import 'package:deedsuser/controllers/search_controller.dart';
import 'package:deedsuser/functions/isEnglish.dart';
import 'package:deedsuser/functions/loaddata.dart';
import 'package:deedsuser/utils/api_service.dart';
import 'package:deedsuser/utils/responsive.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:json_view/json_view.dart';
import 'package:pdf/pdf.dart';

import 'dart:html' as html;
import 'package:pdf/widgets.dart' as pw;
import '../../utils/constant.dart';
import 'package:excel/excel.dart' as excel;

class MyJsonViewrTable extends GetView<JsonController> {
  const MyJsonViewrTable({super.key});

  @override
  Widget build(BuildContext context) {
    JsonController jsonController = Get.put(JsonController());
    FullReportController fullReportController = Get.put(FullReportController());
    OptionSearchController optionSearchController =
        Get.put(OptionSearchController());
    optionSearchController.searchs.clear();
    final ScrollController mainScrollController = ScrollController();
    final ScrollController horizontalScrollController = ScrollController();
    jsonController.datarows.clear();
    jsonController.headers.clear();
    jsonController.update();

    return DefaultTabController(
      initialIndex: 0,
      length: 2, // تعداد تب‌ها
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          bottom: const TabBar(tabs: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Tab(
                  icon: Icon(
                    FontAwesomeIcons.code,
                    color: kPrimaryColor,
                    size: 20.0,
                  ),
                ),
              ],
            ),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Tab(
                  icon: Icon(
                FontAwesomeIcons.tableList,
                color: kPrimaryColor,
                size: 20.0,
              )),
            ]),
          ]),
        ),
        body: TabBarView(
          dragStartBehavior: DragStartBehavior.start,
          children: [
            Obx(() => jsonController.jsonText.value.isEmpty
                ? const Text('')
                : Padding(
                    padding: EdgeInsets.all(kDefaultPadding),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Padding(
                        padding: EdgeInsets.all(kDefaultPadding * 2),
                        child: Container(
                          width: Get.width / 3,
                          decoration: const BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(color: kPrimaryColor),
                                  top: BorderSide(color: kPrimaryColor)),
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(25),
                                  bottomRight: Radius.circular(25))),
                          child: Padding(
                            padding: EdgeInsets.all(kDefaultPadding),
                            child: JsonViewBody(
                              styleScheme: JsonStyleScheme(
                                  keysStyle: CustomTextStyle()
                                      .textStyleDesktopCourierkBlackColor,
                                  valuesStyle: CustomTextStyle()
                                      .textStyleDesktopCourierkBlackColor,
                                  openAtStart: true,
                                  quotation: const JsonQuotation(
                                      leftQuote: "", rightQuote: "")),
                              colorScheme: const JsonColorScheme(
                                  markColor: kErrorColor,
                                  numColor: kPrimaryColor,
                                  boolColor: kPrimaryColor,
                                  normalColor: kBlackColor,
                                  stringColor: kPrimaryColor),
                              json: json.decode(jsonController.jsonText.value),
                            ),
                          ),
                        ),
                      ),
                    ),
                  )),
            Column(
              children: [
                Obx(() {
                  return !jsonController.isWaiting.value
                      ? Expanded(
                          flex: 1,
                          child: jsonController.headers.isNotEmpty
                              ? Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    IconButton(
                                      onPressed: () async {
                                        jsonController.update();
                                        fullReportController.selectedreport[0]
                                                    .report.hasUserPdfExport ==
                                                true
                                            ? {
                                                jsonController.datarows.clear(),
                                                jsonController.headers.clear(),
                                                jsonController.update(),
                                                await loadData(context),
                                                await _generatePdfJson(),
                                              }
                                            : Network.showInternetError(
                                                context,
                                                GeneralConstant()
                                                    .permissiontSubMessage);
                                      },
                                      tooltip: 'فایل پی دی اف',
                                      icon: Padding(
                                        padding:
                                            EdgeInsets.all(kDefaultPadding / 4),
                                        child: const FaIcon(
                                            FontAwesomeIcons.solidFilePdf),
                                      ),
                                      color: kErrorColor,
                                      iconSize: SideMenuConstant().iconSize,
                                    ),
                                    IconButton(
                                      onPressed: () async {
                                        jsonController.update();
                                        fullReportController
                                                    .selectedreport[0]
                                                    .report
                                                    .hasUserExcelExport ==
                                                true
                                            ? {
                                                jsonController.datarows.clear(),
                                                jsonController.headers.clear(),
                                                jsonController.update(),
                                                await loadData(context),
                                                await _exportToExcelJson(),
                                              }
                                            : Network.showInternetError(
                                                context,
                                                GeneralConstant()
                                                    .permissiontSubMessage);
                                      },
                                      tooltip: 'فایل اکسل',
                                      icon: Padding(
                                        padding:
                                            EdgeInsets.all(kDefaultPadding / 4),
                                        child: const FaIcon(
                                            FontAwesomeIcons.solidFileExcel),
                                      ),
                                      color: kSuccessColor,
                                      iconSize: SideMenuConstant().iconSize,
                                    ),
                                  ],
                                )
                              : Container())
                      : Container();
                }),

                fullReportController.selectedreport[0].report.scope == 'BOTH'
                    ? Expanded(
                        flex: 12,
                        child: Obx(() {
                          return jsonController.isWaiting.value
                              ? const Center(child: CircularProgressIndicator())
                              : jsonController.headers.isNotEmpty
                                  ? Scrollbar(
                                      thumbVisibility: true,
                                      controller: mainScrollController,
                                      child: SingleChildScrollView(
                                        scrollDirection: Axis.vertical,
                                        controller: mainScrollController,
                                        child: Scrollbar(
                                          thumbVisibility: true,
                                          controller:
                                              horizontalScrollController,
                                          child: SingleChildScrollView(
                                            scrollDirection: Axis.horizontal,
                                            controller:
                                                horizontalScrollController,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: DataTable(
                                                // ستون‌ها
                                                columns: [
                                                  for (var columnIndex = 0;
                                                      columnIndex <
                                                          jsonController
                                                              .headers.length;
                                                      columnIndex++)
                                                    DataColumn(
                                                      label: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          Text(
                                                            jsonController
                                                                .headers[
                                                                    columnIndex]
                                                                .toString(),
                                                            style: Responsive
                                                                    .isDesktop(
                                                                        context)
                                                                ? CustomTextStyle()
                                                                    .textStyleDesktopKprimaryColorTitr
                                                                : CustomTextStyle()
                                                                    .textStyleDesktopKprimaryColorTitr,
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                ],

                                                // ردیف‌ها
                                                rows: _buildRowsJson(context,
                                                    jsonController.datarows),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                  : Container();
                        }),
                      )
                    : Container(),

                // دکمه‌های صفحه‌بندی
              ],
            ),
          ],
        ),
      ),
    );
  }

  List<DataRow> _buildRowsJson(BuildContext context, List datarows) {
    JsonController jsonController = Get.find<JsonController>();
    List<DataRow> rows = [];
    for (int index = 0; index < datarows.length; index++) {
      List<DataCell> cells = [];
      for (int i = 0; i < jsonController.headers.length; i++) {
        cells.add(
          DataCell(
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SelectableText(
                  datarows[index][i].toString(),
                  style: Responsive.isDesktop(context)
                      ? CustomTextStyle().textStyleDesktopkBlackColor
                      : CustomTextStyle().textStyleDesktopkBlackColor,
                )
              ],
            ),
          ),
        );
      }
      rows.add(DataRow(cells: cells));
    }
    return rows;
  }

  Future<void> _generatePdfJson() async {
    JsonController jsonController = Get.put(JsonController());
    var myexcel = excel.Excel.createExcel();

    // Add a sheet to the Excel file
    var sheet = myexcel['Sheet1'];
    // Your dynamic list

    sheet.appendRow(jsonController.headers);

    // Add data rows
    List data = jsonController.datarows;

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
                          children: jsonController.headers
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
                                      textAlign:
                                          isEnglishText(header.toString())
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
                                      padding: pw.EdgeInsets.all(
                                          kDefaultPadding / 2),
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

  Future<void> _exportToExcelJson() async {
    JsonController jsonController = Get.put(JsonController());
    var myexcel = excel.Excel.createExcel();

    // Add a sheet to the Excel file
    var sheet = myexcel['Sheet1'];

    sheet.appendRow(jsonController.headers);
    List data = jsonController.datarows;

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
}
