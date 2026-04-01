import 'dart:convert';
import 'dart:typed_data';

import 'package:mabruk_2026/helpers/http_custom.dart';
import 'package:mabruk_2026/models/brand_model.dart';
import 'package:mabruk_2026/models/customer_model.dart';
import 'package:mabruk_2026/models/document_model.dart';
import 'package:mabruk_2026/models/import_detail_model.dart';
import 'package:mabruk_2026/models/import_model.dart';
import 'package:mabruk_2026/models/physical_tracking.dart';
import 'package:mabruk_2026/models/physical_tracking_detail_model.dart';
import 'package:mabruk_2026/models/product_model.dart';
import 'package:mabruk_2026/models/response_dto.dart';
import 'package:mabruk_2026/utils/globals.dart';

class MabrukService {
  /// Listado de productos según filtros
  Future<List<ProductModel>> getProducts(
    String filter,
    int brandId,
    bool onlyAvailable,
    int customerId,
    bool isActive,
  ) async {
    HttpCustom httpClient = HttpCustom();
    Map<String, dynamic> params = {
      'brandId': brandId.toString(),
      'stockAvailable': onlyAvailable.toString(),
      'searchText': filter,
    };
    var url = Uri.https(urlBase, "/api/product/GetProductByBrand", params);
    var headers = {'content-type': 'application/json'};
    final response = await httpClient.get(url, headers: headers);
    final List<dynamic> decodedData = jsonDecode(response.body);
    return decodedData
        .map((jsonItem) => ProductModel.fromJson(jsonItem))
        .toList();
  }

  /// Listado de marcas
  Future<List<BrandModel>> getBrands() async {
    HttpCustom httpClient = HttpCustom();
    var url = Uri.https(urlBase, "/api/mark");
    Map<String, String> header = {
      'content-type': 'application/json',
      'Authorization': 'Bearer $userToken',
    };
    final response = await httpClient.get(url, headers: header);
    final List<dynamic> decodedData = jsonDecode(response.body);
    return decodedData
        .map((jsonItem) => BrandModel.fromJson(jsonItem))
        .toList();
  }

  /// Listado de documentos filtrados por usuario (email)
  Future<List<DocumentModel>> getDocuments(String userEmail, int type) async {
    HttpCustom httpClient = HttpCustom();
    Map<String, dynamic> params = {'email': userEmail, 'type': type.toString()};
    var url = Uri.https(urlBase, "/api/quotes/documents", params);
    Map<String, String> header = {
      'content-type': 'application/json',
      'Authorization': 'Bearer $userToken',
    };
    final response = await httpClient.get(url, headers: header);
    final List<dynamic> decodedData = jsonDecode(response.body);
    final values = decodedData
        .map((jsonItem) => DocumentModel.fromJsonItemList(jsonItem))
        .toList();
    return values;
  }

  /// Datos completos de un documento (Pedido o cotización)
  Future<DocumentModel?> getDocument(int id) async {
    HttpCustom httpClient = HttpCustom();
    Map<String, dynamic> params = {'id': id.toString()};
    var url = Uri.https(urlBase, "/api/quotes/document", params);
    Map<String, String> header = {
      'content-type': 'application/json',
      'Authorization': 'Bearer $userToken',
    };
    final response = await httpClient.get(url, headers: header);
    print(response.body);
    final jsonData = jsonDecode(response.body);

    return DocumentModel.fromJson(jsonData);
  }

  /// Crea una cotización con la selección de un cliente
  Future<DocumentModel?> createDocument(
    int customerId,
    String email,
    bool isQuote,
  ) async {
    HttpCustom hc = HttpCustom();
    Map<String, String> params = <String, String>{
      "customerId": customerId.toString(),
      "sellerEmail": email,
      "isQuote": isQuote.toString(),
    };
    var url = Uri.https(urlBase, "/api/quotes/create", params);
    Map<String, String> header = {
      'content-type': 'application/json',
      'Authorization': 'Bearer $userToken',
    };
    var response = await hc.post(url, headers: header);
    final jsonData = jsonDecode(response.body);
    var responseDto = ResponseDto.fromJson(jsonData);
    if (responseDto.statusCode == 200) {
      final value = DocumentModel.fromJson(responseDto.content);
      return value;
    }
    return null;
  }

