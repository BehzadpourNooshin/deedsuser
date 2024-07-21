// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:async';
import 'dart:convert';
import 'dart:core';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:deedsuser/controllers/accounts_controller.dart';
import 'package:deedsuser/controllers/apicall_controller.dart';
import 'package:deedsuser/controllers/basereport_controller.dart';
import 'package:deedsuser/controllers/basicdashboard_controller.dart';
import 'package:deedsuser/controllers/category_controller.dart';
import 'package:deedsuser/controllers/chart_controller.dart';
import 'package:deedsuser/controllers/columns_controller.dart';
import 'package:deedsuser/controllers/cornometer_controller.dart';
import 'package:deedsuser/controllers/datafortable_controller.dart';
import 'package:deedsuser/controllers/errorhandeling_controller.dart';
import 'package:deedsuser/controllers/filter_controller.dart';
import 'package:deedsuser/controllers/full_report_controller.dart';
import 'package:deedsuser/controllers/json_controller.dart';
import 'package:deedsuser/controllers/login_controller.dart';
import 'package:deedsuser/controllers/loginresponse_controller.dart';
import 'package:deedsuser/controllers/personalsetting_controller.dart';
import 'package:deedsuser/controllers/report_controller.dart';
import 'package:deedsuser/controllers/reportsbycategory_controller.dart';
import 'package:deedsuser/controllers/resultsearch_controller.dart';
import 'package:deedsuser/controllers/search_controller.dart';
import 'package:deedsuser/controllers/serviceinputinfo_controller.dart';
import 'package:deedsuser/controllers/table_controller.dart';
import 'package:deedsuser/controllers/updatenote_controller.dart';
import 'package:deedsuser/controllers/user_controller.dart';
import 'package:deedsuser/functions/findlookupvalue.dart';
import 'package:deedsuser/functions/makeUserProperties.dart';
import 'package:deedsuser/models/basereport_model.dart';
import 'package:deedsuser/models/basicinfo_model.dart';
import 'package:deedsuser/models/category_model.dart';
import 'package:deedsuser/models/chartdata_model.dart';
import 'package:deedsuser/models/charts_model.dart';
import 'package:deedsuser/models/column_model.dart';
import 'package:deedsuser/models/filters_models.dart';
import 'package:deedsuser/models/fullreport_model.dart';
import 'package:deedsuser/models/login_model.dart';
import 'package:deedsuser/models/personalsetting_model.dart';
import 'package:deedsuser/models/report_model.dart';
import 'package:deedsuser/models/resultsearch_model.dart';
import 'package:deedsuser/models/search_model.dart';
import 'package:deedsuser/models/serviceinput_model.dart';
import 'package:deedsuser/models/serviceinputfinal_model.dart';
import 'package:deedsuser/models/tables_model.dart';
import 'package:deedsuser/models/reportsbycategory_model.dart';
import 'package:deedsuser/models/updatenotes_model.dart';
import 'package:deedsuser/utils/constant.dart';
import 'package:deedsuser/views/widgets/columnchart.dart';
import 'package:deedsuser/views/widgets/linechart.dart';
import 'package:deedsuser/views/widgets/piechartwidget.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;
import 'package:deedsuser/models/accounts_model.dart';

class Network {
  var baseUrl = 'http://10.1.54.51:8088';
  var fixUrl = '/api/v1/';
  static bool isConnect = false;
  LoginResponseController loginresponsecontroller =
      Get.put(LoginResponseController());

  ReportController reportController = Get.put(ReportController());
  JsonController jsonController = Get.put(JsonController());
  CategoryController categoryController = Get.put(CategoryController());
  UserController userController = Get.put(UserController());
  FilterController filterController = Get.put(FilterController());
  APICallController apiCallController = Get.put(APICallController());
  AccountsController accountController = Get.put(AccountsController());
  TableController dataTableController = Get.put(TableController());
  ChartController chartController = Get.put(ChartController());
  BasicDashboardInfoController basicDashboardInfoController =
      Get.put(BasicDashboardInfoController());
  UpdateNoteController updateNoteController = Get.put(UpdateNoteController());
  ColumnController columnController = ColumnController();
  FullReportController fullReportController = Get.put(FullReportController());
  ErrorhandelingController errorhandelingController =
      Get.put(ErrorhandelingController());
  ReportsByCategoryController reportsByCategoryController =
      Get.put(ReportsByCategoryController());
  DataForTableController dataForTableController =
      Get.put(DataForTableController());
  BaseReportController baseReportController = Get.put(BaseReportController());
  final ResultSearchController _resultSearchController =
      Get.put(ResultSearchController());
  final ServiceInputController serviceInputController =
      Get.put(ServiceInputController());
  final cornometerController = Get.put(CornometerController());
  static Map<String, dynamic> makeAccountBody(AccountModel account) {
    var body = account.toJson();
    //print(item.toJson());
    return body;
  }

  Future<void> makeErrorHandling(String code, String message) async {
    String persianMessage = GeneralConstant().apiCallFailureMessage;
    errorhandelingController.errorSubTitleMessage.value =
        GeneralConstant().apiCallFailureMessage;
    errorhandelingController.errorTitleMessage.value =
        GeneralConstant().snackbarErrorTitle;
    errorhandelingController.update();
    if (code == '401') {
      errorhandelingController.errorTitleMessage.value = 'خطای توکن';
      errorhandelingController.update();
      if (message
          .contains(ErrortHandeling().apiFailureTokenExpiredMessageEnglish)) {
        persianMessage = ErrortHandeling().apiFailureTokenExpiredMessage;
      } else if (message
          .contains(ErrortHandeling().apiFailureTokenInvalidMessageEnglish)) {
        persianMessage = ErrortHandeling().apiFailureTokenInvalidMessage;
      } else {
        persianMessage = ErrortHandeling().apiFailureDefault401Message;
      }
    } else if (code == '404') {
      if (message.contains(
          ErrortHandeling().apiFailureEmailPasswordNotFoundMessageEnglish)) {
        persianMessage =
            ErrortHandeling().apiFailureEmailPasswordNotFoundMessage;
      } else if (message
          .contains(ErrortHandeling().apiFailureTableNotFoundMessageEnglish)) {
        persianMessage = ErrortHandeling().apiFailureTableNotFoundMessage;
      } else if (message
          .contains(ErrortHandeling().apiFailureUserNotFoundMessageEnglish)) {
        persianMessage = ErrortHandeling().apiFailureUserNotFoundMessage;
      } else if (message.contains(
          ErrortHandeling().apiFailureLookupNotFoundGroupTitleMessageEnglish)) {
        persianMessage =
            ErrortHandeling().apiFailureLookupNotFoundGroupTitleMessage;
      } else if (message
          .contains(ErrortHandeling().apiFailureLookupNotFoundMessageEnglish)) {
        persianMessage = ErrortHandeling().apiFailureLookupNotFoundMessage;
      } else if (message.contains(
          ErrortHandeling().apiFailureReportroleEmailNotFoundMessageEnglish)) {
        persianMessage =
            ErrortHandeling().apiFailureReportroleEmailNotFoundMessage;
      } else if (message.contains(
          ErrortHandeling().apiFailureReportroleReportNotFoundMessageEnglish)) {
        persianMessage =
            ErrortHandeling().apiFailureReportroleReportNotFoundMessage;
      } else if (message.contains(
          ErrortHandeling().apiFailurePersonalSettingNotFoundMessageEnglish)) {
        persianMessage =
            ErrortHandeling().apiFailurePersonalSettingNotFoundMessage;
      } else if (message
          .contains(ErrortHandeling().apiFailureReportNotFoundMessageEnglish)) {
        persianMessage = ErrortHandeling().apiFailureReportNotFoundMessage;
      } else if (message.contains(
          ErrortHandeling().apiFailureDatabaseNotFoundMessageEnglish)) {
        persianMessage = ErrortHandeling().apiFailureDatabaseNotFoundMessage;
      } else if (message
          .contains(ErrortHandeling().apiFailureDataNotFoundMessageEnglish)) {
        persianMessage = ErrortHandeling().apiFailureDataNotFoundMessage;
      } else if (message
          .contains(ErrortHandeling().apiFailurePSDataNotFoundMessageEnglish)) {
        persianMessage = ErrortHandeling().apiFailurePSDataNotFoundMessage;
      } else if (message
          .contains(ErrortHandeling().apiFailureRecordNotFoundMessageEnglish)) {
        persianMessage = ErrortHandeling().apiFailureRecordNotFoundMessage;
      } else if (message.contains(
          ErrortHandeling().apiFailurePSDatabaseNotFoundMessageEnglish)) {
        persianMessage = ErrortHandeling().apiFailurePSDatabaseNotFoundMessage;
      } else if (message
          .contains(ErrortHandeling().apiFailureFileNotFoundMessageEnglish)) {
        persianMessage = ErrortHandeling().apiFailureFileNotFoundMessage;
      } else if (message
          .contains(ErrortHandeling().apiFailureUserNotFoundMessageEnglish)) {
        persianMessage = ErrortHandeling().apiFailureUserNotFoundMessage;
      } else {
        persianMessage = ErrortHandeling().apiFailureDefault404Message;
      }
    } else if (code == '403') {
      if (message
          .contains(ErrortHandeling().apiFailureCSVPermissionMessageEnglish)) {
        persianMessage = ErrortHandeling().apiFailureCSVPermissionMessage;
      } else if (message.contains(
          ErrortHandeling().apiFailureReportPermissionMessageEnglish)) {
        persianMessage = ErrortHandeling().apiFailureReportPermissionMessage;
      } else {
        persianMessage = ErrortHandeling().apiFailureDefault403Message;
      }
    } else if (code == '408') {
      if (message.contains(
          ErrortHandeling().apiFailureConnectToDatabaseMessageEnglish)) {
        persianMessage = ErrortHandeling().apiFailureConnectToDatabaseMessage;
      } else {
        persianMessage = ErrortHandeling().apiFailureDefaultMessage;
      }
    } else if (code == '409') {
      errorhandelingController.errorTitleMessage.value = 'خطای نشست';
      if (message.contains(
          ErrortHandeling().apiFailureDuplicateSessionMessageEnglish)) {
        persianMessage = ErrortHandeling().apiFailureDuplicateSessionMessage;
      } else if (message
          .contains(ErrortHandeling().apiFailureDuplicateUserMessageEnglish)) {
        persianMessage = ErrortHandeling().apiFailureDuplicateUserMessage;
      } else if (message.contains(
          ErrortHandeling().apiFailureDuplicateLookupMessageEnglish)) {
        persianMessage = ErrortHandeling().apiFailureDuplicateLookupMessage;
      } else if (message.contains(
          ErrortHandeling().apiFailureDuplicateReportRoleMessageEnglish)) {
        persianMessage = ErrortHandeling().apiFailureDuplicateReportRoleMessage;
      } else if (message.contains(
          ErrortHandeling().apiFailureDuplicateReportMessageEnglish)) {
        persianMessage = ErrortHandeling().apiFailureDuplicateReportMessage;
      } else {
        persianMessage = ErrortHandeling().apiFailureDefault409Message;
      }
    } else if (code == '500') {
      if (message
          .contains(ErrortHandeling().apiFailureReadFileMessageEnglish)) {
        persianMessage = ErrortHandeling().apiFailureReadFileMessage;
      } else if (message.contains(
          ErrortHandeling().apiFailureReadContentFileMessageEnglish)) {
        persianMessage = ErrortHandeling().apiFailureReadContentFileMessage;
      } else if (message.contains(
          ErrortHandeling().apiFailureCreateContentFileMessageEnglish)) {
        persianMessage = ErrortHandeling().apiFailureCreateContentFileMessage;
      } else if (message.contains(ErrortHandeling()
          .apiFailureCurrentPasswordIsIncorrectMessageEnglish)) {
        persianMessage =
            ErrortHandeling().apiFailureCurrentPasswordIsIncorrectMessage;
      } else if (message
          .contains(ErrortHandeling().apiFailureFormatAPIMessageEnglish)) {
        persianMessage = ErrortHandeling().apiFailureFormatAPIMessage;
      } else if (message
          .contains(ErrortHandeling().apiFailureCreateJsonFileMessageEnglish)) {
        persianMessage = ErrortHandeling().apiFailureCreateJsonFileMessage;
      } else if (message
          .contains(ErrortHandeling().apiFailureRequiredParamMessageEnglish)) {
        persianMessage = ErrortHandeling().apiFailureRequiredParamMessage;
      } else {
        persianMessage = ErrortHandeling().apiFailureDefaultMessage;
      }
    } else {
      persianMessage = ErrortHandeling().apiFailureTimeOut;
    }

    errorhandelingController.errorSubTitleMessage.value = persianMessage;

    errorhandelingController.update();
  }

