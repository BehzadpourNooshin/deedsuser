import 'dart:math';

import 'package:deedsuser/controllers/full_report_controller.dart';
import 'package:deedsuser/controllers/json_controller.dart';
import 'package:deedsuser/controllers/resultsearch_controller.dart';
import 'package:deedsuser/controllers/search_controller.dart';
import 'package:deedsuser/functions/datatabletoexcel.dart';
import 'package:deedsuser/functions/datatabletopdf.dart';
import 'package:deedsuser/functions/dialog.dart';
import 'package:deedsuser/functions/loaddata.dart';
import 'package:deedsuser/models/search_model.dart';
import 'package:deedsuser/utils/api_service.dart';
import 'package:deedsuser/utils/constant.dart';
import 'package:deedsuser/utils/responsive.dart';
import 'package:deedsuser/views/widgets/avatarbutton.dart';
import 'package:deedsuser/views/widgets/jsonviewtable.dart';
import 'package:deedsuser/views/widgets/mydropdownwidgetpagesize.dart';
import 'package:deedsuser/views/widgets/persiannumbertext.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:persian_tools/persian_tools.dart';

class MyDataTable extends GetView<ResultSearchController> {
  const MyDataTable({super.key});

  @override
  Widget build(BuildContext context) {
    FullReportController fullReportController = Get.put(FullReportController());
    OptionSearchController optionSearchController =
        Get.put(OptionSearchController());
    optionSearchController.searchs.clear();
    ResultSearchController resultSearchController =
        Get.put(ResultSearchController());
    JsonController jsonController = Get.put(JsonController());
    final ScrollController mainScrollController = ScrollController();
    final ScrollController horizontalScrollController = ScrollController();
    resultSearchController.datarow.clear();
    resultSearchController.header.clear();
    resultSearchController.update();

    return DefaultTabController(
      initialIndex: 0,
      length: 1, // تعداد تب‌ها
      child: Scaffold(
        body: Column(
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
                                    convertEnToFa('10'),
                                    convertEnToFa('25'),
                                    convertEnToFa('50'),
                                    convertEnToFa('100')
                                  ],
                                ),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Visibility(
                                  visible: fullReportController
                                              .selectedreport[0].report.scope ==
                                          'FilterForm'
                                      ? true
                                      : false,
                                  child: IconButton(
                                    onPressed: () async {
                                      controller.update();
                                      fullReportController.selectedreport[0]
                                                  .report.hasUserPdfExport ==
                                              true
                                          ? {
                                              controller.datarows.clear(),
                                              controller.update(),
                                              optionSearchController.searchs
                                                  .clear(),
                                              optionSearchController.update(),
                                              optionSearchController.searchs
                                                  .add(SearchModel(
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
                                              optionSearchController.update(),
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
                                      padding:
                                          EdgeInsets.all(kDefaultPadding / 4),
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
                                          fullReportController.selectedreport[0]
                                                  .report.hasExcelExport ==
                                              'true'
                                      ? true
                                      : false,
                                  child: IconButton(
                                    onPressed: () async {
                                      controller.update();
                                      fullReportController.selectedreport[0]
                                                  .report.hasUserExcelExport ==
                                              true
                                          ? {
                                              controller.datarows.clear(),
                                              controller.update(),
                                              optionSearchController.searchs
                                                  .clear(),
                                              optionSearchController.update(),
                                              optionSearchController.searchs
                                                  .add(SearchModel(
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
                                              optionSearchController.update(),
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
                                      padding:
                                          EdgeInsets.all(kDefaultPadding / 4),
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
            // دیتاتیبل
            fullReportController.selectedreport[0].report.scope == 'FilterForm'
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
                                        padding:
                                            EdgeInsets.all(kDefaultPadding / 2),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            border:
                                                Border.all(color: kCardColor),
                                            borderRadius: BorderRadius.circular(
                                                kDefaultPadding / 2),
                                          ),
                                          child: Scrollbar(
                                            thumbVisibility: true,
                                            controller:
                                                horizontalScrollController,
                                            child: SingleChildScrollView(
                                              scrollDirection: Axis.horizontal,
                                              controller:
                                                  horizontalScrollController,
                                              child: Scrollbar(
                                                thumbVisibility: true,
                                                controller:
                                                    mainScrollController,
                                                child: SingleChildScrollView(
                                                  controller:
                                                      mainScrollController,
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
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
                                                                IconButton(
                                                                  tooltip:
                                                                      GeneralConstant()
                                                                          .ascendingSort,
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
                                                                        .add(
                                                                            SearchModel(
                                                                      reportName: fullReportController
                                                                          .selectedreport[
                                                                              0]
                                                                          .report
                                                                          .reportName,
                                                                      dbTableName: fullReportController
                                                                          .selectedreport[
                                                                              0]
                                                                          .table[
                                                                              0]
                                                                          .dbTableName,
                                                                      filterFormDtoList: optionSearchController
                                                                          .searchDetail
                                                                          .toJson(),
                                                                      pageSize:
                                                                          controller
                                                                              .pageSize,
                                                                      pageNumber:
                                                                          controller
                                                                              .pageNumber,
                                                                      sortType:
                                                                          controller
                                                                              .sortType,
                                                                      sortColumn:
                                                                          controller
                                                                              .sortColumn,
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
                                                                      size: 15,
                                                                      Icons
                                                                          .arrow_upward),
                                                                ),
                                                                IconButton(
                                                                  tooltip:
                                                                      GeneralConstant()
                                                                          .descendingSort,
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
                                                                        .add(
                                                                            SearchModel(
                                                                      reportName: fullReportController
                                                                          .selectedreport[
                                                                              0]
                                                                          .report
                                                                          .reportName,
                                                                      dbTableName: fullReportController
                                                                          .selectedreport[
                                                                              0]
                                                                          .table[
                                                                              0]
                                                                          .dbTableName,
                                                                      filterFormDtoList: optionSearchController
                                                                          .searchDetail
                                                                          .toJson(),
                                                                      pageSize:
                                                                          controller
                                                                              .pageSize,
                                                                      pageNumber:
                                                                          controller
                                                                              .pageNumber,
                                                                      sortType:
                                                                          controller
                                                                              .sortType,
                                                                      sortColumn:
                                                                          controller
                                                                              .sortColumn,
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
                                                                      size: 15,
                                                                      Icons
                                                                          .arrow_downward),
                                                                ),
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
                    child: Obx(() => resultSearchController.headers.isNotEmpty
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
            //                                   reportName: fullReportController
            //                                       .selectedreport[0]
            //                                       .report
            //                                       .reportName,
            //                                   dbTableName: fullReportController
            //                                       .selectedreport[0]
            //                                       .table[0]
            //                                       .dbTableName,
            //                                   filterFormDtoList:
            //                                       optionSearchController
            //                                           .searchDetail
            //                                           .toJson(),
            //                                   pageSize: controller.pageSize,
            //                                   pageNumber: controller.pageNumber,
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
            //                           controller.updatePage(controller
            //                                   .pageNumber.value +
            //                               min(
            //                                   10,
            //                                   (resultSearchController.result[0]
            //                                               .totalPages -
            //                                           1) -
            //                                       controller.pageNumber.value));

            //                           optionSearchController.update();
            //                           optionSearchController.searchs.add(
            //                               SearchModel(
            //                                   reportName: fullReportController
            //                                       .selectedreport[0]
            //                                       .report
            //                                       .reportName,
            //                                   dbTableName: fullReportController
            //                                       .selectedreport[0]
            //                                       .table[0]
            //                                       .dbTableName,
            //                                   filterFormDtoList:
            //                                       optionSearchController
            //                                           .searchDetail
            //                                           .toJson(),
            //                                   pageSize: controller.pageSize,
            //                                   pageNumber: controller.pageNumber,
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
            //                     i >= 0;
            //                     i--)
            //                   Padding(
            //                     padding:
            //                         const EdgeInsets.symmetric(horizontal: 3.0),
            //                     child: MouseRegion(
            //                       cursor: SystemMouseCursors.click,
            //                       child: GestureDetector(
            //                         onTap: controller.pageNumber.value != i
            //                             ? () async {
            //                                 controller.updatePage(i);
            //                                 optionSearchController.update();
            //                                 controller.datarows.clear();
            //                                 controller.update();
            //                                 optionSearchController.update();
            //                                 optionSearchController.searchs.add(
            //                                     SearchModel(
            //                                         reportName:
            //                                             fullReportController
            //                                                 .selectedreport[0]
            //                                                 .report
            //                                                 .reportName,
            //                                         dbTableName:
            //                                             fullReportController
            //                                                 .selectedreport[0]
            //                                                 .table[0]
            //                                                 .dbTableName,
            //                                         filterFormDtoList:
            //                                             optionSearchController
            //                                                 .searchDetail
            //                                                 .toJson(),
            //                                         pageSize:
            //                                             controller.pageSize,
            //                                         pageNumber:
            //                                             controller.pageNumber,
            //                                         sortType:
            //                                             controller.sortType,
            //                                         sortColumn: controller
            //                                             .columnTitle));

            //                                 optionSearchController.update();
            //                                 controller.datarows.clear();
            //                                 controller.update();
            //                                 await loadData(context);
            //                               }
            //                             : null,
            //                         child: CircleAvatar(
            //                           backgroundColor: controller
            //                                       .pageNumber.value ==
            //                                   i
            //                               ? Colors.grey // رنگ برای صفحه فعلی
            //                               : kPrimaryColor,
            //                           child: Text(
            //                             (i + 1).toString(),
            //                             style: const TextStyle(
            //                                 color: kCardColor), // رنگ متن
            //                           ),
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
            //                           controller.updatePage(controller
            //                                   .pageNumber.value -
            //                               min(
            //                                   10,
            //                                   (resultSearchController.result[0]
            //                                               .totalPages -
            //                                           1) -
            //                                       controller.pageNumber.value));
            //                           optionSearchController.update();
            //                           optionSearchController.searchs.add(
            //                               SearchModel(
            //                                   reportName: fullReportController
            //                                       .selectedreport[0]
            //                                       .report
            //                                       .reportName,
            //                                   dbTableName: fullReportController
            //                                       .selectedreport[0]
            //                                       .table[0]
            //                                       .dbTableName,
            //                                   filterFormDtoList:
            //                                       optionSearchController
            //                                           .searchDetail
            //                                           .toJson(),
            //                                   pageSize: controller.pageSize,
            //                                   pageNumber: controller.pageNumber,
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
            //                                   pageNumber: controller.pageNumber,
            //                                   sortType: controller.sortType,
            //                                   sortColumn:
            //                                       controller.columnTitle,
            //                                   reportName: fullReportController
            //                                       .selectedreport[0]
            //                                       .report
            //                                       .reportName));
            //                           optionSearchController.update();
            //                           controller.datarows.clear();
            //                           controller.update();
            //                           await loadData(context);
            //                         },
            //                       )
            //                     : Container(),
            //               ]),
            //             )
            //           : Container())
            //     ],
            //   ),
            // ),
            SizedBox(height: 16),
            Obx(
              () => resultSearchController.datarows.isNotEmpty
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          icon: Icon(Icons.first_page),
                          onPressed: () async {
                            final totalPages =
                                resultSearchController.result[0].totalPages;

                            showDialogApiCallBefore(context);
                            controller.updatePage(totalPages - 1);
                            controller.datarows.clear();
                            optionSearchController.update();

                            optionSearchController.searchs.add(SearchModel(
                                dbTableName: fullReportController
                                    .selectedreport[0].table[0].dbTableName,
                                filterFormDtoList: optionSearchController
                                    .searchDetail
                                    .toJson(),
                                pageSize: controller.pageSize,
                                pageNumber: controller.pageNumber,
                                sortType: controller.sortType,
                                sortColumn: controller.columnTitle,
                                reportName: fullReportController
                                    .selectedreport[0].report.reportName));
                            optionSearchController.update();
                            controller.datarows.clear();
                            controller.update();
                            await loadData(context);
                            apiCallAfter(context);
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.arrow_back_ios),
                          onPressed: () async {
                            final totalPages =
                                resultSearchController.result[0].totalPages;

                            if (controller.pageNumber.value + 10 < totalPages) {
                              showDialogApiCallBefore(context);
                              controller
                                  .updatePage(controller.pageNumber.value + 10);
                              controller.datarows.clear();
                              optionSearchController.update();

                              optionSearchController.searchs.add(SearchModel(
                                  dbTableName: fullReportController
                                      .selectedreport[0].table[0].dbTableName,
                                  filterFormDtoList: optionSearchController
                                      .searchDetail
                                      .toJson(),
                                  pageSize: controller.pageSize,
                                  pageNumber: controller.pageNumber,
                                  sortType: controller.sortType,
                                  sortColumn: controller.columnTitle,
                                  reportName: fullReportController
                                      .selectedreport[0].report.reportName));
                              optionSearchController.update();
                              controller.datarows.clear();
                              controller.update();
                              await loadData(context);
                              apiCallAfter(context);
                            } else {
                              showDialogApiCallBefore(context);
                              controller.updatePage(totalPages - 1);
                              controller.datarows.clear();
                              optionSearchController.update();

                              optionSearchController.searchs.add(SearchModel(
                                  dbTableName: fullReportController
                                      .selectedreport[0].table[0].dbTableName,
                                  filterFormDtoList: optionSearchController
                                      .searchDetail
                                      .toJson(),
                                  pageSize: controller.pageSize,
                                  pageNumber: controller.pageNumber,
                                  sortType: controller.sortType,
                                  sortColumn: controller.columnTitle,
                                  reportName: fullReportController
                                      .selectedreport[0].report.reportName));
                              optionSearchController.update();
                              controller.datarows.clear();
                              controller.update();
                              await loadData(context);
                              apiCallAfter(context);
                            }
                          },
                        ),
                        for (int i = 9; i >= 0; i--)
                          Obx(() {
                            int pageIndex = controller.pageNumber.value + i;
                            if (pageIndex <
                                (resultSearchController.result[0].totalPages)) {
                              return AvatarButton(
                                text: (pageIndex + 1).toString(),
                                isActive:
                                    controller.pageNumber.value == pageIndex,
                                onPressed: () async {
                                  showDialogApiCallBefore(context);
                                  controller.updatePage(pageIndex);
                                  controller.datarows.clear();
                                  optionSearchController.update();

                                  optionSearchController.searchs.add(
                                      SearchModel(
                                          dbTableName: fullReportController
                                              .selectedreport[0]
                                              .table[0]
                                              .dbTableName,
                                          filterFormDtoList:
                                              optionSearchController
                                                  .searchDetail
                                                  .toJson(),
                                          pageSize: controller.pageSize,
                                          pageNumber: controller.pageNumber,
                                          sortType: controller.sortType,
                                          sortColumn: controller.columnTitle,
                                          reportName: fullReportController
                                              .selectedreport[0]
                                              .report
                                              .reportName));
                                  optionSearchController.update();
                                  controller.datarows.clear();
                                  controller.update();
                                  await loadData(context);
                                  apiCallAfter(context);
                                },
                              );
                            } else {
                              return SizedBox();
                            }
                          }),
                        IconButton(
                          icon: Icon(Icons.arrow_forward_ios),
                          onPressed: () async {
                            if (controller.pageNumber.value > 10) {
                              showDialogApiCallBefore(context);
                              controller
                                  .updatePage(controller.pageNumber.value - 10);
                              controller.datarows.clear();
                              optionSearchController.update();

                              optionSearchController.searchs.add(SearchModel(
                                  dbTableName: fullReportController
                                      .selectedreport[0].table[0].dbTableName,
                                  filterFormDtoList: optionSearchController
                                      .searchDetail
                                      .toJson(),
                                  pageSize: controller.pageSize,
                                  pageNumber: controller.pageNumber,
                                  sortType: controller.sortType,
                                  sortColumn: controller.columnTitle,
                                  reportName: fullReportController
                                      .selectedreport[0].report.reportName));
                              optionSearchController.update();
                              controller.datarows.clear();
                              controller.update();
                              await loadData(context);
                              apiCallAfter(context);
                            } else {
                              showDialogApiCallBefore(context);
                              controller.updatePage(0);
                              controller.datarows.clear();
                              optionSearchController.update();

                              optionSearchController.searchs.add(SearchModel(
                                  dbTableName: fullReportController
                                      .selectedreport[0].table[0].dbTableName,
                                  filterFormDtoList: optionSearchController
                                      .searchDetail
                                      .toJson(),
                                  pageSize: controller.pageSize,
                                  pageNumber: controller.pageNumber,
                                  sortType: controller.sortType,
                                  sortColumn: controller.columnTitle,
                                  reportName: fullReportController
                                      .selectedreport[0].report.reportName));
                              optionSearchController.update();
                              controller.datarows.clear();
                              controller.update();
                              await loadData(context);
                              apiCallAfter(context);
                            }
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.last_page),
                          onPressed: () async {
                            showDialogApiCallBefore(context);
                            controller.updatePage(0);
                            controller.datarows.clear();
                            optionSearchController.update();

                            optionSearchController.searchs.add(SearchModel(
                                dbTableName: fullReportController
                                    .selectedreport[0].table[0].dbTableName,
                                filterFormDtoList: optionSearchController
                                    .searchDetail
                                    .toJson(),
                                pageSize: controller.pageSize,
                                pageNumber: controller.pageNumber,
                                sortType: controller.sortType,
                                sortColumn: controller.columnTitle,
                                reportName: fullReportController
                                    .selectedreport[0].report.reportName));
                            optionSearchController.update();
                            controller.datarows.clear();
                            controller.update();
                            await loadData(context);

                            apiCallAfter(context);
                          },
                        ),
                      ],
                    )
                  : Container(),
            )
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

double _calculateTableWidth(List headers) {
  const double columnWidth = 150.0;

  return headers.length * columnWidth;
}
