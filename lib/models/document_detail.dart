import 'package:mabruk_2026/models/product_model.dart';

class DocumentDetailModel {
  final int detailId;
  final ProductModel product;
  final double quantity;
  final double unitPrize;
  final double total;
  final int lineNumber;

  DocumentDetailModel({
    required this.detailId,
    required this.product,
    required this.quantity,
    required this.unitPrize,
    required this.total,
    required this.lineNumber,
  });

  /// Serializa json to DocumentDetailModel object
  factory DocumentDetailModel.fromJson(
    Map<String, dynamic> json,
    int lineNumber,
  ) {
    ProductModel product = ProductModel(
        productId: int.parse(json['productId'].toString()),
        productCode: json['productCode'].toString(),
        justName: '',
        productName: json['productName'].toString(),
        brandName: json['brandName'].toString(),
        quantityAvailable: double.parse(json['quantityAvailable'].toString()),
        prize: double.parse(json['unitPrize'].toString()),
        barcharCode: '',
        upcCode: '',
        unitsByPackage: 0);
    return DocumentDetailModel(
      detailId: int.parse(json["detailId"].toString()),
      product: product,
      quantity: double.parse(json["quantity"].toString()),
      unitPrize: double.parse(json["unitPrize"].toString()),
      total: double.parse(json["total"].toString()),
      lineNumber: 1,
    );
  } 
}