  Future<void> makeErrorHandlingWithHttpStatus(int code) async {
    String persianMessage = GeneralConstant().apiCallFailureMessage;
    errorhandelingController.errorSubTitleMessage.value =
        GeneralConstant().apiCallFailureMessage;
    errorhandelingController.errorTitleMessage.value =
        GeneralConstant().snackbarErrorTitle;
    errorhandelingController.update();
    if (code == 404) {
      persianMessage = ErrortHandeling().apiFailureDefault404Message;
    } else if (code == 500) {
      persianMessage = ErrortHandeling().apiFailureDefaultMessage;
    } else if (code == 403) {
      persianMessage = ErrortHandeling().apiFailureDefault403Message;
    } else if (code == 401) {
      persianMessage = ErrortHandeling().apiFailureDefault401Message;
      errorhandelingController.errorTitleMessage.value = 'خطای توکن';
      errorhandelingController.update();
    } else if (code == 409) {
      persianMessage = ErrortHandeling().apiFailureDefault409Message;
    } else if (code == 504) {
      persianMessage = ErrortHandeling().apiFailureTimeOut;
    }

    errorhandelingController.errorSubTitleMessage.value = persianMessage;
    errorhandelingController.update();
  }

  static Map<String, dynamic> makeLoginBody(LoginModel login) {
    var body = login.toJson();

    return body;
  }

  static Map<String, dynamic> makeSetInputService(
      ServiceInputFinalModel serviceInputFinalModel) {
    var body = serviceInputFinalModel.toJson();

    return body;
  }

  static Map<String, dynamic> makeSearchBody(SearchModel searchModel) {
    var body = searchModel.toJson();
    if (kDebugMode) {
      print(body);
    }
    return body;
  }

  static Map<String, dynamic> makeUpdateUserBody(AccountModel accountModel) {
    var body = accountModel.toJson();

    return body;
  }

  static Map<String, dynamic> makePersonalSettingsBody(
      PersonalSettingModel personalSettingModel) {
    var body = {
      "userEmail": personalSettingModel.userEmail,
      "reportName": personalSettingModel.reportTitle
    };

    return body;
  }

  static Map<String, dynamic> makeGetReportByName(String reportName) {
    return {'reportName': reportName};
  }

  static Uri urlWithProperties(String nameMethod) {
    Uri myUri = Uri.parse('${Network().baseUrl}${Network().fixUrl}$nameMethod');

    return myUri;
  }

  static Uri urlWithPropertiesQueryParam(
      String nameMethod, String paramName, String paramValue) {
    Uri myUri = Uri.parse(
        '${Network().baseUrl}${Network().fixUrl}$nameMethod?$paramName=$paramValue');

    return myUri;
  }

  static Future<bool> checkInternet(BuildContext context) async {
    Connectivity().onConnectivityChanged.listen((status) {
      if ((status == ConnectivityResult.wifi ||
          status == ConnectivityResult.mobile)) {
        isConnect = true;
      } else {
        showInternetError(context, 'شما به اینترنت متصل نیستید');
        isConnect = false;
      }
    });

    return isConnect;
  }

  static void showInternetError(BuildContext context, String msg) {
    CoolAlert.show(
        context: context,
        type: CoolAlertType.error,
        width: 100,
        text: msg,
        title: "خطا",
        confirmBtnText: 'OK',
        confirmBtnColor: kErrorColor,
        confirmBtnTextStyle:
            const TextStyle(fontSize: 16, color: Colors.white));
  }

  static void showSuccessCall(BuildContext context, String msg) {
    CoolAlert.show(
        context: context,
        type: CoolAlertType.success,
        width: 100,
        text: msg,
        title: "موفق",
        confirmBtnText: 'OK',
        confirmBtnColor: kSuccessColor,
        onConfirmBtnTap: () => onOkButtonPressed(context),
        confirmBtnTextStyle:
            const TextStyle(fontSize: 16, color: Colors.white));
  }

  static void onOkButtonPressed(BuildContext context) {
    Navigator.of(context).pop(true);
  }
  //Report Methods:
  //DashBoardPage-ChartReports

//SideMenu:
  Future<bool> reportbasetcategory({
    required String accessToken,
  }) async {
    bool result = false;
    // userController.accesstoken.text =
    //     'eyJhbGciOiJIUzI1NiJ9.eyJyb2xlIjoiQURNSU4iLCJzdWIiOiJiZWh6YWRwb3Vybm9vc2hpbkBnbWFpbC5jb20iLCJpYXQiOjE3MTI4MjIzOTUsImV4cCI6MTcxMjkwODc5NX0.31Iqg0MIAaBDxl3RJQDAR5pe522wzxLFvhivkpwBXiI';
    loginresponsecontroller.loadAccessToken();
    try {
      await http
          .get(
            urlWithProperties('reporting/getAllReportsByAllCategories'),
            headers: {
              'Authorization': 'Bearer $accessToken',
              'Content-Type': 'application/json',
            },
          )
          .timeout(const Duration(seconds: 7))
          .then((response) {
            if (response.statusCode == 200) {
              var jsonMap1 = utf8.decode(response.bodyBytes);
              var jsonMap = jsonDecode(jsonMap1);
              var data = jsonMap["data"];
              var code = jsonMap["code"];
              var reporttitle = [];
              var reportids = [];
              var categoryid = 0;
              var categoryTitle = '';
              var hasExcelExport = false;
              var hasPDFExport = false;
              var hasChart = false;
              var objects = [];

              if (code == '200') {
                if (data.isNotEmpty) {
                  categoryController.categories.clear();
                  categoryController.update();

                  for (var item in data) {
                    var reports = item['reportList'];
                    categoryid = item['category']['id'];
                    categoryTitle = item['category']['categoryTitle'];
                    reporttitle = [];
                    reportids = [];
                    objects = [];
                    for (var report in reports) {
                      reporttitle.add(report['reportDescription']);
                      reportids.add(report['id']);
                      // ignore: prefer_interpolation_to_compose_strings
                      objects.add(
                          '${report['reportDescription']}-${report['id']}');
                      hasExcelExport = report['hasExcelExport'];
                      hasPDFExport = report['hasPDFExport'];
                      hasChart = report['hasChart'];
                    }

                    categoryController.categories.add(CategoryModel(
                        categoryTitle: categoryTitle,
                        categoryId: categoryid,
                        reporttitles: reporttitle,
                        reportid: reportids,
                        reportObject: objects,
                        hasExcelExport: hasExcelExport,
                        hasPDFExport: hasPDFExport,
                        hasChart: hasChart));
                  }
                }
                categoryController.update();
                result = true;
                if (kDebugMode) {
                  print(result);
                }
              } else {
                var data = jsonMap["data"];
                if (data.isNotEmpty) {
                  makeErrorHandling(code, data);
                }
              }
            } else {
              var jsonMap1 = utf8.decode(response.bodyBytes);
              var jsonMap = jsonDecode(jsonMap1);
              var data = jsonMap["data"];
              var code = jsonMap["code"];

              if (data.isNotEmpty) {
                makeErrorHandling(code, data);
              } else {
                makeErrorHandlingWithHttpStatus(response.statusCode);
              }
            }
          });
    } on TimeoutException catch (_) {
      // Handle timeout exception specifically
      if (kDebugMode) {
        print("Request timed out");
      }
      // You can handle timeout specific logic here
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }

    return Future<bool>.value(result);
    //}
  }

