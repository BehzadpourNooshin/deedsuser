class SearchDetail {
  SearchDetail({
    required this.formItemTitle,
    required this.value,
    required this.from,
    required this.to,
    // this.active = true,

    // required this.columns,
  });

  late final String formItemTitle;
  late final List value;
  late final String from;
  late final String to;
  // late final bool active;

  // late final List<ColumnModel> columns;

  static List<SearchDetail> listFromJson(dynamic json) {
    return List<SearchDetail>.from(
        json.map((searchs) => SearchDetail.fromJson(searchs)));
  }

  Map<String, dynamic> toJson() {
    return {
      'formItemTitle': formItemTitle,
      'value': value,
      'from': from,
      'to': to,
      //    'active': active,
      // , 'columns': columns
    };
  }

  factory SearchDetail.fromJson(dynamic json) {
    return SearchDetail(
      formItemTitle: json['formItemTitle'],
      value: json['value'],
      from: json['from'],
      to: json['to'],
      //  active: json['active'],
      //  columns: json['columns']
    );
  }
  // ArpuModel.fromJson(Map<String, dynamic> json)
  //     : technology = json['technology'],
  //       rial = json['rial'];
}