  /// Confirmar una cotización (La convierte en pedido)
  Future<bool> confirmQuote(int id, String email) async {
    HttpCustom hc = HttpCustom();
    Map<String, String> params = <String, String>{
      "id": id.toString(),
      "email": email,
    };
    var url = Uri.https(urlBase, "/api/quotes/confirm", params);
    Map<String, String> header = {
      'content-type': 'application/json',
      'Authorization': 'Bearer $userToken',
    };
    var response = await hc.post(url, headers: header);
    final respJson = jsonDecode(response.body);
    return (int.parse(respJson["value"].toString()) == 0);
  }

  Future<bool> addDocumentDetail(
    int detailId,
    int documentId,
    int productId,
    double quantity,
    double unitPrice,
    double totalPrice,
  ) async {
    HttpCustom hc = HttpCustom();
    Map<String, dynamic> params = <String, dynamic>{
      "detailId": detailId,
      "documentId": documentId,
      "productId": productId,
      "quantity": quantity,
      "unitPrice": unitPrice,
      "totalPrice": totalPrice,
    };
    String jsonBody = jsonEncode(params);
    var url = Uri.https(urlBase, "/api/quotes/add-product");
    Map<String, String> header = {
      'Authorization': 'Bearer $userToken',
      'Content-Type': 'application/json; charset=UTF-8',
    };
    var response = await hc.put(url, headers: header, body: jsonBody);
    final respJson = jsonDecode(response.body);
    return int.parse(respJson.toString()) == 0;
  }

  /// Delete a product in document
  Future<bool> deleteDetail(int id) async {
    HttpCustom hc = HttpCustom();
    Map<String, String> params = <String, String>{"id": id.toString()};
    var url = Uri.https(urlBase, "/api/quotes/delete-product/${id}");
    Map<String, String> header = {
      'content-type': 'application/json',
      'Authorization': 'Bearer $userToken',
    };
    var response = await hc.delete(url, headers: header);
    final respJson = jsonDecode(response.body);
    return int.parse(respJson.toString()) == 0;
  }

  /// Enviar por correo en PDF el documento, ya se cotización o pedido
  Future<bool> sendEmail(int id, String email) async {
    HttpCustom hc = HttpCustom();
    Map<String, String> params = <String, String>{
      "PedidoId": id.toString(),
      "Email": email,
    };
    var url = Uri.https(urlBase, "/api/tools/send-email", params);
    Map<String, String> header = {
      'content-type': 'application/json',
      'Authorization': 'Bearer $userToken',
    };
    var response = await hc.post(url, headers: header);
    final respJson = jsonDecode(response.body);
    return true;
  }

  /// Eliminar documento
  Future<bool> deleteDocument(int id, String email) async {
    HttpCustom hc = HttpCustom();
    Map<String, String> params = <String, String>{
      "PedidoId": id.toString(),
      "Email": email,
    };
    var url = Uri.https(urlBase, "/api/tools/delete-document", params);
    Map<String, String> header = {
      'content-type': 'application/json',
      'Authorization': 'Bearer $userToken',
    };
    var response = await hc.delete(url, headers: header);
    final respJson = jsonDecode(response.body);
    return true;
  }

  /// Listados de tomas físicas
  Future<List<PhysicalTrackingModel>> getTrackingList(
    int page,
    int skip,
    int take,
  ) async {
    HttpCustom cc = HttpCustom();
    Map<String, String> params = <String, String>{
      "skip": skip.toString(),
      "take": take.toString(),
    };
    var url = Uri.https(urlBase, "/api/inventory/paged", params);
    Map<String, String> header = {
      'content-type': 'application/json',
      'Authorization': 'Bearer $userToken',
    };
    var response = await cc.get(url, headers: header);
    final List<dynamic> decodedData = jsonDecode(response.body);
    return decodedData
        .map((jsonItem) => PhysicalTrackingModel.fromJson(jsonItem))
        .toList();
  }

  /// Listado de importaciones
  Future<List<ImportModel>> getImportList() async {
    HttpCustom cc = HttpCustom();
    Map<String, String> params = <String, String>{};
    var url = Uri.https(urlBase, "/api/imports", params);
    Map<String, String> header = {
      'content-type': 'application/json',
      'Authorization': 'Bearer $userToken',
    };
    var response = await cc.get(url, headers: header);
    final List<dynamic> decodedData = jsonDecode(response.body);
    return decodedData
        .map((jsonItem) => ImportModel.fromJson(jsonItem))
        .toList();
  }

