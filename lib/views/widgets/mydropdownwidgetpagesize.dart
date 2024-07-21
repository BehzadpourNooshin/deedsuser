import 'package:deedsuser/controllers/full_report_controller.dart';
import 'package:deedsuser/controllers/loginresponse_controller.dart';
import 'package:deedsuser/controllers/resultsearch_controller.dart';
import 'package:deedsuser/controllers/search_controller.dart';
import 'package:deedsuser/functions/dialog.dart';
import 'package:deedsuser/models/search_model.dart';
import 'package:deedsuser/utils/api_service.dart';
import 'package:deedsuser/utils/constant.dart';
import 'package:deedsuser/utils/responsive.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyFormBuilderDropdownPageSize extends StatelessWidget {
  final String labelTitle;
  final String nameDropDown;
  final String hintTitle;
  final String errorTitle;
  final TextEditingController myController;
  final List myItems;

  const MyFormBuilderDropdownPageSize(
      {super.key,
      required this.labelTitle,
      required this.nameDropDown,
      required this.hintTitle,
      this.errorTitle = "",
      this.myItems = const [],
      required this.myController});
  @override
  Widget build(BuildContext context) {
    ResultSearchController resultSearchController =
        Get.put(ResultSearchController());
    FullReportController fullReportController = Get.put(FullReportController());
    OptionSearchController optionSearchController =
        Get.put(OptionSearchController());
    return DropdownButtonFormField(
        style: Responsive.isDesktop(context)
            ? CustomTextStyle().textStyleDesktopkSecondrayColor
            : CustomTextStyle().textStyleTabletkSecondrayColor,
        focusColor: kCardColor.withOpacity(0),
        dropdownColor: kCardColor,
        isExpanded: true,
        isDense: true,
        autofocus: false,
        hint: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              hintTitle,
              style: Responsive.isDesktop(context)
                  ? CustomTextStyle().textStyleDesktopkSecondrayColor
                  : CustomTextStyle().textStyleTabletkSecondrayColor,
            )
          ],
        ),
        items: myItems
            .map((e) => DropdownMenuItem<int>(
                value: e,
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                  Text(e.toString(),
                      style: Responsive.isDesktop(context)
                          ? CustomTextStyle().textStyleDesktopkSecondrayColor
                          : CustomTextStyle().textStyleTabletkSecondrayColor),
                ])))
            .toList(),
        onChanged: (value) async {
          resultSearchController.resetFirstPage();
          resultSearchController.pageSize.value = value!;
          resultSearchController.update();
          resultSearchController.datarows.clear();
          resultSearchController.update();
          optionSearchController.searchs.clear();
          optionSearchController.update();
          optionSearchController.searchs.add(SearchModel(
              reportName:
                  fullReportController.selectedreport[0].report.reportName,
              dbTableName:
                  fullReportController.selectedreport[0].table[0].dbTableName,
              filterFormDtoList: optionSearchController.searchDetail.toJson(),
              pageSize: resultSearchController.pageSize,
              pageNumber: resultSearchController.pageNumber,
              sortType: resultSearchController.sortType,
              sortColumn: resultSearchController.columnTitle));
          optionSearchController.update();
          resultSearchController.datarows.clear();
          resultSearchController.update();

          await _loadData(context);
        },
        onSaved: (value) {},
        focusNode: FocusNode(),
        autovalidateMode: AutovalidateMode.onUserInteraction,
        decoration: InputDecoration(
          floatingLabelAlignment: FloatingLabelAlignment.center,
          alignLabelWithHint: true,
          floatingLabelBehavior: FloatingLabelBehavior.always,
          errorBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: kErrorColor),
            //  borderRadius: BorderRadius.circular(15.0),
          ),
          errorStyle: Responsive.isDesktop(context)
              ? CustomTextStyle().textStyleDesktopKerrorColor
              : CustomTextStyle().textStyleTabletKerrorColor,
        ),
        validator: (value) {
          if (value.toString() == '') {
            return (errorTitle);
          }

          return null;
        });
  }
}

Future<void> _loadData(BuildContext context) async {
  final optionSearchController = Get.find<OptionSearchController>();
  final fullReportController = Get.find<FullReportController>();
  final loginResponseController = Get.find<LoginResponseController>();

  // ignore: unused_local_variable
  for (var item in optionSearchController.searchs) {}
  if (optionSearchController.searchs.isNotEmpty) {
    if (fullReportController.selectedreport[0].report.scope == 'FilterForm') {
      showDialogApiCallBefore(context);
      await Network()
          .getData(
        optionSearchController: optionSearchController,
        accessToken: loginResponseController.accesstoken.text,
      )
          .then((value) {
        apiCallAfter(context);

        if (!value) {
          Get.snackbar(
            SideMenuConstant().apiErrorTitle,
            SideMenuConstant().apiEmptySubTitle,
            backgroundColor: kErrorColor,
            colorText: kCardColor,
          );
        }
      });
    } else {
      showDialogApiCallBefore(context);
      await Network()
          .getDataJson(
        optionSearchController: optionSearchController,
        accessToken: loginResponseController.accesstoken.text,
      )
          .then((value) {
        apiCallAfter(context);

        if (!value) {
          Get.snackbar(
            SideMenuConstant().apiErrorTitle,
            SideMenuConstant().apiEmptySubTitle,
            backgroundColor: kErrorColor,
            colorText: kCardColor,
          );
        }
      });
    }
  } else {
    Get.snackbar(
      SideMenuConstant().apiErrorTitle,
      SideMenuConstant().apiEmptySubTitle,
      backgroundColor: kErrorColor,
      colorText: kCardColor,
    );
  }
}
