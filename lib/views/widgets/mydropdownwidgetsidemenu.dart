// ignore_for_file: deprecated_member_use

import 'package:deedsuser/controllers/filter_controller.dart';
import 'package:deedsuser/controllers/full_report_controller.dart';
import 'package:deedsuser/controllers/json_controller.dart';
import 'package:deedsuser/controllers/loginresponse_controller.dart';
import 'package:deedsuser/controllers/reportsbycategory_controller.dart';
import 'package:deedsuser/controllers/resultsearch_controller.dart';
import 'package:deedsuser/controllers/search_controller.dart';
import 'package:deedsuser/controllers/updateuser_controller.dart';
import 'package:deedsuser/functions/dialog.dart';
import 'package:deedsuser/utils/api_service.dart';
import 'package:deedsuser/utils/constant.dart';
import 'package:deedsuser/utils/responsive.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MySideMenuFormBuilderDropdown extends StatelessWidget {
  final String labelTitle;
  final String nameDropDown;
  final String errorTitle;
  final TextEditingController myController;
  final myItems;
  final String hintTitle;
  final UpdateUserController updateUserController;

  const MySideMenuFormBuilderDropdown(
      {super.key,
      required this.labelTitle,
      required this.hintTitle,
      required this.nameDropDown,
      this.errorTitle = "",
      required this.updateUserController,
      required this.myItems,
      required this.myController});
  @override
  Widget build(BuildContext context) {
    FilterController formController = Get.put(FilterController());
    ReportsByCategoryController reportsByCategoryController =
        Get.put(ReportsByCategoryController());
    List<DropdownMenuItem<String>> dropdownItems = [];

    for (var category in reportsByCategoryController.reportsbycategory) {
      for (var report in category.reports) {
        dropdownItems.add(
          DropdownMenuItem<String>(
            alignment: Alignment.topRight,
            value: report.reportName,
            child: Text(
              overflow: TextOverflow.clip,
              textDirection: TextDirection.ltr,
              report.displayTitle,
              textAlign: TextAlign.right,
              style: Responsive.isDesktop(context)
                  ? CustomTextStyle().textStyleDesktopkCardColor
                  : CustomTextStyle().textStyleTabletKprimaryColor,
            ),
          ),
        );
      }
    }

// Use dropdownItems in your DropdownButton

    FullReportController fullReportController = Get.put(FullReportController());
    LoginResponseController loginResponseController =
        Get.put(LoginResponseController());
    OptionSearchController optionSearchController =
        Get.put(OptionSearchController());
    ResultSearchController resultSearchController =
        Get.put(ResultSearchController());
    JsonController jsonController = Get.put(JsonController());
    return Container(
      color: kCardColor,
      child: DropdownButtonFormField(
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
          alignment: Alignment.centerLeft,
          dropdownColor: kCardColor,
          iconEnabledColor: kPrimaryColor,
          items: myItems,
          style: Responsive.isDesktop(context)
              ? CustomTextStyle().textStyleDesktopkCardColor
              : CustomTextStyle().textStyleTabletkCardColor,
          onChanged: (value) async {
            resultSearchController.datarows.clear();
            resultSearchController.headers.clear();
            optionSearchController.searchs.clear();
            fullReportController.selectedreport.clear();
            fullReportController.update();
            jsonController.jsonText.value = '';
            jsonController.update();
            // apiCallController.isLoading = !apiCallController.isLoading;
            // apiCallController.update();

            myController.text = value.toString();

            var reportName = myController.text;

            showDialogApiCallBefore(context);
            await Network()
                .getreportbyname(
                    reportName: reportName,
                    accessToken: loginResponseController.accesstoken.text)
                ?.then((value) async {
              if (formController.filter.isEmpty) {
                apiCallAfter(context);
                Network.showInternetError(
                    context, SideMenuConstant().apiEmptySubTitle);
              } else {
                apiCallAfter(context);
                Get.toNamed('/reportview');
              }
              // apiCallController.isLoading = !apiCallController.isLoading;
              // apiCallController.update();
            });
          },
          onSaved: (value) {},
          focusNode: FocusNode(),
          autofocus: false,
          padding: EdgeInsets.all(kDefaultPadding / 4),
          autovalidateMode: AutovalidateMode.onUserInteraction,
          decoration: InputDecoration(
            iconColor: kPrimaryColor,
            labelText: hintTitle,
            labelStyle: Responsive.isDesktop(context)
                ? CustomTextStyle().textStyleDesktopKprimaryColor
                : CustomTextStyle().textStyleTabletKprimaryColor,
            contentPadding: EdgeInsets.all(kDefaultPadding),
            floatingLabelAlignment: FloatingLabelAlignment.center,
            alignLabelWithHint: true,
            border: const OutlineInputBorder(
              borderSide: BorderSide(color: kCardColor),
            ),
            hintStyle: Responsive.isDesktop(context)
                ? CustomTextStyle().textStyleDesktopkCardColor
                : CustomTextStyle().textStyleTabletkCardColor,
            floatingLabelBehavior: FloatingLabelBehavior.always,
            errorBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: kPrimaryColor),
              //  borderRadius: BorderRadius.circular(15.0),
            ),
            focusedErrorBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: kPrimaryColor),
              //   borderRadius: BorderRadius.circular(15.0),
            ),
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: kPrimaryColor),
              //   borderRadius: BorderRadius.circular(15.0),
            ),
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: kPrimaryColor),
              // borderRadius: BorderRadius.circular(15.0),
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
          }),
    );
  }
}
