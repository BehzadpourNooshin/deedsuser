import 'package:deedsuser/controllers/errorhandeling_controller.dart';
import 'package:deedsuser/controllers/full_report_controller.dart';
import 'package:deedsuser/controllers/loginresponse_controller.dart';
import 'package:deedsuser/controllers/search_controller.dart';
import 'package:deedsuser/functions/dialog.dart';
import 'package:deedsuser/functions/loaddataforproperties.dart';
import 'package:deedsuser/utils/api_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Future<void> loadData(BuildContext context) async {
  final optionSearchController = Get.find<OptionSearchController>();
  final fullReportController = Get.find<FullReportController>();
  final loginResponseController = Get.find<LoginResponseController>();
  final errorHandelingController = Get.find<ErrorhandelingController>();
  // ignore: unused_local_variable

  if (optionSearchController.searchs.isNotEmpty &&
      fullReportController.selectedreport[0].report.scope == 'FilterForm') {
    showDialogApiCallBefore(context);
    await Network().refreshToken();
    await Network()
        .getData(
      optionSearchController: optionSearchController,
      accessToken: loginResponseController.accesstoken.text,
    )
        .then((value) async {
      if (!value) {
        apiCallAfter(context);
        errorHandelingController.errorTitleMessage.value == 'خطای نشست'
            ? {await loginResponseController.logout(409)}
            : errorHandelingController.errorTitleMessage.value == 'خطای توکن'
                ? {await loginResponseController.logout(401)}
                : Network.showInternetError(
                    context,
                    errorHandelingController.errorSubTitleMessage.value,
                  );
      } else {
        await loadDataForProperties(context);
        apiCallAfter(context);
      }
    });
  } else if (optionSearchController.fullsearchapi.isNotEmpty &&
      fullReportController.selectedreport[0].report.scope == 'BOTH') {
    showDialogApiCallBefore(context);
    await Network().refreshToken();
    await Network()
        .getDataJson(
      optionSearchController: optionSearchController,
      accessToken: loginResponseController.accesstoken.text,
    )
        .then((value) async {
      apiCallAfter(context);

      if (!value) {
        errorHandelingController.errorTitleMessage.value == 'خطای نشست'
            ? {await loginResponseController.logout(409)}
            : errorHandelingController.errorTitleMessage.value == 'خطای توکن'
                ? {await loginResponseController.logout(401)}
                : Network.showInternetError(
                    context,
                    errorHandelingController.errorSubTitleMessage.value,
                  );
      }
    });
  } else {
    errorHandelingController.errorTitleMessage.value == 'خطای نشست'
        ? {await loginResponseController.logout(409)}
        : errorHandelingController.errorTitleMessage.value == 'خطای توکن'
            ? {await loginResponseController.logout(401)}
            : Network.showInternetError(
                context,
                errorHandelingController.errorSubTitleMessage.value,
              );
  }
}
