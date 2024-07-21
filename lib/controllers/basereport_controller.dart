import 'package:deedsuser/models/basereport_model.dart';
import 'package:get/get.dart';

class BaseReportController extends GetxController {
  RxList<BaseReportModel> basereports = <BaseReportModel>[].obs;

  late bool showReport = true;
}
