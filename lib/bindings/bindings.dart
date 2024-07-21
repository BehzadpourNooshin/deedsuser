import 'package:deedsuser/controllers/MenuAppController.dart';
import 'package:deedsuser/controllers/accounts_controller.dart';
import 'package:deedsuser/controllers/apicall_controller.dart';
import 'package:deedsuser/controllers/basicdashboard_controller.dart';
import 'package:deedsuser/controllers/category_controller.dart';
import 'package:deedsuser/controllers/chart_controller.dart';
import 'package:deedsuser/controllers/columns_controller.dart';
import 'package:deedsuser/controllers/cornometer_controller.dart';
import 'package:deedsuser/controllers/errorhandeling_controller.dart';
import 'package:deedsuser/controllers/filter_controller.dart';
import 'package:deedsuser/controllers/full_report_controller.dart';
import 'package:deedsuser/controllers/json_controller.dart';
import 'package:deedsuser/controllers/loginresponse_controller.dart';
import 'package:deedsuser/controllers/offlinemenu_controller.dart';
import 'package:deedsuser/controllers/onlinemenu_controller.dart';
import 'package:deedsuser/controllers/report_controller.dart';
import 'package:deedsuser/controllers/reportbasecategory_controller.dart';
import 'package:deedsuser/controllers/reportsbycategory_controller.dart';
import 'package:deedsuser/controllers/resultsearch_controller.dart';
import 'package:deedsuser/controllers/serviceinputinfo_controller.dart';
import 'package:deedsuser/controllers/setting_controller.dart';
import 'package:deedsuser/controllers/showfilterformcontroller.dart';
import 'package:deedsuser/controllers/table_controller.dart';
import 'package:deedsuser/controllers/updatenote_controller.dart';
import 'package:deedsuser/controllers/updateuser_controller.dart';
import 'package:deedsuser/controllers/user_controller.dart';
import 'package:get/get.dart';
import 'package:deedsuser/controllers/login_controller.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class MyBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LoginController());
    //  Get.lazyPut(() => ReportsController());
    Get.lazyPut(() => MenuAppController());
    Get.lazyPut(() => ReportController());
    Get.lazyPut(() => TableController());
    Get.lazyPut(() => FilterController());
    Get.lazyPut(() => SettingController());
    Get.lazyPut(() => ColumnController());
    Get.lazyPut(() => ChartController());
    Get.lazyPut(() => FullReportController());
    Get.lazyPut(() => MyOnlineReportController());
    Get.lazyPut(() => MyOfflineReportsController());
    Get.lazyPut(() => MyFilterFormController());
    Get.lazyPut(() => MenuAppController());
    Get.lazyPut(() => ChartController());
    Get.lazyPut(() => CategoryController());
    Get.lazyPut(() => UserController());
    Get.lazyPut(() => UpdateUserController());
    Get.lazyPut(() => ReportBaseCategoryController());
    Get.lazyPut(() => LoginResponseController());
    Get.lazyPut(() => APICallController());
    Get.lazyPut(() => DataGridController());
    Get.lazyPut(() => AccountsController());
    Get.lazyPut(() => ReportsByCategoryController());
    Get.lazyPut(() => FullReportController());
    Get.lazyPut(() => ResultSearchController());
    Get.lazyPut(() => JsonController());
    Get.lazyPut(() => BasicDashboardInfoController());
    Get.lazyPut(() => ServiceInputController());
    Get.lazyPut(() => ErrorhandelingController());
    Get.lazyPut(() => CornometerController());
    Get.lazyPut(() => UpdateNoteController());
  }
}