  Future<bool>? allreportbasetcategory({required String accessToken}) async {
    bool result = false;

    try {
      await http
          .get(
            urlWithProperties('reporting/getAllReportsByCategory'),
            headers: {
              'Authorization': 'Bearer $accessToken',
              'Content-Type': 'application/json',
            },
          )
          .timeout(const Duration(seconds: 5))
          .then((response) {
            if (response.statusCode == 200) {
              var jsonMap1 = utf8.decode(response.bodyBytes);
              var jsonMap = jsonDecode(jsonMap1);
              if (kDebugMode) {
                print(jsonMap);
              }

              var data = jsonMap["data"];
              var code = jsonMap["code"];
              List<ReportNameModel> reporttitles = [];

              String categoryName = '';
              String categoryDisplayTitle = '';

              if (code == '200') {
                result = true;
                if (data.isNotEmpty) {
                  reportsByCategoryController.reportsbycategory.clear();
                  reportsByCategoryController.update();

                  for (var item in data) {
                    var reports = item['reportDto'];
                    categoryName = item['categoryName'];
                    categoryDisplayTitle = item['categoryDisplayTitle'];
                    reporttitles = [];
                    for (var report in reports) {
                      reporttitles.add(ReportNameModel(
                          displayTitle: report['displayTitle'],
                          reportName: report['reportName'],
                          active: report['active']));
                    }
                    if (kDebugMode) {
                      print(reporttitles.length);
                    }
                    reportsByCategoryController.reportsbycategory
                        .add(ReportsByCategoryModel(
                      categoryName: categoryName,
                      categoryDisplayTitle: categoryDisplayTitle,
                      reports: reporttitles,
                    ));
                    reportsByCategoryController.update();
                  }
                  reportsByCategoryController.update();
                  result = true;

                  if (kDebugMode) {
                    print(result);
                  }
                }
              } else {
                var data = jsonMap["data"];
                if (data.isNotEmpty) {
                  makeErrorHandling(code, data);
                }
              }
            } else {
              var jsonMap1 = utf8.decode(response.bodyBytes);
              var jsonMap = jsonDecode(jsonMap1);
              var data = jsonMap["data"];
              var code = jsonMap["code"];

              if (data.isNotEmpty) {
                makeErrorHandling(code, data);
              } else {
                makeErrorHandlingWithHttpStatus(response.statusCode);
              }
            }
          });
    } on TimeoutException catch (_) {
      // Handle timeout exception specifically
      if (kDebugMode) {
        print("Request timed out");
      }
      // You can handle timeout specific logic here
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }

    return Future<bool>.value(result);
    //}
  }

  Future<bool>? getUpdateNotesUser({
    required String accessToken,
  }) async {
    bool result = false;
    int index = 0;
    try {
      await http
          .get(
            urlWithProperties('updateNotes/getUpdateNotesUser'),
            headers: {
              'Authorization':
                  accessToken.isEmpty ? 'Bearer  ' : 'Bearer $accessToken',
              'Content-Type': 'application/json',
            },
          )
          .timeout(const Duration(seconds: 5))
          .then((response) {
            if (kDebugMode) {
              print(response.statusCode);
            }
            if (response.statusCode == 200) {
              var jsonMap1 = utf8.decode(response.bodyBytes);
              var jsonMap = jsonDecode(jsonMap1);
              if (kDebugMode) {
                print(jsonMap);
              }
              var code = jsonMap["code"];
              var data = jsonMap["data"];

              if (code == '200') {
                if (data.isNotEmpty) {
                  for (var item in data) {
                    item['active'] == true ? {index++} : {};
                  }
                  updateNoteController.updateUserNote.value = index;
                  updateNoteController.update();
                  result = true;
                }
              } else {
                var data = jsonMap["data"];
                if (data.isNotEmpty) {
                  makeErrorHandling(code, data);
                }
              }
            } else {
              var jsonMap1 = utf8.decode(response.bodyBytes);
              var jsonMap = jsonDecode(jsonMap1);
              var data = jsonMap["data"];
              var code = jsonMap["code"];

              if (data.isNotEmpty) {
                makeErrorHandling(code, data);
              } else {
                makeErrorHandlingWithHttpStatus(response.statusCode);
              }
            }
          });
    } on TimeoutException catch (_) {
      // Handle timeout exception specifically
      if (kDebugMode) {
        print("Request timed out");
      }
      // You can handle timeout specific logic here
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }

    return Future<bool>.value(result);
  }

  Future<bool>? getUpdateNotes({
    required String accessToken,
  }) async {
    bool result = false;

    try {
      await http
          .get(
            urlWithProperties('updateNotes/getAllUpdateNotes'),
            headers: {
              'Authorization':
                  accessToken.isEmpty ? 'Bearer  ' : 'Bearer $accessToken',
              'Content-Type': 'application/json',
            },
          )
          .timeout(const Duration(seconds: 5))
          .then((response) {
            if (kDebugMode) {
              print(response.statusCode);
            }
            if (response.statusCode == 200) {
              var jsonMap1 = utf8.decode(response.bodyBytes);
              var jsonMap = jsonDecode(jsonMap1);
              if (kDebugMode) {
                print(jsonMap);
              }
              var code = jsonMap["code"];
              var data = jsonMap["data"];

              if (code == '200') {
                if (data.isNotEmpty) {
                  updateNoteController.updateNotes.clear();
                  updateNoteController.update();
                  for (var item in data) {
                    item['active'] == true
                        ? {
                            updateNoteController.updateNotes.add(
                                UpdatenotesModel(
                                    version: item['version'],
                                    description: item['description'])),
                            updateNoteController.update()
                          }
                        : {
                            updateNoteController.updateNotes.add(
                                UpdatenotesModel(
                                    version: item['version'],
                                    description: item['description'])),
                            updateNoteController.update()
                          };
                  }
                  updateNoteController.update();
                  result = true;
                }
              } else {
                var data = jsonMap["data"];
                if (data.isNotEmpty) {
                  makeErrorHandling(code, data);
                }
              }
            } else {
              var jsonMap1 = utf8.decode(response.bodyBytes);
              var jsonMap = jsonDecode(jsonMap1);
              var data = jsonMap["data"];
              var code = jsonMap["code"];

              if (data.isNotEmpty) {
                makeErrorHandling(code, data);
              } else {
                makeErrorHandlingWithHttpStatus(response.statusCode);
              }
            }
          });
    } on TimeoutException catch (_) {
      // Handle timeout exception specifically
      if (kDebugMode) {
        print("Request timed out");
      }
      // You can handle timeout specific logic here
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }

    return Future<bool>.value(result);
  }

  Future<bool>? getBasiInfo({
    required String accessToken,
  }) async {
    bool result = false;
    int numberOfUsers = 0;
    int numberOfReports = 0;
    int numberOfCategories = 0;
    int numberOfOnlineUsers = 0;
    int numberOfUpdateNotes = 0;
    try {
      await http
          .get(
            urlWithProperties('reporting/getBasicInfo'),
            headers: {
              'Authorization':
                  accessToken.isEmpty ? 'Bearer  ' : 'Bearer $accessToken',
              'Content-Type': 'application/json',
            },
          )
          .timeout(const Duration(seconds: 5))
          .then((response) {
            if (kDebugMode) {
              print(response.statusCode);
            }
            if (response.statusCode == 200) {
              var jsonMap1 = utf8.decode(response.bodyBytes);
              var jsonMap = jsonDecode(jsonMap1);
              if (kDebugMode) {
                print(jsonMap);
              }
              var code = jsonMap["code"];
              var data = jsonMap["data"];

              if (code == '200') {
                if (data.isNotEmpty) {
                  basicDashboardInfoController.basicDashboardInfo.clear();
                  basicDashboardInfoController.update();
                  numberOfUsers = data['numberOfUsers'];
                  numberOfReports = data['numberOfReports'];
                  numberOfCategories = data['numberOfCategories'];
                  numberOfOnlineUsers = data['numberOfOnlineUsers'];
                  numberOfUpdateNotes = data['numberOfUpdateNotes'];
                  basicDashboardInfoController.basicDashboardInfo.add(
                      BasicDashboardInfoModel(
                          numberOfUsers: numberOfUsers,
                          numberOfReports: numberOfReports,
                          numberOfCategories: numberOfCategories,
                          numberOfOnlineUsers: numberOfOnlineUsers,
                          numberOfUpdateNotes: numberOfUpdateNotes));

                  basicDashboardInfoController.update();
                  result = true;
                }
              } else {
                var data = jsonMap["data"];
                if (data.isNotEmpty) {
                  makeErrorHandling(code, data);
                }
              }
            } else {
              var jsonMap1 = utf8.decode(response.bodyBytes);
              var jsonMap = jsonDecode(jsonMap1);
              var data = jsonMap["data"];
              var code = jsonMap["code"];

              if (data.isNotEmpty) {
                makeErrorHandling(code, data);
              } else {
                makeErrorHandlingWithHttpStatus(response.statusCode);
              }
            }
          });
    } on TimeoutException catch (_) {
      // Handle timeout exception specifically
      if (kDebugMode) {
        print("Request timed out");
      }
      // You can handle timeout specific logic here
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }

    return Future<bool>.value(result);
  }

  Future<bool>? logout({
    required String email,
  }) async {
    bool result = true;
    try {
      await http
          .post(urlWithProperties('auth/handleLogout'),
              headers: {
                'Content-Type': 'application/json',
              },
              body: jsonEncode({'email': email}))
          .timeout(const Duration(seconds: 5))
          .then((response) {
        if (kDebugMode) {
          print(response.statusCode);
        }
        if (response.statusCode == 200) {
          result = true;
        }
      });
    } on TimeoutException catch (_) {
      // Handle timeout exception specifically
      if (kDebugMode) {
        print("Request timed out");
      }
      // You can handle timeout specific logic here
      makeErrorHandlingWithHttpStatus(504);
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }

    return Future<bool>.value(result);
  }

