class BrandModel {
  final int id;
  final String name;

  BrandModel({required this.id, required this.name});

  factory BrandModel.fromJson(Map<String, dynamic> json) => BrandModel(
    id: int.parse(json["id"].toString()),
    name: json["name"] ?? '',
  );

  factory BrandModel.empty() => BrandModel(id: 0, name: '');

  Map<String, dynamic> toJson() => {'id': id, 'name': name};

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BrandModel && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;

}
