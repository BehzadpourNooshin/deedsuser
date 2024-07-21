import 'package:deedsuser/controllers/filter_controller.dart';
import 'package:deedsuser/controllers/full_report_controller.dart';
import 'package:deedsuser/views/widgets/datatablechart.dart';
import 'package:deedsuser/views/widgets/datatablewithoutchart.dart';
import 'package:deedsuser/views/widgets/jsonviewer.dart';
import 'package:deedsuser/views/widgets/jsonviewtable.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:deedsuser/utils/constant.dart';
import 'package:deedsuser/utils/responsive.dart';
import 'package:deedsuser/views/pages/portal.dart';

class MyReportView extends StatelessWidget {
  const MyReportView({super.key});

  @override
  Widget build(BuildContext context) {
    FullReportController fullReportController = Get.put(FullReportController());

    FilterController filterController = Get.put(FilterController());

    filterController.filter.isEmpty
        ? {
            fullReportController.loadReportName(),
          }
        : null;

    return PortalMasterLayout(
        body: Row(children: [
      Expanded(
          flex: 4,
          child: Column(children: [
            SideMenuConstant().sizedBoxSideMenu,
            Expanded(
                flex: 1,
                child: Column(children: [
                  Obx(
                    () => Text(
                      fullReportController.selectedreport.isNotEmpty
                          ? fullReportController
                              .selectedreport[0].report.displayTitle
                          : '',
                      style: Responsive.isDesktop(context)
                          ? CustomTextStyle()
                              .textStyleDesktopBigTitrKprimaryColor
                          : CustomTextStyle()
                              .textStyleDesktopBigTitrKprimaryColor,
                    ),
                  ),
                  Obx(() => Text(
                        fullReportController.selectedreport.isNotEmpty
                            ? fullReportController
                                .selectedreport[0].report.reportDescription
                            : '',
                        style: Responsive.isDesktop(context)
                            ? CustomTextStyle().textStyleDesktopkBlackColor
                            : CustomTextStyle().textStyleDesktopkBlackColor,
                      )),
                ])),
            Expanded(
                flex: 14,
                child: Obx(() => fullReportController.selectedreport.isNotEmpty
                    ? fullReportController.selectedreport[0].report.scope ==
                            'FilterForm'
                        ? fullReportController
                                    .selectedreport[0].report.hasChart ==
                                'true'
                            ? const MyDataTableChart()
                            : const MyDataTable()
                        : fullReportController
                                .selectedreport[0].report.hasUserPdfExport
                            ? const MyJsonViewrTable()
                            : const MyJsonViewr()
                    : Container()))
          ]))
    ]));

    //
  }
}
