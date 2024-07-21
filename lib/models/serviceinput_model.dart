class ServiceInputModel {
  ServiceInputModel({
    required this.parameterName,
    required this.parameterType,
    required this.parameterInputType,
    this.parameterValue = '',
  });

  late final String parameterName;
  late final String parameterType;
  late final String parameterInputType;
  late String parameterValue;
  static List<ServiceInputModel> listFromJson(dynamic json) {
    return List<ServiceInputModel>.from(
        json.map((basereport) => ServiceInputModel.fromJson(basereport)));
  }

  Map<String, dynamic> toJson() {
    return {
      'parameterName': parameterName,
      'parameterType': parameterType,
      'parameterInputType': parameterInputType,
      'parameterValue': parameterValue,
    };
  }

  factory ServiceInputModel.fromJson(dynamic json) {
    return ServiceInputModel(
      parameterName: json['parameterName'],
      parameterType: json['parameterType'],
      parameterInputType: json['parameterInputType'],
      parameterValue: json['parameterValue'],
    );
  }
}
