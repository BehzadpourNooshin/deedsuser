import 'package:deedsuser/models/search_model.dart';
import 'package:deedsuser/models/searchdetail_model.dart';
import 'package:deedsuser/models/serviceinput_model.dart';
import 'package:deedsuser/models/serviceinputfinal_model.dart';
import 'package:get/get.dart';

class OptionSearchController extends GetxController {
  RxList<SearchModel> searchs = <SearchModel>[].obs;
  RxList<ServiceInputFinalModel> fullsearchapi = <ServiceInputFinalModel>[].obs;
  RxList<ServiceInputModel> searchapi = <ServiceInputModel>[].obs;
  RxList<SearchDetail> searchDetail = <SearchDetail>[].obs;
  RxList<SearchModel> searchForProperties = <SearchModel>[].obs;
  RxList<SearchDetail> searcDetailhForProperties = <SearchDetail>[].obs;
}
