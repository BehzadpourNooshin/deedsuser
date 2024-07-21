class ResultSearchModel {
  ResultSearchModel(
      {required this.header,
      required this.rows,
      required this.totalPages,
      required this.last,
      required this.totalElements,
      required this.number});

  late final List header;
  late final List rows;
  late final int totalPages;
  late final int totalElements;
  late final bool last;
  late final int number;

  static List<ResultSearchModel> listFromJson(dynamic json) {
    return List<ResultSearchModel>.from(
        json.map((rows) => ResultSearchModel.fromJson(rows)));
  }

  Map<String, dynamic> toJson() {
    return {
      'header': header,
      'rows': rows,
      'totalPages': totalPages,
      'last': last,
      'totalElements': totalElements,
      'number': number
    };
  }

  factory ResultSearchModel.fromJson(dynamic json) {
    return ResultSearchModel(
      header: json['header'],
      rows: json['rows'],
      totalPages: json['totalPages'],
      last: json['last'],
      totalElements: json['totalElements'],
      number: json['number'],
    );
  }
  // ArpuModel.fromJson(Map<String, dynamic> json)
  //     : technology = json['technology'],
  //       rial = json['rial'];
}