  Future<bool>? setpersonalsettings({
    required PersonalSettingController personalSettingController,
  }) async {
    bool result = false;
    userController.accesstoken.text;

    try {
      await http
          .post(
              urlWithProperties('personalSetting/changePersonalSettingStatus'),
              headers: {
                'Authorization': 'Bearer ${userController.accesstoken.text}',
                'Content-Type': 'application/json',
              },
              body: jsonEncode(makePersonalSettingsBody(
                  personalSettingController.setaccountreports[0])))
          .timeout(const Duration(seconds: 10))
          .then((response) {
        if (response.statusCode == 200) {
          var jsonMap1 = utf8.decode(response.bodyBytes);
          var jsonMap = jsonDecode(jsonMap1);
          if (kDebugMode) {
            print(jsonMap);
          }
          var code = jsonMap["code"];

          if (code == '200') {
            result = true;
            if (kDebugMode) {
              print(result);
            }
          } else {
            var data = jsonMap["data"];
            if (data.isNotEmpty) {
              makeErrorHandling(code, data);
            }
          }
        } else {
          var jsonMap1 = utf8.decode(response.bodyBytes);
          var jsonMap = jsonDecode(jsonMap1);
          var data = jsonMap["data"];
          var code = jsonMap["code"];

          if (data.isNotEmpty) {
            makeErrorHandling(code, data);
          } else {
            makeErrorHandlingWithHttpStatus(response.statusCode);
          }
        }
      });
    } on TimeoutException catch (_) {
      // Handle timeout exception specifically
      if (kDebugMode) {
        print("Request timed out");
      }
      // You can handle timeout specific logic here
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }

    return Future<bool>.value(result);
    //}
  }

  Future<bool>? updatepersonalsettings({
    required PersonalSettingController personalSettingController,
  }) async {
    bool result = false;
    userController.accesstoken.text;

    try {
      await http
          .post(urlWithProperties('personalSetting/updatePersonalSetting'),
              headers: {
                'Authorization': 'Bearer ${userController.accesstoken.text}',
                'Content-Type': 'application/json',
              },
              body: jsonEncode(makePersonalSettingsBody(
                  personalSettingController.personalSettings[0])))
          .timeout(const Duration(seconds: 10))
          .then((response) {
        if (response.statusCode == 200) {
          var jsonMap1 = utf8.decode(response.bodyBytes);
          var jsonMap = jsonDecode(jsonMap1);
          if (kDebugMode) {
            print(jsonMap);
          }
          var code = jsonMap["code"];

          if (code == '200') {
            result = true;
            if (kDebugMode) {
              print(result);
            }
          } else {
            var data = jsonMap["data"];
            if (data.isNotEmpty) {
              makeErrorHandling(code, data);
            }
          }
        } else {
          var jsonMap1 = utf8.decode(response.bodyBytes);
          var jsonMap = jsonDecode(jsonMap1);
          var data = jsonMap["data"];
          var code = jsonMap["code"];

          if (data.isNotEmpty) {
            makeErrorHandling(code, data);
          } else {
            makeErrorHandlingWithHttpStatus(response.statusCode);
          }
        }
      });
    } on TimeoutException catch (_) {
      // Handle timeout exception specifically
      if (kDebugMode) {
        print("Request timed out");
      }
      // You can handle timeout specific logic here
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }

    return Future<bool>.value(result);
    //}
  }

  Future<bool>? getpersonalsetting({
    required String email,
    required String accessToken,
  }) async {
    bool result = false;

    PersonalSettingController personalSettingController =
        Get.put(PersonalSettingController());
    try {
      await http
          .get(
            urlWithPropertiesQueryParam(
                'personalSetting/getPersonalSetting', 'userEmail', email),
            headers: {
              'Authorization': 'Bearer $accessToken',
              'Content-Type': 'application/json',
            },
          )
          .timeout(const Duration(seconds: 10))
          .then((response) {
            if (response.statusCode == 200) {
              var jsonMap1 = utf8.decode(response.bodyBytes);
              var jsonMap = jsonDecode(jsonMap1);
              if (kDebugMode) {
                print(jsonMap);
              }
              var code = jsonMap["code"];
              var data = jsonMap["data"];

              if (code == '200') {
                result = true;
                if (data.isNotEmpty) {
                  personalSettingController.personalSettings.clear();

                  for (var reportDto in data) {
                    personalSettingController.personalSettings.add(
                        PersonalSettingModel(
                            userEmail: email,
                            reportTitle: reportDto['reportTitle'],
                            viewChart: reportDto['viewChart'],
                            viewInHomePage: reportDto['viewInHomePage'],
                            active: reportDto['active']));
                    personalSettingController.update();
                  }

                  personalSettingController.update();
                  reportsByCategoryController.makeGenerateAllReports();
                  reportsByCategoryController.update();
                  personalSettingController.makeDashboardWidgtes(
                      reportsByCategoryController, personalSettingController);
                  personalSettingController.update();
                  personalSettingController.mergeTwoList(
                      reportsByCategoryController, personalSettingController);
                  personalSettingController.update();
                  if (kDebugMode) {
                    print(result);
                  }
                }
              } else {
                var data = jsonMap["data"];
                if (data.isNotEmpty) {
                  makeErrorHandling(code, data);
                }
              }
            } else {
              var jsonMap1 = utf8.decode(response.bodyBytes);
              var jsonMap = jsonDecode(jsonMap1);
              var data = jsonMap["data"];
              var code = jsonMap["code"];

              if (data.isNotEmpty) {
                makeErrorHandling(code, data);
              } else {
                makeErrorHandlingWithHttpStatus(response.statusCode);
              }
            }
          });
    } on TimeoutException catch (_) {
      // Handle timeout exception specifically
      if (kDebugMode) {
        print("Request timed out");
      }
      // You can handle timeout specific logic here
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }

    return Future<bool>.value(result);
    //}
  }

  Future<bool>? deletepersoanlsetting({
    required PersonalSettingController personalSettingController,
  }) async {
    bool result = false;
    userController.accesstoken.text;

    try {
      await http
          .post(
              urlWithProperties('personalSetting/changePersonalSettingStatus'),
              headers: {
                'Authorization': 'Bearer ${userController.accesstoken.text}',
                'Content-Type': 'application/json',
              },
              body: jsonEncode(makePersonalSettingsBody(
                  personalSettingController.setaccountreports[0])))
          .timeout(const Duration(seconds: 10))
          .then((response) {
        if (response.statusCode == 200) {
          var jsonMap1 = utf8.decode(response.bodyBytes);
          var jsonMap = jsonDecode(jsonMap1);
          if (kDebugMode) {
            print(jsonMap);
          }
          var code = jsonMap["code"];

          if (code == '200') {
            result = true;
            if (kDebugMode) {
              print(result);
            }
          } else {
            var data = jsonMap["data"];
            if (data.isNotEmpty) {
              makeErrorHandling(code, data);
            }
          }
        } else {
          var jsonMap1 = utf8.decode(response.bodyBytes);
          var jsonMap = jsonDecode(jsonMap1);
          var data = jsonMap["data"];
          var code = jsonMap["code"];

          if (data.isNotEmpty) {
            makeErrorHandling(code, data);
          } else {
            makeErrorHandlingWithHttpStatus(response.statusCode);
          }
        }
      });
    } on TimeoutException catch (_) {
      // Handle timeout exception specifically
      if (kDebugMode) {
        print("Request timed out");
      }
      // You can handle timeout specific logic here
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }

    return Future<bool>.value(result);
    //}
  }

