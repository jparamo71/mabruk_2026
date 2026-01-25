import 'dart:convert';

import 'package:mabruk_2026/helpers/http_custom.dart';
import 'package:mabruk_2026/models/brand_model.dart';
import 'package:mabruk_2026/models/docment_model.dart';
import 'package:mabruk_2026/models/product_model.dart';
import 'package:mabruk_2026/utils/globals.dart';

class MabrukService {

  Future<List<ProductModel>> getProducts(
    String filter,
    int brandId,
    bool onlyAvailable,
    int customerId,
    bool isActive,
  ) async {
    HttpCustom httpClient = HttpCustom();
    Map<String, dynamic> parameters = {
      'brandId': brandId.toString(),
      'stockAvailable': onlyAvailable.toString(),
      'searchText': filter
    };
    var url = Uri.https(urlBase, "/api/product/GetProductByBrand", parameters);
    var headers = {'content-type': 'application/json'};
    final response = await httpClient.get(url, headers: headers);
    final List<dynamic> decodedData = jsonDecode(response.body);
    return decodedData
        .map((jsonItem) => ProductModel.fromJson(jsonItem))
        .toList();
  }



  Future<List<BrandModel>> getBrands() async {
    HttpCustom httpClient = HttpCustom();
    var url = Uri.https(urlBase, "/api/mark");
    Map<String, String> header = {
      'content-type': 'application/json',
      'Authorization': 'Bearer $userToken',
    };
    final response = await httpClient.get(url, headers: header);
    final List<dynamic> decodedData = jsonDecode(response.body);
    final List<BrandModel> brands =
        decodedData.map((jsonItem) => BrandModel.fromJson(jsonItem)).toList();

    return brands;
  }


  Future<List<DocumentModel>> getDocuments(String userEmail, int type) async {
    HttpCustom httpClient = HttpCustom();
    Map<String, dynamic> parameters = {
      'email': userEmail,
      'type': type.toString(),
    };
    var url = Uri.https(urlBase, "/api/quotes/pedidos", parameters);
    Map<String, String> header = {
      'content-type': 'application/json',
      'Authorization': 'Bearer $userToken',
    };
    final response = await httpClient.get(url, headers: header);
    final List<dynamic> decodedData = jsonDecode(response.body);
    final List<DocumentModel> documents =
        decodedData.map((jsonItem) => DocumentModel.fromJsonItemList(jsonItem)).toList();
    return documents;
  }
}