import 'package:mabruk_2026/utils/globals.dart';

class ProductModel {
  final int productId;
  final String productCode;
  final String justName;
  final String productName;
  final String brandName;
  final double quantityAvailable;
  final double prize;
  final String photo;

  ProductModel({
    required this.productId,
    required this.productCode,
    required this.justName,
    required this.productName,
    required this.brandName,
    required this.quantityAvailable,
    required this.prize,
    this.photo = '',
  });

  String rutaFisicaImage() {
    if (photo != '') {
      return "$productImagePath$productCode.png";
    }
    return '';
  }

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
    productId: int.parse(json["productoId"].toString()),
    productCode: json["codigo"] ?? '',
    justName: json["solo_Nombre"] ?? '',
    productName: json["nombreProducto"] ?? '',
    brandName: json["marca"] ?? '',
    quantityAvailable: double.parse(json["existencia"].toString()),
    prize: double.parse(json["valorLista"].toString()),
    photo: json["rutaImagen"] ?? '',
  );

  factory ProductModel.fromEngJson(Map<String, dynamic> json) => ProductModel(
    productId: int.parse(json["id"].toString()),
    productCode: json["code"] ?? '',
    justName: json["name"] ?? '',
    productName: (json["code"] ?? '') + ' - ' + (json["name"] ?? ''),
    brandName: json["markName"] ?? '',
    quantityAvailable: double.parse(json["available"].toString()),
    prize: double.parse(json["unitPrice"].toString()),
    photo: json["imageUrl"] ?? '',
  );

  Map<String, dynamic> toJson() => {
    'id': productId,
    'productCode': productCode,
    'name': justName,
    'productName': productName,
    'brandName': brandName,
    'quantityAvailable': quantityAvailable,
    'prize': prize,
    'photo': photo,
  };
}
