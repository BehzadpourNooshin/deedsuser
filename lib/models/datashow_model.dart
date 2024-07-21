class ModelExample {
  final int id;
  final String name;
  final String description;

  ModelExample({
    required this.id,
    required this.name,
    required this.description,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ModelExample &&
        other.id == id &&
        other.name == name &&
        other.description == description;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ description.hashCode;
}
