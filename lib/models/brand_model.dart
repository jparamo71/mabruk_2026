class BrandModel {
  final int brandId;
  final String brandName;

  BrandModel({required this.brandId, required this.brandName});

  factory BrandModel.fromJson(Map<String, dynamic> json) => BrandModel(
    brandId: int.parse(json["id"].toString()),
    brandName: json["name"] ?? '',
  );

  Map<String, dynamic> toJson() => {
    'brandId': brandId,
    'brandname': brandName
  };
}
