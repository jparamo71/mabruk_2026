import 'package:mabruk_2026/utils/globals.dart';

class ProductModel {
  final int productId;
  final String productCode;
  final String justName;
  final String productName;
  final String brandName;
  final double quantityAvailable;
  final double price;
  final String photo;
  String barcharCode;
  String upcCode;
  int unitsByPackage;

  ProductModel({
    required this.productId,
    required this.productCode,
    required this.justName,
    required this.productName,
    required this.brandName,
    required this.quantityAvailable,
    required this.price,
    required this.barcharCode,
    required this.upcCode,
    required this.unitsByPackage,
    this.photo = '',
  });

  factory ProductModel.empty() => ProductModel(
    productId: 0,
    productCode: '',
    justName: '',
    productName: '',
    brandName: '',
    quantityAvailable: 0,
    price: 0,
    barcharCode: '',
    upcCode: '',
    unitsByPackage: 0,
    photo: '',
  );

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
    price: double.parse(json["valorLista"].toString()),
    photo: json["rutaImagen"] ?? '',
    barcharCode: json["codigoBarra"] ?? '',
    upcCode: json["codigoUPC"] ?? '',
    unitsByPackage: int.parse(json['unidadesPorPaquete'] ?? '0'),
  );

  factory ProductModel.fromEngJson(Map<String, dynamic> json) => ProductModel(
    productId: int.parse(json["id"].toString()),
    productCode: json["code"] ?? '',
    justName: json["name"] ?? '',
    productName: "${json["code"] ?? ''} - ${json["name"] ?? ''}",
    brandName: json["markName"] ?? '',
    quantityAvailable: double.parse(json["available"].toString()),
    price: double.parse(json["unitPrice"].toString()),
    photo: json["imageUrl"] ?? '',
    barcharCode: json["barcharCode"] ?? '',
    upcCode: json["upcCode"] ?? '',
    unitsByPackage: int.parse(json['unitsByPackage'] ?? '0'),
  );

  Map<String, dynamic> toJson() => {
    'id': productId,
    'productCode': productCode,
    'name': justName,
    'productName': productName,
    'brandName': brandName,
    'quantityAvailable': quantityAvailable,
    'prize': price,
    'photo': photo,
    'barcharCode': barcharCode,
    'upcCode': upcCode,
    'unitsByPackage': unitsByPackage,
  };
}
