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
  final UserModel seller;
  String? note;
  List<DocumentDetailModel> details = [];

  DocumentModel({
    required this.documentId,
    required this.dateStr,
    required this.total,
    required this.isQuote,
    required this.customer,
    required this.seller,
    required this.note,
    required this.deliveryAddress,
    this.statusDocumentId = 0,
    this.statusDocument = "",
  });


  /// Serialize json to DocumentModel object
  ///
  /// Only document's header data
  factory DocumentModel.fromJsonItemList(Map<String, dynamic> json) {
    CustomerModel customer = CustomerModel(
        customerId: int.parse(json["customerId"].toString()),
        customerName: json["customerName"].toString(),
        nit: json["customerNit"].toString(),
        address: json["addressDelivery"].toString(),
        phoneNumber: "",
        email: "",
        mainContact: "",
        phoneContact: "");
    UserModel seller = UserModel(
        userId: 0,
        email: json["email"].toString(),
        fullName: json["sellerName"].toString(),
        allowUploadImage: true,);
    return DocumentModel(
        documentId: int.parse(json["id"].toString()),
        dateStr: json["orderDateStr"].toString(),
        total: double.parse(json['totalAmount'].toString()),
        isQuote: bool.parse(json['isQuoted'].toString()),
        customer: customer,
        seller: seller,
        note: json['note'].toString(),
        deliveryAddress: json['addressDelivery'].toString(),
        statusDocumentId: int.parse(json['orderStateId'].toString()),
        statusDocument: json['orderStateName'].toString(),
    );
  }


  /// Serialize json to DocumentModel object
  ///
  /// Full document data
  factory DocumentModel.fromJson(Map<String, dynamic> json) {
    // Details
    Iterable list = json['details'];
    var lst = list.toList();

    var details = lst
        .asMap()
        .map(
          (i, element) => MapEntry(i, DocumentDetailModel.fromJson(element, i)),
        )
        .values
        .toList();

    CustomerModel customer = CustomerModel(
        customerId: int.parse(json["customerId"].toString()),
        customerName: json["customerName"].toString(),
        nit: json["customerNit"].toString(),
        address: json["addressDelivery"].toString(),
        phoneNumber: "",
        email: "",
        mainContact: "",
        phoneContact: "");
    UserModel seller = UserModel(
      userId: 0,
      email: json["email"].toString(),
      fullName: json["sellerName"].toString(),
      allowUploadImage: true,);
    var document = DocumentModel(
      documentId: int.parse(json["id"].toString()),
      dateStr: json["orderDateStr"].toString(),
      total: double.parse(json['totalAmount'].toString()),
      isQuote: bool.parse(json['isQuoted'].toString()),
      customer: customer,
      seller: seller,
      note: json['note'] == null ? "" : json['note'].toString(),
      deliveryAddress: json['addressDelivery'].toString(),
      statusDocumentId: int.parse(json['orderStateId'].toString()),
      statusDocument: json['orderStateName'].toString(),
    );

    document.details = details;

    return document;
  }
}
