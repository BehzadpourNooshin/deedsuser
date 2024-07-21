import 'package:deedsuser/models/category_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategoryController extends GetxController {
  final categoriesLoading = false.obs;
  var selectedReportIndex = 0.obs;

  final categoryTitle = TextEditingController();
  final categoryId = TextEditingController();
  final reportId = TextEditingController();
  RxList<CategoryModel> categories = <CategoryModel>[].obs;
  late RxMap<String, dynamic> objectReportDropDown;
  late bool showReport = true;
}
