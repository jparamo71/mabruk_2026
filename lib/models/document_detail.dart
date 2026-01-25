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

  factory DocumentDetailModel.fromJson(
    Map<String, dynamic> json,
    int lineNumber,
  ) => DocumentDetailModel(
    detailId: int.parse(json["Detalle_PedidoID"].toString()),
    product: ProductModel.fromJson(json["Producto"]),
    quantity: double.parse(json["Cantidad"].toString()),
    unitPrize: double.parse(json["Valor_Unitario"].toString()),
    total: double.parse(json["Valor_Total"].toString()),
    lineNumber: lineNumber,
  );
}
