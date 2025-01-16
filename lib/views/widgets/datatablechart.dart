import 'dart:math';

import 'package:deedsuser/controllers/full_report_controller.dart';
import 'package:deedsuser/controllers/json_controller.dart';
import 'package:deedsuser/controllers/resultsearch_controller.dart';
import 'package:deedsuser/controllers/search_controller.dart';
import 'package:deedsuser/functions/datatabletoexcel.dart';
import 'package:deedsuser/functions/datatabletopdf.dart';
import 'package:deedsuser/functions/loaddata.dart';
import 'package:deedsuser/functions/makechartwidget.dart';
import 'package:deedsuser/models/search_model.dart';
import 'package:deedsuser/utils/api_service.dart';
import 'package:deedsuser/utils/constant.dart';
import 'package:deedsuser/utils/responsive.dart';
import 'package:deedsuser/views/widgets/mydropdownwidgetpagesize.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:persian_tools/persian_tools.dart';

class MyDataTableChart extends GetView<ResultSearchController> {
  final bool _sortAscending = true;

  const MyDataTableChart({super.key});
  void _onChartTabSelected(BuildContext context) {
    makechartwidgets();
  }

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
    final ScrollController mainScrollController = ScrollController();
    final ScrollController horizontalScrollController = ScrollController();

