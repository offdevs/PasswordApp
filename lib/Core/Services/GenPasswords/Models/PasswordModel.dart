class PasswordModel {
  final String id;
  final String name;
  final String value;

  new({required this.id, required this.name, required this.value});

  Map<String, dynamic> toJson() {
    return {"id": id, "name": name, "value": value};
  }

  factory PasswordModel.fromJson(Map<String, dynamic> json) {
    return PasswordModel(
      id: json["id"],
      name: json["name"],
      value: json["value"],
    );
  }
}
