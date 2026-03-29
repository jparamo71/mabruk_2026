import 'package:flutter/material.dart';
import 'package:mabruk_2026/models/brand_model.dart';
import 'package:mabruk_2026/models/document_model.dart';
import 'package:mabruk_2026/models/customer_model.dart';
import 'package:mabruk_2026/models/import_detail_model.dart';
import 'package:mabruk_2026/models/import_model.dart';
import 'package:mabruk_2026/models/physical_tracking.dart';
import 'package:mabruk_2026/models/physical_tracking_detail_model.dart';
import 'package:mabruk_2026/models/product_model.dart';
import 'package:mabruk_2026/services/mabruk_service.dart';

class MabrukProvider extends ChangeNotifier {
  bool isLoading = false;
  List<ProductModel> productsModel = [];
  List<BrandModel> brandsModel = [];
  List<DocumentModel> documentsModel = [];
  List<PhysicalTrackingModel> inventoriesModel = [];
  List<ImportModel> importsModel = [];
  List<CustomerModel> customersModel = [];
  DocumentModel? document;

  // To save state of BrandModel selected
  BrandModel? _selectedValue;
  BrandModel? get selectedValue => _selectedValue;
  void setSelectedValue(BrandModel? newValue) async {
    _selectedValue = newValue;

    productsModel = await httpService.getProducts(
      '',
      (_selectedValue?.id.toInt() ?? 0),
      false,
      0,
      true,
    );
    notifyListeners();
  }

  ImportModel? _selectedImport;
  ImportModel? get selectedImport => _selectedImport;
  void setSelectedImport(ImportModel? newValue) async {
    _selectedImport = newValue;
    notifyListeners();
  }

  PhysicalTrackingModel? _selectedPhysicalTracking;
  PhysicalTrackingModel? get selectedPhysicalTracking =>
      _selectedPhysicalTracking;
  void setSelectedPhysicalTracking(PhysicalTrackingModel? newValue) async {
    _selectedPhysicalTracking = newValue;
    notifyListeners();
  }

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
    isLoading = true;
    //notifyListeners();

    try {
      brandsModel = await httpService.getBrands();
    } catch (e) {
      // TODO
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  void getBrandsAndProducts() async {
    isLoading = true;
    //notifyListeners();

    try {
      brandsModel = await httpService.getBrands();
      if (brandsModel.isNotEmpty) {
        int firstBrandId = brandsModel.first.id;
        productsModel = await httpService.getProducts(
          '',
          firstBrandId,
          true,
          0,
          true,
        );
      }
    } catch (e) {
      //print(e);
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  void getDocuments(String userEmail, int type) async {
    documentsModel = await httpService.getDocuments(userEmail, type);
    notifyListeners();
  }

  void getDocument(int id) async {
    document = await httpService.getDocument(id);
    notifyListeners();
  }

  void getTrackingInventories(int page, int skip, int take) async {
    inventoriesModel = await httpService.getTrackingList(page, skip, take);
    notifyListeners();
  }

  void getImports() async {
    importsModel = await httpService.getImportList();
  }

  void getImportInfo(int id) async {
    _selectedImport = await httpService.getImportFullInfo(id);
    notifyListeners();
  }

  void updateImportProduct(ImportDetailModel detail) async {
    await httpService.updateImportedProduct(detail);
    notifyListeners();
  }

  void updateTrackingProduct(PhysicalTrackingDetailModel detail) async {
    await httpService.updatePhysicalProduct(detail);
    notifyListeners();
  }


  void getCustomers(String filter) async {
    isLoading = true;
    try {
      customersModel = await httpService.getCustomers(filter);
      print("Cantidad de clientes: ${customersModel.length}");
    } catch (e) {
      // TODO
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }


  void createQuote(int customerId, String sellerEmail, bool isQuote) async {
    try {
      var respuesta = await httpService.createDocument(customerId, sellerEmail, isQuote);
      /*if (respuesta) {

      }*/
      notifyListeners();
    }catch (e) {
      // TODO
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

}