  Future<bool>? getreportbyname(
      {required String reportName, required String accessToken}) async {
    bool result = false;

    {
      var scope;
      var reportDescription;
      var reportQueryFileName;
      var hasExcelExport;
      var hasPDFExport;
      var hasChart;
      var hasRefreshQuery;
      var hasViewInHomePage;
      var hasSwagger;
      var dbTableName;
      var tablefieldlist;
      var columnTitle;
      var columnDBFieldName;
      var hasSortLink;
      var hasUserChartView;
      var hasUserPdfExport;
      var hasUserExcelExport;
      var activechart;
      var chartList;
      var charttype;
      var chartfield = [];
      var formItemTitle;
      var formItemDisplayTitle;
      var formItemType;
      var formItemInputType;
      var formItemValidationType;
      var formItemInputTypeHint;
      var inputServiceInfo = [];
      var filterForm;
      var lookupName;
      var parameterName;
      var parameterType;
      var parameterInputType;

      var reportCategory;
      var dataTableDto;
      var displayTitle;
      filterController.filter.clear();
      filterController.update();
      chartController.charts.clear();
      chartController.update();
      dataTableController.table.clear();
      dataTableController.update();
      try {
        await http
            .post(
              urlWithProperties('reporting/getReportByName'),
              body: jsonEncode({'reportName': reportName}),
              headers: {
                'Authorization': 'Bearer $accessToken',
                'Content-Type': 'application/json',
              },
            )
            .timeout(const Duration(seconds: 10))
            .then((response) async {
              if (response.statusCode == 200) {
                var jsonMap1 = utf8.decode(response.bodyBytes);
                var jsonMap = jsonDecode(jsonMap1);
                if (kDebugMode) {
                  print(jsonMap);
                }

                Map<String, dynamic> data = jsonMap["data"];
                var code = jsonMap["code"];
                if (kDebugMode) {
                  print(data);
                }

                if (code == '200') {
                  if (data.isNotEmpty) {
                    data.containsKey('reportDescription')
                        ? reportDescription = data['reportDescription']
                        : reportDescription = '';
                    data.containsKey('reportQueryFileName')
                        ? reportQueryFileName = data['reportQueryFileName']
                        : reportQueryFileName = '';
                    data.containsKey('hasExcelExport')
                        ? hasExcelExport = data['hasExcelExport']
                        : hasExcelExport = false;
                    data.containsKey('hasUserChartView')
                        ? hasUserChartView = data['hasUserChartView']
                        : hasUserChartView = false;
                    data.containsKey('hasUserPdfExport')
                        ? hasUserPdfExport = data['hasUserPdfExport']
                        : hasUserPdfExport = false;
                    data.containsKey('hasUserExcelExport')
                        ? hasUserExcelExport = data['hasUserExcelExport']
                        : hasUserExcelExport = false;

                    data.containsKey('scope')
                        ? scope = data['scope']
                        : scope = 'FilterForm';
                    data.containsKey('hasPDFExport')
                        ? hasPDFExport = data['hasPDFExport']
                        : hasPDFExport = false;
                    data.containsKey('hasChart')
                        ? hasChart = data['hasChart']
                        : hasChart = false;
                    data.containsKey('hasRefreshQuery')
                        ? hasRefreshQuery = data['hasRefreshQuery']
                        : hasRefreshQuery = false;
                    data.containsKey('hasViewInHomePage')
                        ? hasViewInHomePage = data['hasViewInHomePage']
                        : hasViewInHomePage = false;
                    data.containsKey('reportCategory')
                        ? reportCategory = data['reportCategory']
                        : reportCategory = '';
                    data.containsKey('displayTitle')
                        ? displayTitle = data['displayTitle']
                        : displayTitle = '';
                    data.containsKey('hasSwagger')
                        ? hasSwagger = data['hasSwagger']
                        : hasSwagger = false;

                    data.containsKey('charts')
                        ? {
                            chartList = data['charts'],
                            for (var chart in chartList)
                              {
                                chartfield = chart['chartFields'],
                                charttype = chart['chartType'],
                                activechart = true,
                                chartController.charts.add(ChartModel(
                                    chartType: charttype,
                                    chartFields: chartfield,
                                    active: activechart)),
                                chartController.update(),
                              }
                          }
                        : chartList = [];
                    if (kDebugMode) {
                      print(chartController.charts.length);
                    }
                    data.containsKey('inputFormInfo')
                        ? {
                            inputServiceInfo = data['inputFormInfo'],
                            serviceInputController.serviceinput.clear(),
                            serviceInputController.update(),
                            for (var serviceinput in inputServiceInfo)
                              {
                                parameterName = serviceinput['parameterName'],
                                parameterType = serviceinput['parameterType'],
                                parameterInputType =
                                    serviceinput['parameterInputType'],
                                serviceInputController.serviceinput.add(
                                    ServiceInputModel(
                                        parameterName: parameterName,
                                        parameterType: parameterType,
                                        parameterInputType:
                                            parameterInputType)),
                                serviceInputController.update()
                              },
                            serviceInputController.update(),
                            serviceInputController.serviceinputfinal.clear(),
                            serviceInputController.update(),
                            serviceInputController.serviceinputfinal.add(
                                ServiceInputFinalModel(
                                    reportName: reportName,
                                    inputFormInfoFieldsDtoList:
                                        serviceInputController.serviceinput)),
                            serviceInputController.update(),
                          }
                        : inputServiceInfo = [];
                    data.containsKey('filterForm')
                        ? {
                            filterForm = data['filterForm'],
                            for (var filter in filterForm)
                              {
                                formItemTitle = filter['formItemTitle'],
                                formItemDisplayTitle =
                                    filter['formItemDisplayTitle'],
                                formItemType = filter['formItemType'],
                                formItemInputType = filter['formItemInputType'],
                                formItemValidationType =
                                    filter['formItemValidationType'],
                                formItemInputTypeHint =
                                    filter['formItemInputTypeHint'],
                                lookupName = filter['lookupName'],
                                if (formItemInputType == 'Range')
                                  {
                                    filterController.filter.add(FilterModel(
                                        formItemDisplayTitle:
                                            formItemDisplayTitle + ' از',
                                        formItemTitle: formItemTitle,
                                        formItemType: formItemType,
                                        formItemInputType: formItemInputType,
                                        formItemValidationType:
                                            formItemValidationType,
                                        formItemInputTypeHint:
                                            formItemInputTypeHint,
                                        lookupName: lookupName,
                                        textEditingController:
                                            TextEditingController())),
                                    filterController.filter.add(FilterModel(
                                        formItemDisplayTitle:
                                            formItemDisplayTitle + ' تا',
                                        formItemType: formItemType,
                                        formItemInputType: formItemInputType,
                                        formItemValidationType:
                                            formItemValidationType,
                                        formItemInputTypeHint:
                                            formItemInputTypeHint,
                                        lookupName: lookupName,
                                        textEditingController:
                                            TextEditingController(),
                                        formItemTitle: formItemTitle)),
                                  }
                                else
                                  {
                                    filterController.filter.add(FilterModel(
                                        formItemTitle: formItemTitle,
                                        formItemDisplayTitle:
                                            formItemDisplayTitle,
                                        formItemType: formItemType,
                                        formItemInputType: formItemInputType,
                                        formItemValidationType:
                                            formItemValidationType,
                                        formItemInputTypeHint:
                                            formItemInputTypeHint,
                                        lookupName: lookupName,
                                        textEditingController:
                                            TextEditingController())),
                                  }
                              },
                            filterController.update(),
                            for (int i = 0;
                                i < filterController.filter.length;
                                i++)
                              {
                                if (filterController.filter[i].lookupName !=
                                    'none')
                                  {
                                    await grouplookupname(
                                        groupName: filterController
                                            .filter[i].lookupName,
                                        index: i,
                                        accessToken: accessToken),
                                  }
                              }
                          }
                        : filterForm = [];
                    if (kDebugMode) {
                      print(filterController.filter.length);
                    }
                    data.containsKey('table')
                        ? {
                            dataTableDto = data['table'],
                            for (var table in dataTableDto)
                              {
                                dbTableName = table['dbTableName'],
                                tablefieldlist = table['columns'],
                                columnController.columns.clear(),
                                columnController.update(),
                                for (var column in tablefieldlist)
                                  {
                                    columnTitle = column['columnTitle'],
                                    columnDBFieldName =
                                        column['columnDBFieldName'],
                                    hasSortLink = column['hasSortLink'],
                                    columnController.columns.add(ColumnModel(
                                        columnTitle: columnTitle,
                                        columnDBFieldName: columnDBFieldName,
                                        hasSortLink: hasSortLink,
                                        active: true)),
                                    columnController.update(),
                                  }
                              },
                            dataTableController.table.add(TableModel(
                                dbTableName: dbTableName,
                                fields: columnController.columns,
                                active: true)),
                            dataTableController.update(),
                          }
                        : dataTableDto = [];
                    if (kDebugMode) {
                      print(dataTableController.table.length);
                    }
                    chartController.update();
                    dataTableController.update();
                    baseReportController.basereports.clear();
                    baseReportController.update();
                    baseReportController.basereports.add(BaseReportModel(
                        reportDescription: reportDescription,
                        reportName: reportName,
                        reportCategory: reportCategory,
                        reportQueryFileName: reportQueryFileName,
                        hasExcelExport: hasExcelExport.toString(),
                        hasPDFExport: hasPDFExport.toString(),
                        hasChart: hasChart.toString(),
                        hasRefreshQuery: hasRefreshQuery.toString(),
                        hasViewInHomePage: hasViewInHomePage.toString(),
                        hasSwagger: hasSwagger.toString(),
                        displayTitle: displayTitle,
                        scope: scope,
                        hasUserPdfExport: hasUserPdfExport,
                        hasUserExcelExport: hasUserExcelExport,
                        hasUserChartView: hasUserChartView));
                    chartController.charts.isNotEmpty
                        ? {
                            fullReportController.fullreports.add(
                                FullReportModel(
                                    report: baseReportController.basereports[0],
                                    table: dataTableController.table,
                                    filters: filterController.filter,
                                    chart: chartController.charts)),
                            fullReportController.selectedreport.clear(),
                            fullReportController.update(),
                            fullReportController.selectedreport.add(
                                FullReportModel(
                                    report: baseReportController.basereports[0],
                                    table: dataTableController.table,
                                    filters: filterController.filter,
                                    chart: chartController.charts)),
                            fullReportController.update(),
                          }
                        : {
                            fullReportController.fullreports
                                .add(FullReportModel(
                              report: baseReportController.basereports[0],
                              table: dataTableController.table,
                              filters: filterController.filter,
                            )),
                            fullReportController.selectedreport.clear(),
                            fullReportController.update(),
                            fullReportController.selectedreport
                                .add(FullReportModel(
                              report: baseReportController.basereports[0],
                              table: dataTableController.table,
                              filters: filterController.filter,
                            )),
                            fullReportController.update(),
                          };
                    fullReportController.update();
                    result = true;
                    if (kDebugMode) {
                      print(result);
                    }
                  }
                } else {
                  var data = jsonMap["data"];
                  if (data.isNotEmpty) {
                    makeErrorHandling(code, data);
                  }
                }
              } else {
                var jsonMap1 = utf8.decode(response.bodyBytes);
                var jsonMap = jsonDecode(jsonMap1);
                var data = jsonMap["data"];
                var code = jsonMap["code"];

                if (data.isNotEmpty) {
                  makeErrorHandling(code, data);
                } else {
                  makeErrorHandlingWithHttpStatus(response.statusCode);
                }
              }
            });
      } on TimeoutException catch (_) {
        // Handle timeout exception specifically
        if (kDebugMode) {
          print("Request timed out");
        }
        // You can handle timeout specific logic here
      } catch (e) {
        if (kDebugMode) {
          print(e);
        }
      }

      return Future<bool>.value(result);
    }
  }

