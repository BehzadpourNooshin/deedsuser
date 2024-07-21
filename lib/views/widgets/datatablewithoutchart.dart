import 'dart:math';

import 'package:deedsuser/controllers/full_report_controller.dart';
import 'package:deedsuser/controllers/json_controller.dart';
import 'package:deedsuser/controllers/resultsearch_controller.dart';
import 'package:deedsuser/controllers/search_controller.dart';
import 'package:deedsuser/functions/datatabletoexcel.dart';
import 'package:deedsuser/functions/datatabletopdf.dart';
import 'package:deedsuser/functions/loaddata.dart';
import 'package:deedsuser/models/search_model.dart';
import 'package:deedsuser/utils/api_service.dart';
import 'package:deedsuser/utils/constant.dart';
import 'package:deedsuser/utils/responsive.dart';
import 'package:deedsuser/views/widgets/mydropdownwidgetpagesize.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class MyDataTable extends GetView<ResultSearchController> {
  final bool _sortAscending = true;

  const MyDataTable({super.key});

  @override
  Widget build(BuildContext context) {
    final PageController pageController = PageController();
    Widget buildDot(int index) {
      return GestureDetector(
        onTap: () {
          pageController.animateToPage(
            index,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
          );
        },
        child: Padding(
          padding: EdgeInsets.all(kDefaultPadding / 2),
          child: Container(
            width: Get.width / 100,
            height: Get.height / 60,
            decoration: const BoxDecoration(
                shape: BoxShape.circle, color: kPrimaryColor),
          ),
        ),
      );
    }

    FullReportController fullReportController = Get.put(FullReportController());
    OptionSearchController optionSearchController =
        Get.put(OptionSearchController());
    optionSearchController.searchs.clear();
    ResultSearchController resultSearchController =
        Get.put(ResultSearchController());
    JsonController jsonController = Get.put(JsonController());
    resultSearchController.datarow.clear();
    resultSearchController.header.clear();
    resultSearchController.update();
    final mainScrollController = ScrollController();

    return DefaultTabController(
      initialIndex: 0,
      length: 1, // تعداد تب‌ها
      child: Scaffold(
        body: TabBarView(
          dragStartBehavior: DragStartBehavior.start,
          children: [
            Column(
              children: [
                Obx(() {
                  return resultSearchController.headers.isNotEmpty
                      ? Expanded(
                          flex: 1,
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Visibility(
                                  visible: fullReportController
                                              .selectedreport[0].report.scope ==
                                          'FilterForm'
                                      ? true
                                      : false,
                                  child: SizedBox(
                                    width: Get.width / 10,
                                    child: MyFormBuilderDropdownPageSize(
                                      labelTitle: 'تعداد رکوردها',
                                      nameDropDown: 'countrecord',
                                      hintTitle: 'تعداد رکوردها',
                                      myController: controller.ps,
                                      myItems: const [10, 25, 50, 100],
                                    ),
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Visibility(
                                      visible: fullReportController
                                                      .selectedreport[0]
                                                      .report
                                                      .scope ==
                                                  'FilterForm' &&
                                              fullReportController
                                                      .selectedreport[0]
                                                      .report
                                                      .hasPDFExport ==
                                                  'true'
                                          ? true
                                          : false,
                                      child: IconButton(
                                        onPressed: () async {
                                          controller.update();
                                          fullReportController
                                                      .selectedreport[0]
                                                      .report
                                                      .hasUserPdfExport ==
                                                  true
                                              ? {
                                                  controller.datarows.clear(),
                                                  controller.update(),
                                                  optionSearchController.searchs
                                                      .clear(),
                                                  optionSearchController
                                                      .update(),
                                                  optionSearchController.searchs.add(SearchModel(
                                                      reportName:
                                                          fullReportController
                                                              .selectedreport[0]
                                                              .report
                                                              .reportName,
                                                      dbTableName:
                                                          fullReportController
                                                              .selectedreport[0]
                                                              .table[0]
                                                              .dbTableName,
                                                      filterFormDtoList:
                                                          optionSearchController
                                                              .searchDetail
                                                              .toJson(),
                                                      pageSize:
                                                          controller.pageSize,
                                                      pageNumber:
                                                          controller.pageNumber,
                                                      sortType:
                                                          controller.sortType,
                                                      sortColumn: controller
                                                          .columnTitle)),
                                                  optionSearchController
                                                      .update(),
                                                  controller.datarows.clear(),
                                                  controller.update(),
                                                  await loadData(context),
                                                  await generatePdf(),
                                                }
                                              : Network.showInternetError(
                                                  context,
                                                  GeneralConstant()
                                                      .permissiontSubMessage);
                                        },
                                        tooltip: 'فایل پی دی اف',
                                        icon: Padding(
                                          padding: EdgeInsets.all(
                                              kDefaultPadding / 4),
                                          child: const FaIcon(
                                              FontAwesomeIcons.solidFilePdf),
                                        ),
                                        color: kErrorColor,
                                        iconSize: SideMenuConstant().iconSize,
                                      ),
                                    ),
                                    Visibility(
                                        visible: fullReportController
                                                    .selectedreport[0]
                                                    .report
                                                    .scope ==
                                                'FilterForm'
                                            ? true
                                            : false,
                                        child: IconButton(
                                          onPressed: () async {
                                            controller.update();
                                            fullReportController
                                                        .selectedreport[0]
                                                        .report
                                                        .hasUserExcelExport ==
                                                    true
                                                ? {
                                                    controller.datarows.clear(),
                                                    controller.update(),
                                                    optionSearchController
                                                        .searchs
                                                        .clear(),
                                                    optionSearchController
                                                        .update(),
                                                    optionSearchController.searchs.add(SearchModel(
                                                        reportName:
                                                            fullReportController
                                                                .selectedreport[
                                                                    0]
                                                                .report
                                                                .reportName,
                                                        dbTableName:
                                                            fullReportController
                                                                .selectedreport[
                                                                    0]
                                                                .table[0]
                                                                .dbTableName,
                                                        filterFormDtoList:
                                                            optionSearchController
                                                                .searchDetail
                                                                .toJson(),
                                                        pageSize:
                                                            controller.pageSize,
                                                        pageNumber: controller
                                                            .pageNumber,
                                                        sortType:
                                                            controller.sortType,
                                                        sortColumn: controller
                                                            .columnTitle)),
                                                    optionSearchController
                                                        .update(),
                                                    controller.datarows.clear(),
                                                    controller.update(),
                                                    await loadData(context),
                                                    await exportToExcel(),
                                                  }
                                                : Network.showInternetError(
                                                    context,
                                                    GeneralConstant()
                                                        .permissiontSubMessage);
                                          },
                                          tooltip: 'فایل اکسل',
                                          icon: Padding(
                                            padding: EdgeInsets.all(
                                                kDefaultPadding / 4),
                                            child: const FaIcon(FontAwesomeIcons
                                                .solidFileExcel),
                                          ),
                                          color: kSuccessColor,
                                          iconSize: SideMenuConstant().iconSize,
                                        )),
                                  ],
                                ),
                              ]))
                      : Container();
                }),
                // دیتاتیبل
                fullReportController.selectedreport[0].report.scope ==
                        'FilterForm'
                    ? Expanded(
                        flex: 12,
                        child: Obx(() {
                          return resultSearchController.isWaiting.value
                              ? const Center(child: CircularProgressIndicator())
                              : resultSearchController.headers.isNotEmpty
                                  ? Scrollbar(
                                      thumbVisibility: true,
                                      controller: mainScrollController,
                                      child: SingleChildScrollView(
                                          scrollDirection: Axis.vertical,
                                          controller: mainScrollController,
                                          child: SingleChildScrollView(
                                            scrollDirection: Axis.horizontal,
                                            child: DataTable(
                                              // ستون‌ها
                                              columns: [
                                                for (var columnIndex = 0;
                                                    columnIndex <
                                                        resultSearchController
                                                            .headers.length;
                                                    columnIndex++)
                                                  DataColumn(
                                                    label: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Text(
                                                          resultSearchController
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
                                                    // onSort: (columnIndex,
                                                    //     ascending) {
                                                    //   _onSortColumn(
                                                    //       columnIndex);
                                                    //   controller.datarows
                                                    //       .clear();
                                                    //   controller.update();

                                                    //   optionSearchController
                                                    //       .update();
                                                    //   optionSearchController.searchs.add(SearchModel(
                                                    //       reportName:
                                                    //           fullReportController
                                                    //               .selectedreport[
                                                    //                   0]
                                                    //               .report
                                                    //               .reportName,
                                                    //       dbTableName: fullReportController
                                                    //           .selectedreport[0]
                                                    //           .table[0]
                                                    //           .dbTableName,
                                                    //       filterFormDtoList:
                                                    //           optionSearchController
                                                    //               .searchDetail
                                                    //               .toJson(),
                                                    //       pageSize: 9.obs,
                                                    //       pageNumber: controller
                                                    //           .pageNumber,
                                                    //       sortType: controller
                                                    //           .sortType,
                                                    //       sortColumn: controller
                                                    //           .columnTitle));

                                                    //   optionSearchController
                                                    //       .update();
                                                    //   controller.datarows
                                                    //       .clear();
                                                    //   controller.update();
                                                    //   _loadData(context);
                                                    // },
                                                  ),
                                              ],
                                              // ردیف‌ها
                                              rows: _buildRows(
                                                  context, controller.datarows),
                                            ),
                                          )),
                                    )
                                  : Container();
                        }),
                      )
                    : Expanded(
                        flex: 12,
                        child: Obx(() => jsonController.jsonText.value.isEmpty
                            ? const Text('')
                            : SingleChildScrollView(
                                padding: EdgeInsets.all(kDefaultPadding * 2),
                                child: Text(jsonController.jsonText.value))),
                      ),
                // دکمه‌های صفحه‌بندی
                Expanded(
                  flex: 1,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Obx(() => resultSearchController.datarows.isNotEmpty
                          ? Padding(
                              padding: const EdgeInsets.only(bottom: 8.0),
                              child: Row(children: [
                                resultSearchController.result[0].last == false
                                    ? IconButton(
                                        icon: const Icon(Icons.chevron_left),
                                        onPressed: () async {
                                          controller.datarows.clear();
                                          controller.update();

                                          controller.resetLastPage(
                                              resultSearchController
                                                      .result[0].totalPages -
                                                  1);
                                          optionSearchController.update();
                                          optionSearchController.searchs.add(
                                              SearchModel(
                                                  reportName:
                                                      fullReportController
                                                          .selectedreport[0]
                                                          .report
                                                          .reportName,
                                                  dbTableName:
                                                      fullReportController
                                                          .selectedreport[0]
                                                          .table[0]
                                                          .dbTableName,
                                                  filterFormDtoList:
                                                      optionSearchController
                                                          .searchDetail
                                                          .toJson(),
                                                  pageSize: 9.obs,
                                                  pageNumber:
                                                      controller.pageNumber,
                                                  sortType: controller.sortType,
                                                  sortColumn:
                                                      controller.columnTitle));

                                          optionSearchController.update();
                                          controller.datarows.clear();
                                          controller.update();
                                          loadData(context);
                                        },
                                      )
                                    : Container(),
                                resultSearchController.result[0].last == false
                                    ? IconButton(
                                        icon: const Icon(Icons.arrow_back),
                                        onPressed: () async {
                                          controller.datarows.clear();
                                          controller.update();

                                          controller.nextPage();
                                          optionSearchController.update();
                                          optionSearchController.searchs.add(
                                              SearchModel(
                                                  reportName:
                                                      fullReportController
                                                          .selectedreport[0]
                                                          .report
                                                          .reportName,
                                                  dbTableName:
                                                      fullReportController
                                                          .selectedreport[0]
                                                          .table[0]
                                                          .dbTableName,
                                                  filterFormDtoList:
                                                      optionSearchController
                                                          .searchDetail
                                                          .toJson(),
                                                  pageSize: 9.obs,
                                                  pageNumber:
                                                      controller.pageNumber,
                                                  sortType: controller.sortType,
                                                  sortColumn:
                                                      controller.columnTitle));

                                          optionSearchController.update();
                                          controller.datarows.clear();
                                          controller.update();
                                          loadData(context);
                                        },
                                      )
                                    : Container(),
                                for (int i = min(
                                        10,
                                        (resultSearchController
                                                    .result[0].totalPages -
                                                1) -
                                            controller.pageNumber.value);
                                    i >= 1;
                                    i--)
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 3.0),
                                    child: GestureDetector(
                                      onTap: () {
                                        controller.updatePage(i);
                                        optionSearchController.update();
                                        controller.datarows.clear();
                                        controller.update();
                                        optionSearchController.update();
                                        optionSearchController.searchs.add(
                                            SearchModel(
                                                reportName: fullReportController
                                                    .selectedreport[0]
                                                    .report
                                                    .reportName,
                                                dbTableName:
                                                    fullReportController
                                                        .selectedreport[0]
                                                        .table[0]
                                                        .dbTableName,
                                                filterFormDtoList:
                                                    optionSearchController
                                                        .searchDetail
                                                        .toJson(),
                                                pageSize: 9.obs,
                                                pageNumber:
                                                    controller.pageNumber,
                                                sortType: controller.sortType,
                                                sortColumn:
                                                    controller.columnTitle));

                                        optionSearchController.update();
                                        controller.datarows.clear();
                                        controller.update();
                                        loadData(context);
                                      },
                                      child: CircleAvatar(
                                        backgroundColor:
                                            kPrimaryColor, // Change to your preferred color
                                        child: Text(
                                          (i + controller.pageNumber.value)
                                              .toString(),
                                          style: const TextStyle(
                                              color: kCardColor), // Text color
                                        ),
                                      ),
                                    ),
                                  ),
                                resultSearchController.result[0].number != 0
                                    ? IconButton(
                                        icon: const Icon(Icons.arrow_forward),
                                        onPressed: () async {
                                          controller.datarows.clear();
                                          optionSearchController.update();

                                          controller.previousPage();
                                          optionSearchController.update();
                                          optionSearchController.searchs.add(
                                              SearchModel(
                                                  reportName:
                                                      fullReportController
                                                          .selectedreport[0]
                                                          .report
                                                          .reportName,
                                                  dbTableName:
                                                      fullReportController
                                                          .selectedreport[0]
                                                          .table[0]
                                                          .dbTableName,
                                                  filterFormDtoList:
                                                      optionSearchController
                                                          .searchDetail
                                                          .toJson(),
                                                  pageSize: 9.obs,
                                                  pageNumber:
                                                      controller.pageNumber,
                                                  sortType: controller.sortType,
                                                  sortColumn:
                                                      controller.columnTitle));
                                          optionSearchController.update();
                                          controller.datarows.clear();
                                          controller.update();
                                          loadData(context);
                                        },
                                      )
                                    : Container(),
                                resultSearchController.result[0].number != 0
                                    ? IconButton(
                                        icon: const Icon(Icons.chevron_right),
                                        onPressed: () async {
                                          controller.datarows.clear();
                                          optionSearchController.update();

                                          controller.resetFirstPage();
                                          optionSearchController.update();
                                          optionSearchController.searchs.add(
                                              SearchModel(
                                                  dbTableName:
                                                      fullReportController
                                                          .selectedreport[0]
                                                          .table[0]
                                                          .dbTableName,
                                                  filterFormDtoList:
                                                      optionSearchController
                                                          .searchDetail
                                                          .toJson(),
                                                  pageSize: 9.obs,
                                                  pageNumber:
                                                      controller.pageNumber,
                                                  sortType: controller.sortType,
                                                  sortColumn:
                                                      controller.columnTitle,
                                                  reportName:
                                                      fullReportController
                                                          .selectedreport[0]
                                                          .report
                                                          .reportName));
                                          optionSearchController.update();
                                          controller.datarows.clear();
                                          controller.update();
                                          loadData(context);
                                        },
                                      )
                                    : Container(),
                                // MyFormBuilderDropdown(
                                //     myItems: const [10, 25, 30, 50, 100],
                                //     labelTitle: 'تعداد رکوردها در صفحه',
                                //     nameDropDown: 'ps',
                                //     hintTitle: 'تعداد رکوردها در صفحه',
                                //     myController: controller.ps)
                              ]),
                            )
                          : Container())
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  List<DataRow> _buildRows(BuildContext context, List datarows) {
    ResultSearchController resultSearchController =
        Get.find<ResultSearchController>();
    List<DataRow> rows = [];
    for (int index = 0; index < datarows.length; index++) {
      List<DataCell> cells = [];
      for (int i = 0; i < resultSearchController.headers.length; i++) {
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
      rows.add(DataRow(
        cells: cells,
      ));
    }
    return rows;
  }

  // تابع برای مرتب‌سازی ستون‌ها
  void _onSortColumn(int columnIndex) {
    final resultSearchController = Get.find<ResultSearchController>();
    resultSearchController.sortByColumn(columnIndex, _sortAscending);
  }
}