    return DefaultTabController(
      initialIndex: 1,
      length: 2, // تعداد تب‌ها
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          bottom: TabBar(
              onTap: (index) {
                if (index == 0) {
                  fullReportController
                              .selectedreport[0].report.hasUserChartView ==
                          true
                      ? _onChartTabSelected(context)
                      : Network.showInternetError(
                          context, GeneralConstant().permissiontSubMessage);
                }
              },
              tabs: const [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Tab(
                      icon: Icon(
                        FontAwesomeIcons.chartPie,
                        color: kPrimaryColor,
                        size: 20.0,
                      ),
                    ),
                  ],
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Tab(
                            icon: Icon(
                          FontAwesomeIcons.tableList,
                          color: kPrimaryColor,
                          size: 20.0,
                        )),
                      ]),
                )
              ]),
        ),
        body: TabBarView(
          dragStartBehavior: DragStartBehavior.start,
          children: [
            // صفحه نمودارها
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Expanded(
                flex: 7,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: kDefaultPadding,
                    horizontal: kDefaultPadding,
                  ),
                  child: Obx(
                    () => resultSearchController.chartWidget.isNotEmpty
                        ? PageView.builder(
                            controller: pageController,
                            itemCount: resultSearchController
                                .chartWidget.length, // تعداد صفحات
                            itemBuilder: (context, pageIndex) {
                              return Center(
                                child: SingleChildScrollView(
                                  child: Container(
                                    decoration: const BoxDecoration(
                                        border: Border(
                                            bottom: BorderSide(
                                                color: kPrimaryColor),
                                            top: BorderSide(
                                                color: kPrimaryColor)),
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(25),
                                            bottomRight: Radius.circular(25))),
                                    child: resultSearchController
                                        .chartWidget[pageIndex],
                                  ),
                                ),
                              );
                            },
                          )
                        : Container(),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Obx(() => resultSearchController.chartWidget.isNotEmpty
                    ? SizedBox(height: Get.height / 70)
                    : Container()),
              ),
              Expanded(
                flex: 1,
                child: Obx(() => resultSearchController.chartWidget.isNotEmpty
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          resultSearchController
                              .chartWidget.length, // تعداد صفحات
                          (index) => buildDot(index),
                        ),
                      )
                    : Container()),
              ),
            ]),
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
                                      myItems: [
                                        convertEnToFa(10.toString()),
                                        convertEnToFa(25.toString()),
                                        convertEnToFa(50.toString()),
                                        convertEnToFa(100.toString()),
                                      ],
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
                                              'FilterForm'
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
                                                  'FilterForm' &&
                                              fullReportController
                                                      .selectedreport[0]
                                                      .report
                                                      .hasExcelExport ==
                                                  'true'
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
                                          child: const FaIcon(
                                              FontAwesomeIcons.solidFileExcel),
                                        ),
                                        color: kSuccessColor,
                                        iconSize: SideMenuConstant().iconSize,
                                      ),
                                    ),
                                  ],
                                ),
                              ]))
                      : Container();
                }),
                fullReportController.selectedreport[0].report.scope ==
                        'FilterForm'
                    ? Expanded(
                        flex: 12,
                        child: Obx(() {
                          return resultSearchController.isWaiting.value
                              ? const Center(child: CircularProgressIndicator())
                              : resultSearchController.headers.isNotEmpty
                                  ? Column(
                                      children: [
                                        Expanded(
                                          child: Padding(
                                            padding: EdgeInsets.all(
                                                kDefaultPadding / 2),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: kCardColor),
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        kDefaultPadding / 2),
                                              ),
                                              child: Scrollbar(
                                                thumbVisibility: true,
                                                controller:
                                                    horizontalScrollController,
                                                child: SingleChildScrollView(
                                                  scrollDirection:
                                                      Axis.horizontal,
                                                  controller:
                                                      horizontalScrollController,
                                                  child: Scrollbar(
                                                    thumbVisibility: true,
                                                    controller:
                                                        mainScrollController,
                                                    child:
                                                        SingleChildScrollView(
                                                      controller:
                                                          mainScrollController,
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: DataTable(
                                                          columns: [
                                                            for (var columnIndex =
                                                                    0;
                                                                columnIndex <
                                                                    resultSearchController
                                                                        .headers
                                                                        .length;
                                                                columnIndex++)
                                                              DataColumn(
                                                                label: Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .center,
                                                                  children: [
                                                                    Padding(
                                                                      padding: const EdgeInsets
                                                                          .all(
                                                                          8.0),
                                                                      child:
                                                                          IconButton(
                                                                        tooltip:
                                                                            GeneralConstant().ascendingSort,
                                                                        onPressed:
                                                                            () async {
                                                                          // Clear searchs properly
                                                                          optionSearchController
                                                                              .searchs
                                                                              .clear();
                                                                          optionSearchController
                                                                              .update();

                                                                          // Sorting logic
                                                                          controller.sortByColumn(
                                                                              columnIndex,
                                                                              'ASC',
                                                                              true);

                                                                          // Add new search details
                                                                          optionSearchController
                                                                              .searchs
                                                                              .add(SearchModel(
                                                                            reportName:
                                                                                fullReportController.selectedreport[0].report.reportName,
                                                                            dbTableName:
                                                                                fullReportController.selectedreport[0].table[0].dbTableName,
                                                                            filterFormDtoList:
                                                                                optionSearchController.searchDetail.toJson(),
                                                                            pageSize:
                                                                                controller.pageSize,
                                                                            pageNumber:
                                                                                controller.pageNumber,
                                                                            sortType:
                                                                                controller.sortType,
                                                                            sortColumn:
                                                                                controller.sortColumn,
                                                                          ));
                                                                          optionSearchController
                                                                              .update();

                                                                          // Clear and reload data
                                                                          controller
                                                                              .datarows
                                                                              .clear();
                                                                          controller
                                                                              .update();
                                                                          await loadData(
                                                                              context);
                                                                        },
                                                                        icon: const Icon(
                                                                            color:
                                                                                kBlackColor,
                                                                            size:
                                                                                15,
                                                                            Icons.arrow_upward),
                                                                      ),
                                                                    ),
                                                                    Padding(
                                                                      padding: const EdgeInsets
                                                                          .all(
                                                                          8.0),
                                                                      child:
                                                                          IconButton(
                                                                        tooltip:
                                                                            GeneralConstant().descendingSort,
                                                                        onPressed:
                                                                            () async {
                                                                          // Clear searchs properly
                                                                          optionSearchController
                                                                              .searchs
                                                                              .clear();
                                                                          optionSearchController
                                                                              .update();

                                                                          // Sorting logic
                                                                          controller.sortByColumn(
                                                                              columnIndex,
                                                                              'DESC',
                                                                              false);

                                                                          // Add new search details
                                                                          optionSearchController
                                                                              .searchs
                                                                              .add(SearchModel(
                                                                            reportName:
                                                                                fullReportController.selectedreport[0].report.reportName,
                                                                            dbTableName:
                                                                                fullReportController.selectedreport[0].table[0].dbTableName,
                                                                            filterFormDtoList:
                                                                                optionSearchController.searchDetail.toJson(),
                                                                            pageSize:
                                                                                controller.pageSize,
                                                                            pageNumber:
                                                                                controller.pageNumber,
                                                                            sortType:
                                                                                controller.sortType,
                                                                            sortColumn:
                                                                                controller.sortColumn,
                                                                          ));
                                                                          optionSearchController
                                                                              .update();

                                                                          // Clear and reload data
                                                                          controller
                                                                              .datarows
                                                                              .clear();
                                                                          controller
                                                                              .update();
                                                                          await loadData(
                                                                              context);
                                                                        },
                                                                        icon: const Icon(
                                                                            color:
                                                                                kBlackColor,
                                                                            size:
                                                                                15,
                                                                            Icons.arrow_downward),
                                                                      ),
                                                                    ),
                                                                    Text(
                                                                      resultSearchController
                                                                          .headers[
                                                                              columnIndex]
                                                                          .toString(),
                                                                      style: Responsive.isDesktop(
                                                                              context)
                                                                          ? CustomTextStyle()
                                                                              .textStyleDesktopKprimaryColorTitr
                                                                          : CustomTextStyle()
                                                                              .textStyleDesktopKprimaryColorTitr,
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            DataColumn(
                                                              label: Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .center,
                                                                children: [
                                                                  Text(
                                                                    GeneralConstant()
                                                                        .row, // عنوان ستون شماره ردیف
                                                                    style: Responsive.isDesktop(
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
                                                          rows: _buildRows(
                                                              context,
                                                              controller
                                                                  .datarows), // ردیف‌های جدول
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    )
                                  : Container();
                        }),
                      )
                    : Expanded(
                        flex: 12,
                        child: Obx(() => resultSearchController
                                .headers.isNotEmpty
                            ? Text('')
                            : SingleChildScrollView(
                                padding: EdgeInsets.all(kDefaultPadding * 2),
                                child: Text(jsonController.jsonText.value))),
                      ),
                // دکمه‌های صفحه‌بندی
                // Expanded(
                //   flex: 1,
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.center,
                //     children: [
                //       Obx(() => resultSearchController.datarows.isNotEmpty
                //           ? Padding(
                //               padding: const EdgeInsets.only(bottom: 8.0),
                //               child: Row(children: [
                //                 resultSearchController.result[0].last == false
                //                     ? IconButton(
                //                         icon: const Icon(Icons.chevron_left),
                //                         onPressed: () async {
                //                           controller.datarows.clear();
                //                           controller.update();

                //                           controller.resetLastPage(
                //                               resultSearchController
                //                                       .result[0].totalPages -
                //                                   1);
                //                           optionSearchController.update();
                //                           optionSearchController.searchs.add(
                //                               SearchModel(
                //                                   reportName:
                //                                       fullReportController
                //                                           .selectedreport[0]
                //                                           .report
                //                                           .reportName,
                //                                   dbTableName:
                //                                       fullReportController
                //                                           .selectedreport[0]
                //                                           .table[0]
                //                                           .dbTableName,
                //                                   filterFormDtoList:
                //                                       optionSearchController
                //                                           .searchDetail
                //                                           .toJson(),
                //                                   pageSize: 9.obs,
                //                                   pageNumber:
                //                                       controller.pageNumber,
                //                                   sortType: controller.sortType,
                //                                   sortColumn:
                //                                       controller.columnTitle));

                //                           optionSearchController.update();
                //                           controller.datarows.clear();
                //                           controller.update();
                //                           await loadData(context);
                //                         },
                //                       )
                //                     : Container(),
                //                 resultSearchController.result[0].last == false
                //                     ? IconButton(
                //                         icon: const Icon(Icons.arrow_back),
                //                         onPressed: () async {
                //                           controller.datarows.clear();
                //                           controller.update();

                //                           controller.nextPage();
                //                           optionSearchController.update();
                //                           optionSearchController.searchs.add(
                //                               SearchModel(
                //                                   reportName:
                //                                       fullReportController
                //                                           .selectedreport[0]
                //                                           .report
                //                                           .reportName,
                //                                   dbTableName:
                //                                       fullReportController
                //                                           .selectedreport[0]
                //                                           .table[0]
                //                                           .dbTableName,
                //                                   filterFormDtoList:
                //                                       optionSearchController
                //                                           .searchDetail
                //                                           .toJson(),
                //                                   pageSize: 9.obs,
                //                                   pageNumber:
                //                                       controller.pageNumber,
                //                                   sortType: controller.sortType,
                //                                   sortColumn:
                //                                       controller.columnTitle));

                //                           optionSearchController.update();
                //                           controller.datarows.clear();
                //                           controller.update();
                //                           await loadData(context);
                //                         },
                //                       )
                //                     : Container(),
                //                 for (int i = min(
                //                         10,
                //                         (resultSearchController
                //                                     .result[0].totalPages -
                //                                 1) -
                //                             controller.pageNumber.value);
                //                     i >= 1;
                //                     i--)
                //                   Padding(
                //                     padding: const EdgeInsets.symmetric(
                //                         horizontal: 3.0),
                //                     child: GestureDetector(
                //                       onTap: () async {
                //                         controller.updatePage(i);
                //                         optionSearchController.update();
                //                         controller.datarows.clear();
                //                         controller.update();
                //                         optionSearchController.update();
                //                         optionSearchController.searchs.add(
                //                             SearchModel(
                //                                 reportName: fullReportController
                //                                     .selectedreport[0]
                //                                     .report
                //                                     .reportName,
                //                                 dbTableName:
                //                                     fullReportController
                //                                         .selectedreport[0]
                //                                         .table[0]
                //                                         .dbTableName,
                //                                 filterFormDtoList:
                //                                     optionSearchController
                //                                         .searchDetail
                //                                         .toJson(),
                //                                 pageSize: 9.obs,
                //                                 pageNumber:
                //                                     controller.pageNumber,
                //                                 sortType: controller.sortType,
                //                                 sortColumn:
                //                                     controller.columnTitle));

                //                         optionSearchController.update();
                //                         controller.datarows.clear();
                //                         controller.update();
                //                         await loadData(context);
                //                       },
                //                       child: CircleAvatar(
                //                         backgroundColor:
                //                             kPrimaryColor, // Change to your preferred color
                //                         child: Text(
                //                           (i + controller.pageNumber.value)
                //                               .toString(),
                //                           style: const TextStyle(
                //                               color: kCardColor), // Text color
                //                         ),
                //                       ),
                //                     ),
                //                   ),
                //                 resultSearchController.result[0].number != 0
                //                     ? IconButton(
                //                         icon: const Icon(Icons.arrow_forward),
                //                         onPressed: () async {
                //                           controller.datarows.clear();
                //                           optionSearchController.update();

                //                           controller.previousPage();
                //                           optionSearchController.update();
                //                           optionSearchController.searchs.add(
                //                               SearchModel(
                //                                   reportName:
                //                                       fullReportController
                //                                           .selectedreport[0]
                //                                           .report
                //                                           .reportName,
                //                                   dbTableName:
                //                                       fullReportController
                //                                           .selectedreport[0]
                //                                           .table[0]
                //                                           .dbTableName,
                //                                   filterFormDtoList:
                //                                       optionSearchController
                //                                           .searchDetail
                //                                           .toJson(),
                //                                   pageSize: 9.obs,
                //                                   pageNumber:
                //                                       controller.pageNumber,
                //                                   sortType: controller.sortType,
                //                                   sortColumn:
                //                                       controller.columnTitle));
                //                           optionSearchController.update();
                //                           controller.datarows.clear();
                //                           controller.update();
                //                           await loadData(context);
                //                         },
                //                       )
                //                     : Container(),
                //                 resultSearchController.result[0].number != 0
                //                     ? IconButton(
                //                         icon: const Icon(Icons.chevron_right),
                //                         onPressed: () async {
                //                           controller.datarows.clear();
                //                           optionSearchController.update();

                //                           controller.resetFirstPage();
                //                           optionSearchController.update();
                //                           optionSearchController.searchs.add(
                //                               SearchModel(
                //                                   dbTableName:
                //                                       fullReportController
                //                                           .selectedreport[0]
                //                                           .table[0]
                //                                           .dbTableName,
                //                                   filterFormDtoList:
                //                                       optionSearchController
                //                                           .searchDetail
                //                                           .toJson(),
                //                                   pageSize: 9.obs,
                //                                   pageNumber:
                //                                       controller.pageNumber,
                //                                   sortType: controller.sortType,
                //                                   sortColumn:
                //                                       controller.columnTitle,
                //                                   reportName:
                //                                       fullReportController
                //                                           .selectedreport[0]
                //                                           .report
                //                                           .reportName));
                //                           optionSearchController.update();
                //                           controller.datarows.clear();
                //                           controller.update();
                //                           await loadData(context);
                //                         },
                //                       )
                //                     : Container(),
                //                 // MyFormBuilderDropdown(
                //                 //     myItems: const [10, 25, 30, 50, 100],
                //                 //     labelTitle: 'تعداد رکوردها در صفحه',
                //                 //     nameDropDown: 'ps',
                //                 //     hintTitle: 'تعداد رکوردها در صفحه',
                //                 //     myController: controller.ps)
                //               ]),
                //             )
                //           : Container())
                //     ],
                //   ),
                // ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  double _calculateTableWidth(List headers) {
    const double columnWidth = 150.0;

    return headers.length * columnWidth;
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
            MouseRegion(
              cursor: SystemMouseCursors.click,
              child: GestureDetector(
                onTap: () async {
                  Clipboard.setData(
                      ClipboardData(text: datarows[index][i].toString()));

                  resultSearchController.setClipboardData(
                      datarows[index][i].toString(), index);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: SelectableText(
                        (datarows[index][i].toString().length > 50)
                            ? convertEnToFa(
                                '${datarows[index][i].toString().substring(0, 50)}...')
                            : convertEnToFa(datarows[index][i].toString()),
                        textAlign: TextAlign.right,
                        style: Responsive.isDesktop(context)
                            ? CustomTextStyle().textStyleDesktopkBlackColor
                            : CustomTextStyle().textStyleDesktopkBlackColor,
                        maxLines: 1,
                      ),
                    ),
                    const SizedBox(width: 5),
                    Obx(
                      () => Tooltip(
                        message: resultSearchController.copyIndex.value ==
                                    index &&
                                resultSearchController.clipBoardData.value ==
                                    datarows[index][i].toString()
                            ? GeneralConstant().successCopy
                            : GeneralConstant().beforeCopy,
                        child: Icon(
                          resultSearchController.copyIndex.value == index &&
                                  resultSearchController.clipBoardData.value ==
                                      datarows[index][i].toString()
                              ? Icons.check_circle_outline
                              : Icons.copy_sharp,
                          size: 15,
                          color: resultSearchController.copyIndex.value ==
                                      index &&
                                  resultSearchController.clipBoardData.value ==
                                      datarows[index][i].toString()
                              ? kCyanColor
                              : kSecondaryColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      }
      cells.add(
        DataCell(
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                convertEnToFa((index +
                        1 +
                        (resultSearchController.pageNumber.value *
                            resultSearchController.pageSize.value))
                    .toString()), // شماره ردیف به فارسی
                style: Responsive.isDesktop(context)
                    ? CustomTextStyle().textStyleDesktopkBlackColor
                    : CustomTextStyle().textStyleDesktopkBlackColor,
              ),
            ],
          ),
        ),
      );
      rows.add(DataRow(cells: cells));
    }

    return rows;
  }
}


  // تابع برای مرتب‌سازی ستون‌ها
 