  /// Listado completo de un documento de importación
  Future<ImportModel> getImportFullInfo(int id) async {
    HttpCustom cc = HttpCustom();
    Map<String, String> params = <String, String>{};
    var url = Uri.https(urlBase, "/api/imports/$id", params);
    Map<String, String> header = {
      'content-type': 'application/json',
      'Authorization': 'Bearer $userToken',
    };
    var response = await cc.get(url, headers: header);
    final respJson = jsonDecode(response.body);
    ImportModel imp = ImportModel.fromJson(respJson);
    for (var item in respJson["details"]) {
      ImportDetailModel det = ImportDetailModel.fromJson(item);
      imp.detail.add(det);
    }
    return imp;
  }

  /// Actualización de conteo importaciones
  Future<bool> updateImportedProduct(ImportDetailModel detail) async {
    var jsonToSend = detail.toJsonPhysical();
    HttpCustom hc = HttpCustom();
    var url = Uri.https(urlBase, "/api/imports");
    Map<String, String> header = {
      'content-type': 'application/json',
      'Authorization': 'Bearer $userToken',
    };
    var response = await hc.put(
      url,
      headers: header,
      body: jsonEncode(jsonToSend),
    );
    return (response.body == '');
  }

  /// Actualización de la toma física de un producto
  /// que se corresponda con una toma física
  Future<bool> updatePhysicalProduct(PhysicalTrackingDetailModel item) async {
    var jsonToSend = item.toJson();
    HttpCustom hc = HttpCustom();
    var url = Uri.https(urlBase, "/api/inventory/updateproduct");
    Map<String, String> header = {
      'content-type': 'application/json',
      'Authorization': 'Bearer $userToken',
    };
    var response = await hc.post(
      url,
      headers: header,
      body: jsonEncode(jsonToSend),
    );
    return (response.body == '');
  }

  Future<bool> updateNotes(int id, String note) async {
    HttpCustom hc = HttpCustom();
    var url = Uri.https(urlBase, "/api/quotes/update-note");
    Map<String, String> header = {
      'content-type': 'application/json',
      'Authorization': 'Bearer $userToken',
    };
    Map<String, dynamic> data = {
      "id": id,
      "note": note
    };
    var jsonToSend = jsonEncode(data);
    print(jsonToSend);
    var response = await hc.put(
      url,
      headers: header,
      body: jsonToSend
    );
    return (response.body == '');
  }




  /*


if (imageByte != null) {
              var bytes =
                  await imageByte.toByteData(format: ImageByteFormat.png);

              if (bytes != null) {
                var uploaded =
                    await deliver.uploadImage(bytes.buffer.asUint8List());

                if (uploaded) {
                  print("La imagen se cargó correctamente");
                }
              }
            }


  */

  /// Actualizar la foto de un producto
  Future<bool> uploadProductPhoto(Uint8List data) async {
    var body = {
      "fileName": "Signature.png",
      "fileContent": base64Encode(data),
      "guidNumber": "", // packageId.toInt().toString()
    };
    //UploadFile(fileName: "Signature.png", fileContent: base64Encode(data));

    Map<String, String> header = {
      'content-type': 'application/json',
      'Authorization': 'Bearer $userToken',
    };
    var url = Uri.https(urlBase, "/api/product/uploadimage");

    HttpCustom hc = HttpCustom();
    await hc.post(url, headers: header, body: json.encode(body));

    return true;
  }

  /// Listado de clientes según filtros
  Future<List<CustomerModel>> getCustomers(String filter) async {
    HttpCustom httpClient = HttpCustom();
    Map<String, dynamic> params = {'filter': filter};
    var url = Uri.https(urlBase, "/api/customer", params);
    var headers = {'content-type': 'application/json'};
    final response = await httpClient.get(url, headers: headers);
    final List<dynamic> decodedData = jsonDecode(response.body);
    return decodedData
        .map((jsonItem) => CustomerModel.fromJson(jsonItem))
        .toList();
  }
}
