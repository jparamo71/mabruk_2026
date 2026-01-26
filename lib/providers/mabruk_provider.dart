import 'package:flutter/material.dart';
import 'package:mabruk_2026/models/brand_model.dart';
import 'package:mabruk_2026/models/docment_model.dart';
import 'package:mabruk_2026/models/import_model.dart';
import 'package:mabruk_2026/models/physical_tracking.dart';
import 'package:mabruk_2026/models/product_model.dart';
import 'package:mabruk_2026/services/mabruk_service.dart';

class MabrukProvider extends ChangeNotifier {
  List<ProductModel> productsModel = [];
  List<BrandModel> brandsModel = [];
  List<DocumentModel> documentsModel = [];
  List<PhysicalTrackingModel> inventoriesModel = [];
  List<ImportModel> importsModel = [];

  MabrukService httpService = MabrukService();

  void getProductsData(
    String filter,
    int brandId,
    bool onlyAvailable,
    int customerId,
    bool isActive,
  ) async {
    productsModel = await httpService.getProducts(
      filter,
      brandId,
      onlyAvailable,
      customerId,
      isActive,
    );
    notifyListeners();
  }

  void getBrands() async {
    brandsModel = await httpService.getBrands();
    notifyListeners();
  }

  void getDocuments(String userEmail, int type) async {
    documentsModel = await httpService.getDocuments(userEmail, type);
    notifyListeners();
  }

  void getTrackingInventories(int page, int skip, int take) async {
    inventoriesModel = await httpService.getTrackingList(page, skip, take);
    notifyListeners();
  }

  void getImports() async {
    importsModel = await httpService.getImportList();
  }
}