  Future<bool> getData({
    required String accessToken,
    required OptionSearchController optionSearchController,
  }) async {
    bool result = false;
    List header = [];
    List dataRows = [];
    List<int> priority = [];
    int totalPages = 0;
    int number = 0;
    int totalElements = 0;
    bool last = false;

    FullReportController fullReportController = Get.put(FullReportController());
    var table = fullReportController.selectedreport[0].table[0];
    if (kDebugMode) {
      print(table.fields);
    }

    _resultSearchController.header.clear();
    _resultSearchController.datarow.clear();
    _resultSearchController.result.clear();
    _resultSearchController.update();
    // updateUserController.refreshtoken.text =
    //     'eyJhbGciOiJIUzI1NiJ9.eyJyb2xlIjoiQURNSU4iLCJzdWIiOiJiZWh6YWRwb3Vybm9vc2hpbkBnbWFpbC5jb20iLCJpYXQiOjE3MTI4MjIzOTUsImV4cCI6MTcxMjkwODc5NX0.31Iqg0MIAaBDxl3RJQDAR5pe522wzxLFvhivkpwBXiI';
    try {
      await http
          .post(urlWithProperties('reporting/search'),
              headers: {
                'Authorization': 'Bearer $accessToken',
                'Content-Type': 'application/json',
              },
              body:
                  jsonEncode(makeSearchBody(optionSearchController.searchs[0])))
          .timeout(const Duration(seconds: 50))
          .then((response) async {
        if (response.statusCode == 200) {
          var jsonMap1 = utf8.decode(response.bodyBytes);
          var jsonMap = jsonDecode(jsonMap1);
          var code = jsonMap["code"];
          var data = jsonMap["data"];
          if (code == '200') {
            //
            if (data.isNotEmpty) {
              if (data['empty'] == false) {
                totalPages = data['totalPages'];
                number = data['number'];
                last = data['last'];
                totalElements = data['totalElements'];

                var content = data['content'];
                int i = 0;
                content.forEach((element) {
                  element.forEach((key, value) {
                    dataRows.add(findLookupDisplayTitle(value, key));
                    priority.add(i++);
                    header.add(key);
                  });
                });
                for (int i = 0; i < header.length; i++) {
                  for (var column in table.fields) {
                    if (column.columnDBFieldName
                            .toString()
                            .replaceAll(' ', '') ==
                        header[i].toString().replaceAll(' ', '')) {
                      header[i] = column.columnTitle;
                    }
                  }
                }

                for (var title in header) {
                  if (_resultSearchController.headers.isEmpty) {
                    _resultSearchController.headers.add(title);
                    _resultSearchController.update();
                  } else {
                    bool find = false;
                    for (var head in _resultSearchController.headers) {
                      if (head == title) {
                        find = true;
                      }
                    }
                    if (find == false) {
                      _resultSearchController.headers.add(title);
                      _resultSearchController.update();
                    }
                  }
                }

                int chunkSize = _resultSearchController.headers.length;
                for (var i = 0; i < dataRows.length; i += chunkSize) {
                  _resultSearchController.datarows.add(dataRows.sublist(
                      i,
                      i + chunkSize > dataRows.length
                          ? dataRows.length
                          : i + chunkSize));
                  _resultSearchController.update();
                }

                _resultSearchController.update();
                _resultSearchController.result.add(ResultSearchModel(
                    header: _resultSearchController.headers,
                    rows: _resultSearchController.datarows,
                    totalPages: totalPages,
                    totalElements: totalElements,
                    last: last,
                    number: number));

                _resultSearchController.update();
                result = true;
              }
            }
          } else {
            var data = jsonMap["data"];
            if (data.isNotEmpty) {
              makeErrorHandling(code, data);
            }
          }
        } else {
          var jsonMap1 = utf8.decode(response.bodyBytes);
          var jsonMap = jsonDecode(jsonMap1);
          var data = jsonMap["data"];
          var code = jsonMap["code"];

          if (data.isNotEmpty) {
            makeErrorHandling(code, data);
          } else {
            makeErrorHandlingWithHttpStatus(response.statusCode);
          }
        }
      });
    } on TimeoutException catch (_) {
      // Handle timeout exception specifically
      if (kDebugMode) {
        print("Request timed out");
      }
      // You can handle timeout specific logic here
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }

    return Future<bool>.value(result);
    //}
  }

  Future<bool> getDataForProperties({
    required String accessToken,
    required OptionSearchController optionSearchController,
  }) async {
    bool result = false;
    List header = [];
    List dataRows = [];
    List<int> priority = [];
    int totalPages = 0;
    int number = 0;
    int totalElements = 0;
    bool last = false;
    late List<MyColumnChartData> myColumnChartData;
    late List<MyPieChartData> myPieChartData;
    late List<MyLineChartData> myLineChartData;
    FullReportController fullReportController = Get.put(FullReportController());
    var table = fullReportController.selectedreport[0].table[0];
    if (kDebugMode) {
      print(table.fields);
    }
    _resultSearchController.headersForProperties.clear();
    _resultSearchController.datarowsForProperties.clear();
    _resultSearchController.resultForProperties.clear();
    _resultSearchController.columnchartdatasource.clear();
    _resultSearchController.piechartdatasource.clear();
    _resultSearchController.linechartdatasource.clear();
    _resultSearchController.chartWidget.clear();
    _resultSearchController.update();
    // updateUserController.refreshtoken.text =
    //     'eyJhbGciOiJIUzI1NiJ9.eyJyb2xlIjoiQURNSU4iLCJzdWIiOiJiZWh6YWRwb3Vybm9vc2hpbkBnbWFpbC5jb20iLCJpYXQiOjE3MTI4MjIzOTUsImV4cCI6MTcxMjkwODc5NX0.31Iqg0MIAaBDxl3RJQDAR5pe522wzxLFvhivkpwBXiI';
    try {
      await http
          .post(urlWithProperties('reporting/search'),
              headers: {
                'Authorization': 'Bearer $accessToken',
                'Content-Type': 'application/json',
              },
              body: jsonEncode(makeSearchBody(
                  optionSearchController.searchForProperties[0])))
          .timeout(const Duration(seconds: 50))
          .then((response) async {
        if (response.statusCode == 200) {
          var jsonMap1 = utf8.decode(response.bodyBytes);
          var jsonMap = jsonDecode(jsonMap1);
          var code = jsonMap["code"];
          var data = jsonMap["data"];

          if (code == '200') {
            //
            if (data.isNotEmpty) {
              if (data['empty'] == false) {
                totalPages = data['totalPages'];
                number = data['number'];
                last = data['last'];
                totalElements = data['totalElements'];

                var content = data['content'];
                int i = 0;
                content.forEach((element) {
                  element.forEach((key, value) {
                    dataRows.add(findLookupDisplayTitle(value, key));
                    priority.add(i++);
                    header.add(key);
                  });
                });
                for (int i = 0; i < header.length; i++) {
                  for (var column in table.fields) {
                    if (column.columnDBFieldName
                            .toString()
                            .replaceAll(' ', '') ==
                        header[i].toString().replaceAll(' ', '')) {
                      header[i] = column.columnTitle;
                    }
                  }
                }

                for (var title in header) {
                  if (_resultSearchController.headersForProperties.isEmpty) {
                    _resultSearchController.headersForProperties.add(title);
                    _resultSearchController.update();
                  } else {
                    bool find = false;
                    for (var head
                        in _resultSearchController.headersForProperties) {
                      if (head == title) {
                        find = true;
                      }
                    }
                    if (find == false) {
                      _resultSearchController.headersForProperties.add(title);
                      _resultSearchController.update();
                    }
                  }
                }

                int chunkSize =
                    _resultSearchController.headersForProperties.length;
                for (var i = 0; i < dataRows.length; i += chunkSize) {
                  _resultSearchController.datarowsForProperties.add(
                      dataRows.sublist(
                          i,
                          i + chunkSize > dataRows.length
                              ? dataRows.length
                              : i + chunkSize));
                  _resultSearchController.update();
                }

                _resultSearchController.update();
                _resultSearchController.resultForProperties.add(
                    ResultSearchModel(
                        header: _resultSearchController.headersForProperties,
                        rows: _resultSearchController.datarowsForProperties,
                        totalPages: totalPages,
                        totalElements: totalElements,
                        last: last,
                        number: number));

                _resultSearchController.update();
                result = true;
                if (fullReportController.selectedreport[0].chart.isNotEmpty) {
                  for (int m = 0;
                      m < fullReportController.selectedreport[0].chart.length;
                      m++) {
                    List<int> elements = [];
                    if (fullReportController
                            .selectedreport[0].chart[m].chartType
                            .toString()
                            .replaceAll(' ', '') ==
                        'column') {
                      myColumnChartData = [];
                      for (int j = 0;
                          j <
                              _resultSearchController
                                  .headersForProperties.length;
                          j++) {
                        for (int k = 0;
                            k <
                                fullReportController.selectedreport[0].chart[m]
                                    .chartFields.length;
                            k++) {
                          if (_resultSearchController.headersForProperties[j]
                                  .toString()
                                  .replaceAll(' ', '') ==
                              fullReportController
                                  .selectedreport[0].chart[m].chartFields[k]
                                  .toString()
                                  .replaceAll(' ', '')) {
                            elements.add(j);
                          }
                        }
                      }

                      for (int i = 0;
                          i <
                              _resultSearchController
                                  .datarowsForProperties.length;
                          i++) {
                        myColumnChartData.add(MyColumnChartData(
                            _resultSearchController.datarowsForProperties[i]
                                [elements[1]],
                            _resultSearchController.datarowsForProperties[i]
                                [elements[0]]));
                      }
                      _resultSearchController.columnchartdatasource
                          .add(ColumnChartModel(dataSource: myColumnChartData));
                      _resultSearchController.update();
                    }

                    if (fullReportController
                            .selectedreport[0].chart[m].chartType
                            .toString()
                            .replaceAll(' ', '') ==
                        'line') {
                      myLineChartData = [];
                      for (int j = 0;
                          j <
                              _resultSearchController
                                  .headersForProperties.length;
                          j++) {
                        for (int k = 0;
                            k <
                                fullReportController.selectedreport[0].chart[m]
                                    .chartFields.length;
                            k++) {
                          if (_resultSearchController.headersForProperties[j]
                                  .toString()
                                  .replaceAll(' ', '') ==
                              fullReportController
                                  .selectedreport[0].chart[m].chartFields[k]
                                  .toString()
                                  .replaceAll(' ', '')) {
                            elements.add(j);
                          }
                        }
                      }

                      for (int i = 0;
                          i <
                              _resultSearchController
                                  .datarowsForProperties.length;
                          i++) {
                        myLineChartData.add(MyLineChartData(
                            int.parse(_resultSearchController
                                .datarowsForProperties[i][elements[1]]),
                            double.parse(_resultSearchController
                                .datarowsForProperties[i][elements[0]])));
                      }

                      _resultSearchController.linechartdatasource
                          .add(LineChartModel(dataSource: myLineChartData));
                      _resultSearchController.update();
                    }
                    if (fullReportController
                            .selectedreport[0].chart[m].chartType
                            .toString()
                            .replaceAll(' ', '') ==
                        'pie') {
                      myPieChartData = [];
                      for (int j = 0;
                          j <
                              _resultSearchController
                                  .headersForProperties.length;
                          j++) {
                        for (int k = 0;
                            k <
                                fullReportController.selectedreport[0].chart[m]
                                    .chartFields.length;
                            k++) {
                          if (_resultSearchController.headersForProperties[j]
                                  .toString()
                                  .replaceAll(' ', '') ==
                              fullReportController
                                  .selectedreport[0].chart[m].chartFields[k]
                                  .toString()
                                  .replaceAll(' ', '')) {
                            elements.add(j);
                          }
                        }
                      }
                      // var titles = [];
                      // for (int i = 0;
                      //     i <
                      //         _resultSearchController
                      //             .datarowsForProperties.length;
                      //     i++) {
                      //   titles.add(_resultSearchController
                      //       .datarowsForProperties[i][elements[0]]);
                      // }
                      // var titles2 = titles.toSet().toList();
                      // for (var title in titles) {
                      //   bool find = false;
                      //   if (titles2.isEmpty) {
                      //     titles2.add(title);
                      //   } else {
                      //     for (var myTitle in titles2) {
                      //       if (myTitle
                      //               .toString()
                      //               .toLowerCase()
                      //               .replaceAll(' ', '') ==
                      //           title
                      //               .toString()
                      //               .toLowerCase()
                      //               .replaceAll(' ', '')) {
                      //         find = true;
                      //       }
                      //     }
                      //     if (find == false) {
                      //       titles2.add(title);
                      //     }
                      //   }
                      // }
                      // print(titles2.length);
                      // for (var title in titles2) {
                      //   print(title);
                      // }
                      // double groupTo = max(1, titles2.length.toDouble() - 1);
                      // print(groupTo);

                      for (int i = 0;
                          i <
                              _resultSearchController
                                  .datarowsForProperties.length;
                          i++) {
                        myPieChartData.add(MyPieChartData(
                            _resultSearchController.datarowsForProperties[i]
                                [elements[0]],
                            _resultSearchController.datarowsForProperties[i]
                                [elements[1]]));
                      }

                      _resultSearchController.piechartdatasource
                          .add(PieChartModel(dataSource: myPieChartData));
                      _resultSearchController.update();
                    }
                  }
                }
              }
            }
          } else {
            var data = jsonMap["data"];
            if (data.isNotEmpty) {
              makeErrorHandling(code, data);
            }
          }
        } else {
          var jsonMap1 = utf8.decode(response.bodyBytes);
          var jsonMap = jsonDecode(jsonMap1);
          var data = jsonMap["data"];
          var code = jsonMap["code"];

          if (data.isNotEmpty) {
            makeErrorHandling(code, data);
          } else {
            makeErrorHandlingWithHttpStatus(response.statusCode);
          }
        }
      });
    } on TimeoutException catch (_) {
      // Handle timeout exception specifically
      if (kDebugMode) {
        print("Request timed out");
      }
      // You can handle timeout specific logic here
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }

    return Future<bool>.value(result);
    //}
  }

