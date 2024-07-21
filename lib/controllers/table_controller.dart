import 'package:deedsuser/models/tables_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TableController extends GetxController {
  final searchTables = '-'.obs;
  final dbTableName = TextEditingController();
  final rowPerPage = PaginatedDataTable.defaultRowsPerPage.obs;

  RxList<TableModel> table = <TableModel>[].obs;
  bool isAdd = false;
  int index = 0;
  List<Map<String, dynamic>> data = List.generate(
    200,
    (index) => {
      'foo': 'Foo $index',
      'bar': 'Bar $index',
    },
  );
  List<Map<String, String>> get sortedData =>
      List.from(data)..sort((a, b) => a['bar']!.compareTo(b['bar']!));
  void onPageChanged(int? n) {
    if (n != null) {
      debugPrint('onRowsPerPageChanged ${rowPerPage.value} ${data.length - n}');
      if (data.length - n < rowPerPage.value) {
        rowPerPage.value = data.length - n;
      } else {
        rowPerPage.value = PaginatedDataTable.defaultRowsPerPage;
      }
    } else {
      rowPerPage.value = 0;
    }
  }

  void sortByBar(int columnIndex, bool ascending) {
    if (columnIndex == 1) {
      data.sort((a, b) {
        final int aValue = int.parse(a['bar']!);
        final int bValue = int.parse(b['bar']!);
        if (ascending) {
          return aValue.compareTo(bValue);
        } else {
          return bValue.compareTo(aValue);
        }
      });
      update();
    }
  }
}
