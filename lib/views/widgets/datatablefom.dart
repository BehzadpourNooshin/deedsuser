import 'package:dc_datatable_paginator/dc_datatable_paginator.dart';
import 'package:deedsuser/controllers/mydatatable_controller.dart';
import 'package:deedsuser/models/datashow_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DataTableForm extends GetView<MyDataTableController> {
  const DataTableForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    DcDataTableController controller = MyDataTableController(context);

    controller.sortColumnIndex = 1;
    controller.limitPages = 10;
    controller.pageSize = 7;

    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        ///  Widget Definition
        DcDataTable(
          controller: controller,
          labelPage: 'جدول',
          labelRecords: 'گزارشات',
          labelNoRecords: 'رکوردی موجود نیست',
          showCheckboxColumn: false,
          showInputSearch: true,
          textInputActionSearch: TextInputAction.search,
          columns: [
            //api
            DataColumn(
                label: const Text(
                  'کد شهر',
                  textAlign: TextAlign.center,
                ),
                onSort: (columnIndex, ascending) {
                  onSortColumn(controller, columnIndex, ascending);
                }),
            DataColumn(
                label: const Text(
                  '',
                  textAlign: TextAlign.center,
                ),
                onSort: (columnIndex, ascending) {
                  onSortColumn(controller, columnIndex, ascending);
                }),
            DataColumn(
                label: const Text('Description'),
                onSort: (columnIndex, ascending) {
                  onSortColumn(controller, columnIndex, ascending);
                }),
          ],
        ),
      ],
    );

    //record search simulation in an api
  }

  void onSortColumn(
      DcDataTableController controller, int columnIndex, bool ascending) {
    List<ModelExample> list = List<ModelExample>.from(controller.data);

    if (columnIndex == 0) {
      list.sort((m1, m2) => DcDataTableController.compareString(
          ascending, m1.id.toString(), m2.id.toString()));
    } else if (columnIndex == 1) {
      list.sort((m1, m2) =>
          DcDataTableController.compareString(ascending, m1.name, m2.name));
    } else if (columnIndex == 2) {
      list.sort((m1, m2) => DcDataTableController.compareString(
          ascending, m1.description, m2.description));
    }

    controller.data = list;
    controller.sortAscending = ascending;
    controller.sortColumnIndex = columnIndex;
  }
}
