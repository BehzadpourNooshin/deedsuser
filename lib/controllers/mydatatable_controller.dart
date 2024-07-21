import 'package:dc_datatable_paginator/dc_datatable_paginator.dart';
import 'package:deedsuser/models/datashow_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

final List<Map<String, dynamic>> datas = [
  {
    'activeports': 1,
    'reservedport': 2,
    'province': 31,
  },
  {
    'activeports': 2,
    'reservedport': 2,
    'province': 21,
  },
  {
    'activeports': 2,
    'reservedport': 2,
    'province': 21,
  },
  {
    'activeports': 2,
    'reservedport': 2,
    'province': 21,
  },
  {
    'activeports': 2,
    'reservedport': 2,
    'province': 21,
  },
  {
    'activeports': 1,
    'reservedport': 2,
    'province': 31,
  },
  {
    'activeports': 2,
    'reservedport': 2,
    'province': 21,
  },
  {
    'activeports': 2,
    'reservedport': 2,
    'province': 21,
  },
  {
    'activeports': 2,
    'reservedport': 2,
    'province': 21,
  },
  {
    'activeports': 2,
    'reservedport': 2,
    'province': 21,
  },
  {
    'activeports': 1,
    'reservedport': 2,
    'province': 31,
  },
  {
    'activeports': 2,
    'reservedport': 2,
    'province': 21,
  },
  {
    'activeports': 2,
    'reservedport': 2,
    'province': 21,
  },
  {
    'activeports': 2,
    'reservedport': 2,
    'province': 21,
  },
  {
    'activeports': 2,
    'reservedport': 2,
    'province': 21,
  },
  {
    'activeports': 1,
    'reservedport': 2,
    'province': 31,
  },
  {
    'activeports': 2,
    'reservedport': 2,
    'province': 21,
  },
  {
    'activeports': 2,
    'reservedport': 2,
    'province': 21,
  },
  {
    'activeports': 2,
    'reservedport': 2,
    'province': 21,
  },
  {
    'activeports': 2,
    'reservedport': 2,
    'province': 21,
  },
];

class MyDataTableController extends DcDataTableController {
  MyDataTableController(super.context);

  @override
  Future<void> onLoadData() async {
    //get Data from API
    debugPrint("fetch data from  api...");
    loadding = true;
    Future.delayed(
      const Duration(seconds: 2),
      () {
        List<ModelExample> dataList = List.generate(pageSize, (i) {
          i++;
          return ModelExample(
              id: i + (currentPage * 10),
              name: "Name ${i + (currentPage * 10)} ",
              description:
                  "Description:  Record:${i + (currentPage * 10)}  Page: ${currentPage + 1}  search: $searchValue ");
        });

        //set result Data from Api
        data = dataList;
        //symbolic value
        totalRecords = 110;
        //close dialog loading
        loadding = false;
      },
    );
  }

  @override
  DataRow getRow(int rowIndex) {
    ModelExample model = data[rowIndex];
    return DataRow(
        cells: <DataCell>[
          DataCell(Text(model.id.toString())),
          DataCell(Text(model.name)),
          DataCell(Text(model.description)),
        ],
        selected: dataSelected.contains(model),
        onSelectChanged: (value) {
          if (dataSelected.contains(model)) {
            dataSelected.remove(model);
          } else {
            dataSelected.add(model);
          }
          onLoadData();
        });
  }
}
