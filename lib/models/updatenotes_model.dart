class UpdatenotesModel {
  UpdatenotesModel({
    required this.version,
    required this.description,
  });

  late final String version;
  late final String description;

  static List<UpdatenotesModel> listFromJson(dynamic json) {
    return List<UpdatenotesModel>.from(
        json.map((basereport) => UpdatenotesModel.fromJson(basereport)));
  }

  Map<String, dynamic> toJson() {
    return {
      'version': version,
      'description': description,
    };
  }

  factory UpdatenotesModel.fromJson(dynamic json) {
    return UpdatenotesModel(
      version: json['version'],
      description: json['description'],
    );
  }
  // ArpuModel.fromJson(Map<String, dynamic> json)
  //     : technology = json['technology'],
  //       rial = json['rial'];
}

class UpdatenotesModelGroupByVersion {
  UpdatenotesModelGroupByVersion({
    required this.version,
    required this.description,
  });

  late final String version;
  late final List<String> description;

  static List<UpdatenotesModelGroupByVersion> listFromJson(dynamic json) {
    return List<UpdatenotesModelGroupByVersion>.from(json.map(
        (basereport) => UpdatenotesModelGroupByVersion.fromJson(basereport)));
  }

  Map<String, dynamic> toJson() {
    return {
      'version': version,
      'description': description,
    };
  }

  factory UpdatenotesModelGroupByVersion.fromJson(dynamic json) {
    return UpdatenotesModelGroupByVersion(
      version: json['version'],
      description: json['description'],
    );
  }
  // ArpuModel.fromJson(Map<String, dynamic> json)
  //     : technology = json['technology'],
  //       rial = json['rial'];
}
