import 'dart:developer';
import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mabruk_2026/models/brand_model.dart';
import 'package:mabruk_2026/models/product_model.dart';
import 'package:mabruk_2026/providers/mabruk_provider.dart';
import 'package:mabruk_2026/utils/palette_theme.dart';
import 'package:mabruk_2026/pages/products/item_product_list.dart';
import 'package:provider/provider.dart';

class ProductCatalog extends StatefulWidget {
  final int customerId;
  const ProductCatalog({super.key, required this.customerId});

  @override
  State<ProductCatalog> createState() => _ProductCatalogState();
}

class _ProductCatalogState extends State<ProductCatalog> {
  // Take a photo vars
  final ImagePicker _picker = ImagePicker();
  XFile? _imageFile;
  dynamic pickImageError;

  final List<ProductModel> _productsResult = [];
  final List<BrandModel> _brandList = [];
  //BrandModel _selectedBrand = BrandModel(id: 0, name: 'TODAS');
  TextEditingController controller = TextEditingController(text: '');

  @override
  void initState() {
    Provider.of<MabrukProvider>(context, listen: false).getBrands();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // brands dropdown items
    /*var items = _brandList.map((item) {
      return DropdownMenuItem<BrandModel>(
        child: Text(item.brandName),
        value: item,
      );
    }).toList();

    // if list is empty, create a dummy item
    if (items.isEmpty) {
      items = [
        DropdownMenuItem(
          child: Text(_selectedBrand.brandName),
          value: _selectedBrand,
        )
      ];
    }*/

    //
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.mainColor,
        title: const Text('PRODUCTOS'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.only(top: 10.0, left: 10.0),
              child: ButtonTheme(
                alignedDropdown: true,
                child: SizedBox(
                  height: 30,
                  width: 200,
                  child: Consumer<MabrukProvider>(
                    builder: (context, value, child) {
                      if (value.brandsModel.isNotEmpty) {
                        return DropdownButton<BrandModel>(
                          items: value.brandsModel.map((item) {
                            return DropdownMenuItem<BrandModel>(
                              value: item,
                              child: Text(item.name),
                            );
                          }).toList(),
                          onChanged: (new_value) {
                            value.setSelectedValue(new_value);
                          },
                          value: value.selectedValue,
                          icon: const Icon(Icons.arrow_drop_down),
                          elevation: 16,
                          underline: SizedBox(),
                          borderRadius: BorderRadius.circular(10),
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF395477),
                          ),
                        );
                      }
                      return const Center(child: Text("xxxx"));
                    },
                  ),
                ),
              ),
            ),
            SizedBox(height: 5.0),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CupertinoSearchTextField(
                placeholder: "Buscar...",
                controller: controller,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(color: Color(0xFFC9C9C9), spreadRadius: 1),
                  ],
                ),
                onChanged: (value) {
                  //fetchProducts();
                },
              ),
            ),
            SizedBox(height: 10.0),
            Consumer<MabrukProvider>(
              builder: (context, value, child) {
                return (value.productsModel.isNotEmpty)
                    ? Expanded(
                        child: ListView.builder(
                          itemCount: value.productsModel.length,
                          itemBuilder: (context, index) {
                            ProductModel currentProduct =
                                value.productsModel[index];
                            log(
                              "Producto $index, de nombre ${currentProduct.productName}",
                            );
                            return ItemProductList(
                              productCode: currentProduct.productCode,
                              productName: currentProduct.productName,
                              productMark: currentProduct.barcharCode,
                              available: currentProduct.quantityAvailable,
                              prize: currentProduct.prize,
                              onSelect: () {},
                              onPicture: () {},
                            );
                          },
                        ),
                      )
                    : Container();
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 1,
        selectedIconTheme: IconThemeData(color: AppColors.mainColor),
        selectedItemColor: AppColors.mainColor,
        backgroundColor: AppColors.mainBackGround,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Pedidos'),
          BottomNavigationBarItem(
            icon: Icon(Icons.book_outlined),
            label: 'Productos',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            label: 'Cotizaciones',
          ),
        ],
        onTap: (int index) {
          if (index == 0) {
            Navigator.of(context).pushReplacementNamed("/documents");
          } else if (index == 2) {
            Navigator.of(context).pushReplacementNamed("/quotes");
          }
        },
      ),
    );
  }

  /*void fetchBrands() async {
    getBrands().then((response) {
      setState(() {
        _brandList = response;
        _selectedBrand = _brandList[0];
      });
    });
  }

  void fetchProducts() async {
    if (widget.parameters.customerId > 0) {
      getProductsByCustomer(widget.parameters.customerId, controller.text,
              _selectedBrand.brandId, widget.parameters.onlyAvailable)
          .then((response) {
        setState(() {
          _productsResult = response;
        });
      });
    } else {
      ProductModel.getProducts(controller.text, _selectedBrand.brandId,
              widget.parameters.onlyAvailable, 0, true)
          /*getProducts(controller.text, _selectedBrand.brandId,
              widget.parameters.onlyAvailable)*/
          .then((response) {
        setState(() {
          _productsResult = response;
        });
      });
    }
  }
*/
  Future<void> _takePhoto(int productId) async {
    double maxWidth = 400;
    double maxHeight = 400;
    int quality = 100;
    try {
      final XFile? pickedFile = await _picker.pickImage(
        source: ImageSource.camera,
        maxWidth: maxWidth,
        maxHeight: maxHeight,
        imageQuality: quality,
      );
      setState(() {
        _imageFile = pickedFile;
        //_upload(productId);
      });
    } catch (e) {
      setState(() {
        pickImageError = e;
      });
    }
  }

  /*void _upload(int productId) {
    uploadImage(_imageFile!.path.toString(), productId).then((value) {
      if (value.isSuccessful) {
        ScaffoldMessenger.of(context)
          ..removeCurrentSnackBar()
          ..showSnackBar(SnackBar(content: Text('¡Imagen actuailzada!')));
      }
    });
  }*/
  /*
  Future<void> _showProductInformation(
    BuildContext context,
    ProductModel product,
  ) async {
    final _formKey = GlobalKey<FormState>();
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) => AlertDialog(
            content: Form(
              key: _formKey,
              child: Container(
                width: 400,
                child: SingleChildScrollView(
                  child: ListBody(
                    children: [
                      NormalText(text: product.productCode, bold: true),
                      SizedBox(height: 10.0),
                      NormalText(text: product.justName.trim(), bold: false, overflow: TextOverflow.visible,),
                      SizedBox(height: 10.0),
                      NormalText(text: product.brandName, bold: false, overflow: TextOverflow.visible,),
                      SizedBox(height: 10.0),
                      NormalText(text: "Q. " + product.prize.toString() + "c/u", bold: false, overflow: TextOverflow.visible,),
                      SizedBox(height: 10.0),
                      NormalText(text: product.quantityAvailable.toString() + " unidades disponibles", bold: false, overflow: TextOverflow.visible,),
                      SizedBox(height: 10.0),                      
                    ],
                  ),
                ),
              ),
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.pop(context, 'No'),
                child: const Text('Cerrar'),
              ),
            ],
          ),
        );
      },
    );
  }*/
}
