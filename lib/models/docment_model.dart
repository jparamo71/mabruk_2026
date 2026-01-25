import 'package:mabruk_2026/models/customer_model.dart';
import 'package:mabruk_2026/models/document_detail.dart';
import 'package:mabruk_2026/models/user_model.dart';

class DocumentModel {
  int documentId;
  String dateStr;
  double total;
  bool isQuote;
  CustomerModel customer;
  int? statusDocumentId;
  String? statusDocument;
  String? deliveryAddress;
  List<DocumentDetailModel> details = [];
  final UserModel seller;
  String? notes;

  DocumentModel({
    required this.documentId,
    required this.dateStr,
    required this.total,
    required this.isQuote,
    required this.customer,
    required this.seller,
    required this.notes,
    required this.deliveryAddress,
    this.statusDocumentId = 0,
    this.statusDocument = "",
  });

  factory DocumentModel.fromJsonItemList(Map<String, dynamic> json) =>
      DocumentModel(
        documentId: int.parse(json["id"] ?? "0"),
        dateStr: json["orderDateStr"] ?? "",
        total: double.parse(json['TotalAmount'] ?? "0"),
        isQuote: bool.parse(json['IsQuoted'] ?? 'false'),
        customer: json["customerName"] ?? '',
        seller: json['sellerName'] ?? '',
        notes: json['notes'] ?? '',
        deliveryAddress: json['addressDelivery'] ?? '',
        statusDocumentId: int.parse(json['orderStateId'] ?? ''),
        statusDocument: json['orderStateName'] ?? ''
      );

  factory DocumentModel.fromJson(Map<String, dynamic> json) {
    // Details
    Iterable list = json['Detalle'];
    var lst = list.toList();

    var details = lst
        .asMap()
        .map(
          (i, element) => MapEntry(i, DocumentDetailModel.fromJson(element, i)),
        )
        .values
        .toList();

    // Document detail
    /*
    details = [];
    (json['Detalle'] as List).forEach((e) {
      details.add(DocumentDetailModel.fromJson(e, 1));
    });*/

    // Customer associated to document
    CustomerModel customer = CustomerModel.fromJson(json["Cliente"]);

    // Seller
    UserModel seller = UserModel.fromJson(json["Vendedor"]);

    ////print(json["Estado_Pedido"]);

    // General data document
    DocumentModel document = DocumentModel(
      documentId: int.parse(json["PedidoID"].toString()),
      dateStr: json["Fecha_Str"] ?? '',
      total: double.parse(json["Valor_Total"].toString()),
      isQuote: ((json["Es_Cotizacion"] ?? 0) != 0),
      customer: customer,
      seller: seller,
      notes: json["Observaciones"] ?? '',
      deliveryAddress: json["DireccionEntrega"] ?? '',
      statusDocumentId: int.parse(
        json["Estado_Pedido"]["Estado_PedidoID"].toString(),
      ),
      statusDocument: json["Estado_Pedido"]["Nombre_Estado_Pedido"] ?? '',
    );

    document.details = details;

    return document;
  }
}
