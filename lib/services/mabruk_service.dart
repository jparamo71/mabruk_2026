import 'dart:convert';

import 'package:mabruk_2026/helpers/http_custom.dart';
import 'package:mabruk_2026/models/brand_model.dart';
import 'package:mabruk_2026/models/docment_model.dart';
import 'package:mabruk_2026/models/import_model.dart';
import 'package:mabruk_2026/models/physical_tracking.dart';
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

  Future<List<DocumentModel>> getDocuments(String userEmail, int type) async {
    HttpCustom httpClient = HttpCustom();
    Map<String, dynamic> params = {'email': userEmail, 'type': type.toString()};
    var url = Uri.https(urlBase, "/api/quotes/pedidos", params);
    Map<String, String> header = {
      'content-type': 'application/json',
      'Authorization': 'Bearer $userToken',
    };
    final response = await httpClient.get(url, headers: header);
    final List<dynamic> decodedData = jsonDecode(response.body);
    return decodedData
        .map((jsonItem) => DocumentModel.fromJsonItemList(jsonItem))
        .toList();
  }

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

}
