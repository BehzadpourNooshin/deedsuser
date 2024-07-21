import 'package:deedsuser/models/datafortable_model.dart';
import 'package:get/get.dart';

class DataForTableController extends GetxController {
  int offset = 0;
  int limit = 10;
  RxList<DataForTableModel> datasfortable = <DataForTableModel>[].obs;
}