  Future<bool> getDataJson({
    required String accessToken,
    required OptionSearchController optionSearchController,
  }) async {
    bool result = false;
    List header = [];
    List dataRows = [];

    // updateUserController.refreshtoken.text =
    //     'eyJhbGciOiJIUzI1NiJ9.eyJyb2xlIjoiQURNSU4iLCJzdWIiOiJiZWh6YWRwb3Vybm9vc2hpbkBnbWFpbC5jb20iLCJpYXQiOjE3MTI4MjIzOTUsImV4cCI6MTcxMjkwODc5NX0.31Iqg0MIAaBDxl3RJQDAR5pe522wzxLFvhivkpwBXiI';
    try {
      await http
          .post(urlWithProperties('reporting/searchByApi'),
              headers: {
                'Authorization': 'Bearer $accessToken',
                'Content-Type': 'application/json',
                'accept': '*/*'
              },
              body: jsonEncode(
                  makeSetInputService(optionSearchController.fullsearchapi[0])))
          .timeout(const Duration(seconds: 60))
          .then((response) async {
        if (response.statusCode == 200) {
          var jsonMap1 = utf8.decode(response.bodyBytes);
          var jsonMap = jsonDecode(jsonMap1);
          if (kDebugMode) {
            print(jsonMap);
          }
          var code = jsonMap["code"];
          var data = jsonMap["data"];

          if (code == '200') {
            //

            if (data.isNotEmpty) {
              var body = data["body"];

              if (body.isNotEmpty) {
                var content = body;

                result = true;
                jsonController.jsonText.value = jsonEncode(body);
                jsonController.update();
                var finalContent;
                var content1 = content['result'];
                var content2 = content1['data'];

                // if (content3.isNotEmpty) {
                //   finalContent = content3;
                // } else
                if (content2.isNotEmpty) {
                  finalContent = content2;
                } else if (content1.isNotEmpty) {
                  finalContent = content1;
                } else {
                  finalContent = content;
                }
                result = true;
                var flatJson = data["flatJson"];
                if (flatJson.isNotEmpty) {
                  var data2 = data["flatJson"];
                  data2.forEach((element) {
                    element.forEach((key, value) {
                      dataRows.add(value);

                      header.add(key.toString().replaceAll('.', '-'));
                    });
                  });

                  for (var title in header) {
                    if (jsonController.headers.isEmpty) {
                      jsonController.headers.add(title);
                      jsonController.update();
                    } else {
                      bool find = false;
                      for (var head in jsonController.headers) {
                        if (head == title) {
                          find = true;
                        }
                      }
                      if (find == false) {
                        jsonController.headers.add(title);
                        jsonController.update();
                      }
                    }
                  }

                  int chunkSize = jsonController.headers.length;
                  for (var i = 0; i < dataRows.length; i += chunkSize) {
                    jsonController.datarows.add(dataRows.sublist(
                        i,
                        i + chunkSize > dataRows.length
                            ? dataRows.length
                            : i + chunkSize));
                    jsonController.update();
                  }

                  jsonController.update();
                }
              }
            }
          } else {
            var data = jsonMap["data"];
            if (data.isNotEmpty) {
              makeErrorHandling(code, data);
            }
          }
        } else {
          var jsonMap1 = utf8.decode(response.bodyBytes);
          var jsonMap = jsonDecode(jsonMap1);
          var data = jsonMap["data"];
          var code = jsonMap["code"];

          if (data.isNotEmpty) {
            makeErrorHandling(code, data);
          } else {
            makeErrorHandlingWithHttpStatus(response.statusCode);
          }
        }
      });
    } on TimeoutException catch (_) {
      // Handle timeout exception specifically
      if (kDebugMode) {
        print("Request timed out");
      }
      // You can handle timeout specific logic here
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }

    if (kDebugMode) {
      print(filterController.filter.length);
    }

    return Future<bool>.value(result);
    //}
  }

  Future<bool> grouplookupname(
      {required groupName, required index, required accessToken}) async {
    bool result = false;

    try {
      await http
          .post(
            urlWithProperties('reporting/getAllLookupsByGroupName'),
            headers: {
              'Authorization': 'Bearer $accessToken',
              'Content-Type': 'application/json',
            },
            body: jsonEncode({'groupName': groupName}),
          )
          .timeout(const Duration(seconds: 10))
          .then((response) {
        if (response.statusCode == 200) {
          var jsonMap1 = utf8.decode(response.bodyBytes);
          var jsonMap = jsonDecode(jsonMap1);
          if (kDebugMode) {
            print(jsonMap);
          }
          var code = jsonMap["code"];
          var data = jsonMap["data"];
          var items = [];
          var itemsTitle = [];

          if (code == '200') {
            if (data.isNotEmpty) {
              result = true;

              for (var item in data) {
                if (item['groupName'] == groupName) {
                  items.add(item['displayTitle']);
                  itemsTitle.add(item['title']);
                }
              }
              filterController.filter[index].items = items;
              filterController.filter[index].itemsTitle = itemsTitle;
              filterController.update();
            }
          } else {
            var data = jsonMap["data"];
            if (data.isNotEmpty) {
              makeErrorHandling(code, data);
            }
          }
        } else {
          var jsonMap1 = utf8.decode(response.bodyBytes);
          var jsonMap = jsonDecode(jsonMap1);
          var data = jsonMap["data"];
          var code = jsonMap["code"];

          if (data.isNotEmpty) {
            makeErrorHandling(code, data);
          } else {
            makeErrorHandlingWithHttpStatus(response.statusCode);
          }
        }
      });
    } on TimeoutException catch (_) {
      // Handle timeout exception specifically
      if (kDebugMode) {
        print("Request timed out");
      }
      // You can handle timeout specific logic here
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }

    if (kDebugMode) {
      print(filterController.filter.length);
    }

    return Future<bool>.value(result);
    //}
  }

