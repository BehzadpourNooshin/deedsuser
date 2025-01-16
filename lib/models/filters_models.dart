import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';

class FilterModel {
  FilterModel({
    required this.formItemTitle,
    required this.formItemDisplayTitle,
    required this.formItemType,
    required this.formItemInputType,
    required this.formItemValidationType,
    required this.formItemInputTypeHint,
    required this.lookupName,
    required this.parentLookupName,
    this.search = '',
    this.selectedItem = '',
    List<String>? items,
    List<String>? itemsTitle,
    required this.textEditingController,
  });

  late final String formItemTitle;
  late final String formItemDisplayTitle;
  late final String formItemType;
  late final String formItemInputType;
  late final String formItemValidationType;
  late final String formItemInputTypeHint;
  late final String lookupName;
  late final String parentLookupName;
  late String search;
  late String selectedItem;
  late RxList<String> items = <String>[].obs;
  late RxList<String> itemsTitle = <String>[].obs;

  late TextEditingController textEditingController = TextEditingController();

  static List<FilterModel> listFromJson(dynamic json) {
    return List<FilterModel>.from(
        json.map((filters) => FilterModel.fromJson(filters)));
  }

  Map<String, dynamic> toJson() {
    return {
      'formItemTitle': formItemTitle,
      'formItemDisplayTitle': formItemDisplayTitle,
      'formItemType': formItemType,
      'formItemInputType': formItemInputType,
      'formItemValidationType': formItemValidationType,
      'formItemInputTypeHint': formItemInputTypeHint,
      'lookupName': lookupName,
      'parentLookupName': parentLookupName,
      'selectedItem': selectedItem,
      'items': items,
      'itemsTitle': itemsTitle,
      'search': search,
      'textEditingController': textEditingController
    };
  }

  factory FilterModel.fromJson(dynamic json) {
    return FilterModel(
      formItemTitle: json['formItemTitle'],
      formItemDisplayTitle: json['formItemDisplayTitle'],
      formItemType: json['formItemType'],
      formItemInputType: json['formItemInputType'],
      formItemValidationType: json['formItemValidationType'],
      formItemInputTypeHint: json['formItemInputTypeHint'],
      lookupName: json['lookupName'],
      parentLookupName: json['parentLookupName'],
      items: json['items'],
      selectedItem: json['selectedItem'],
      itemsTitle: json['itemsTitle'],
      search: json['search'],
      textEditingController: json['textEditingController'],
    );
  }
}