  //Auth Methods:
  //login
  Future<bool> login({required LoginModel login}) async {
    bool result = false;

    try {
      await http
          .post(
            urlWithProperties('auth/authenticate'),
            body: jsonEncode(makeLoginBody(login)),
            headers: {
              'Content-Type': 'application/json',
            },
          )
          .timeout(const Duration(seconds: 10))
          .then((response) async {
            if (kDebugMode) {
              print(response.statusCode);
            }
            if (response.statusCode == 200) {
              var jsonMap = json.decode(response.body);
              var code = jsonMap["code"];
              var data = jsonMap["data"];
              if (code == '200') {
                if (data.isNotEmpty) {
                  Get.put(LoginController()).isLogin = true;
                  Get.put(LoginController()).update();
                  loginresponsecontroller.resultcallapi.text = 'true';
                  loginresponsecontroller.code.text = jsonMap["code"];
                  loginresponsecontroller.accesstoken.text =
                      data['access_token'];

                  loginresponsecontroller.refreshtoken.text =
                      data['refresh_token'];
                  await userController.saveEmail(userController.username.text);
                  userController.update();
                  await loginresponsecontroller.saveAccessToken(
                      loginresponsecontroller.accesstoken.text);
                  await loginresponsecontroller.loadAccessToken();
                  cornometerController.resetTimeDuration();
                  await loginresponsecontroller.saveIsLoggedIn(true);

                  loginresponsecontroller.update();

                  result = true;
                }
              } else {
                var data = jsonMap["data"];
                if (data.isNotEmpty) {
                  makeErrorHandling(code, data);
                }
              }
            } else {
              var jsonMap1 = utf8.decode(response.bodyBytes);
              var jsonMap = jsonDecode(jsonMap1);
              var data = jsonMap["data"];
              var code = jsonMap["code"];

              if (data.isNotEmpty) {
                makeErrorHandling(code, data);
              } else {
                makeErrorHandlingWithHttpStatus(response.statusCode);
              }
            }
          });
    } on TimeoutException catch (_) {
      // Handle timeout exception specifically
      if (kDebugMode) {
        print("Request timed out");
      }
      // You can handle timeout specific logic here
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }

    return Future<bool>.value(result);
    //}
  }

  //RefreshToken:
  Future<bool> refreshToken() async {
    bool result = false;
    LoginResponseController loginresponsecontroller =
        Get.put(LoginResponseController());
    CornometerController cornometerController = Get.put(CornometerController());
    try {
      await http
          .post(
            urlWithProperties('auth/refresh-token'),
            headers: {
              'Authorization':
                  'Bearer ${loginresponsecontroller.accesstoken.text}',
              'Content-Type': 'application/json',
            },
          )
          .timeout(const Duration(seconds: 10))
          .then((response) async {
            if (kDebugMode) {
              print(response.statusCode);
            }
            if (response.statusCode == 200) {
              var jsonMap = json.decode(response.body);
              var code = jsonMap["code"];
              var data = jsonMap["data"];
              if (code == '200') {
                if (data.isNotEmpty) {
                  userController.accesstoken.text = data['access_token'];
                  loginresponsecontroller.refreshtoken.text =
                      data['access_token'];
                  loginresponsecontroller.accesstoken.text =
                      data['access_token'];
                  userController.update();
                  loginresponsecontroller.update();
                  await loginresponsecontroller
                      .saveAccessToken(data['access_token']);
                  loginresponsecontroller.update();
                  cornometerController.resetTimeDuration();
                  cornometerController.update();
                  makeUserProperties(userController);

                  result = true;
                }
              } else {
                var data = jsonMap["data"];
                if (data.isNotEmpty) {
                  makeErrorHandling(code, data);
                }
              }
            } else {
              var jsonMap1 = utf8.decode(response.bodyBytes);
              var jsonMap = jsonDecode(jsonMap1);
              var data = jsonMap["data"];
              var code = jsonMap["code"];

              if (data.isNotEmpty) {
                makeErrorHandling(code, data);
              } else {
                makeErrorHandlingWithHttpStatus(response.statusCode);
              }
            }
          });
    } on TimeoutException catch (_) {
      // Handle timeout exception specifically
      if (kDebugMode) {
        print("Request timed out");
      }
      // You can handle timeout specific logic here
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }

    return Future<bool>.value(result);
    //}
  }

//getuser
  Future<bool> getUser({required userController, required email}) async {
    String firstname;
    String lastname;
    String mobileNumber;
    String address;
    String password;
    String gender;
    String role;
    bool active;
    bool hasExcelExport;
    bool hasPDFExport;
    bool hasChart;

    bool result = false;

    try {
      await http
          .post(
            urlWithProperties('reporting/getUserByEmail'),
            headers: {
              'Authorization': 'Bearer ${userController.accesstoken.text}',
              'Content-Type': 'application/json',
            },
            body: jsonEncode({"email": email}),
          )
          .timeout(const Duration(seconds: 10))
          .then((response) {
        if (kDebugMode) {
          print(response.statusCode);
        }
        if (response.statusCode == 200) {
          var jsonMap1 = utf8.decode(response.bodyBytes);
          var jsonMap = jsonDecode(jsonMap1);
          var code = jsonMap["code"];
          var data = jsonMap['data'];
          if (code == '200') {
            if (data.isNotEmpty) {
              if (kDebugMode) {
                print(data);
              }

              firstname = data['firstname'] ?? '';
              lastname = data['lastname'] ?? '';
              mobileNumber = data['mobileNumber'] ?? '';
              address = data['address'] ?? '';
              gender = data['gender'] ?? 'MALE';
              password = data['password'] ?? '';
              active = data['active'] ?? true;
              role = data['role'] ?? 'USER';
              hasExcelExport = data['hasExcelExport'] ?? '';
              hasPDFExport = data['hasPDFExport'] ?? '';
              hasChart = data['hasChart'] ?? '';

              accountController.account.add(AccountModel(
                  firstname: firstname,
                  lastname: lastname,
                  email: email,
                  password: password,
                  address: address,
                  mobileNumber: mobileNumber,
                  gender: gender,
                  active: active,
                  hasExcelExport: hasExcelExport,
                  hasPDFExport: hasPDFExport,
                  hasChart: hasChart,
                  role: role));
              accountController.update();
              result = true;
            }
          } else {
            var data = jsonMap["data"];
            if (data.isNotEmpty) {
              makeErrorHandling(code, data);
            } else {
              makeErrorHandling(code, '');
            }
          }
        } else {
          var jsonMap1 = utf8.decode(response.bodyBytes);
          var jsonMap = jsonDecode(jsonMap1);
          var data = jsonMap["data"];
          var code = jsonMap["code"];

          if (data.isNotEmpty) {
            makeErrorHandling(code, data);
          } else {
            makeErrorHandlingWithHttpStatus(response.statusCode);
          }
        }
      });
    } on TimeoutException catch (_) {
      // Handle timeout exception specifically
      if (kDebugMode) {
        print("Request timed out");
      }
      // You can handle timeout specific logic here
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }

    return Future<bool>.value(result);
    //}
  }

  Future<bool>? changePassword(
      {required String currentPassword,
      required String newPassword,
      required String accessToken}) async {
    bool result = false;
    try {
      await http
          .post(urlWithProperties('reporting/changePassword'),
              headers: {
                'Authorization': 'Bearer $accessToken',
                'Content-Type': 'application/json',
              },
              body: jsonEncode({
                "currentPassword": currentPassword,
                "newPassword": newPassword
              }))
          .timeout(const Duration(seconds: 10))
          .then((response) {
        if (response.statusCode == 200) {
          var jsonMap = json.decode(response.body);
          var code = jsonMap["code"];
          var data = jsonMap["data"];
          if (code == '200') {
            result = true;
          } else {
            makeErrorHandling(code, data);
          }
        } else {
          var jsonMap = json.decode(response.body);
          var code = jsonMap["code"];
          var data = jsonMap["data"];
          if (data.isNotEmpty) {
            makeErrorHandling(code, data);
          } else {
            makeErrorHandlingWithHttpStatus(response.statusCode);
          }
        }
      });
    } on TimeoutException catch (_) {
      // Handle timeout exception specifically
      if (kDebugMode) {
        print("Request timed out");
      }
      // You can handle timeout specific logic here
      makeErrorHandlingWithHttpStatus(504);
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
    return Future<bool>.value(result);
  }

  //updateUser:
  Future<bool>? updateUser(
      {required userController, required accountController}) async {
    AccountsController accountsController = Get.put(AccountsController());
    bool result = false;

    try {
      await http
          .post(
            urlWithProperties('reporting/updateUser'),
            headers: {
              'Authorization': 'Bearer ${userController.accesstoken.text}',
              'Content-Type': 'application/json',
            },
            body: jsonEncode(
                makeUpdateUserBody(accountsController.accountsSelected[0])),
          )
          .timeout(const Duration(seconds: 10))
          .then((response) {
        if (response.statusCode == 200) {
          var jsonMap = json.decode(response.body);
          var code = jsonMap["code"];
          if (code == '200') {
            result = true;
            accountController.account.clear();
            accountController.update();
            accountController.account = accountController.accountsSelected;
            accountController.update();
            accountController.accountsSelected.clear();
            accountController.update();
          } else {
            var data = jsonMap["data"];
            if (data.isNotEmpty) {
              makeErrorHandling(code, data);
            }
          }
        } else {
          var jsonMap = json.decode(response.body);
          var code = jsonMap["code"];
          var data = jsonMap["data"];
          if (data.isNotEmpty) {
            makeErrorHandling(code, data);
          } else {
            makeErrorHandlingWithHttpStatus(response.statusCode);
          }
        }
      });
    } on TimeoutException catch (_) {
      // Handle timeout exception specifically
      if (kDebugMode) {
        print("Request timed out");
      }
      // You can handle timeout specific logic here
      makeErrorHandlingWithHttpStatus(504);
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }

    return Future<bool>.value(result);
    //}
  }
}
