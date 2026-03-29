import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mabruk_2026/models/brand_model.dart';
import 'package:mabruk_2026/providers/mabruk_provider.dart';
import 'package:mabruk_2026/utils/palette_theme.dart';
import 'package:mabruk_2026/pages/products/list_product.dart';
import 'package:mabruk_2026/utils/styles/title_text.dart';
import 'package:provider/provider.dart';

class ProductList extends StatefulWidget {
  final bool returnValue;
  const ProductList({super.key, required this.returnValue});

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  TextEditingController controller = TextEditingController(text: '');
  final ImagePicker _picker = ImagePicker();
  XFile? _imageFile;
  dynamic pickImageError;

  @override
  void initState() {
    final provider = Provider.of<MabrukProvider>(context, listen: false);
    provider.getBrands();
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<MabrukProvider>();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.mainColor,
        title: TitleText('PRODUCTOS'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.all(0.0),
              child: ButtonTheme(
                alignedDropdown: true,
                child: SizedBox(
                  height: 45,
                  width: double.infinity,
                  child: Consumer<MabrukProvider>(
                    builder: (context, value, child) {
                      if (value.brandsModel.isNotEmpty) {
                        return Container(
                          width: double.maxFinite,
                          decoration: BoxDecoration(
                            //borderRadius: BorderRadius.circular(0),
                            border: Border.all(color: Colors.black12),
                            color: Colors.white,
                          ),
                          child: DropdownButton<BrandModel>(
                            items: provider.brandsModel.map((brand) {
                              return DropdownMenuItem(
                                value: brand,
                                child: Text(brand.name),
                              );
                            }).toList(),
                            onChanged: (newVal) {
                              if (newVal != null) {
                                provider.setSelectedValue(newVal);
                              }
                            },
                            value: provider.selectedValue,
                            icon: const Icon(Icons.arrow_drop_down),
                            elevation: 0,
                            underline: SizedBox(),
                            hint: Text("Selecciona una marca"),
                            borderRadius: BorderRadius.circular(0),
                            dropdownColor: Colors.white,
                            isExpanded: true,
                            style: TextStyle(
                              fontSize: 14,
                              //fontWeight: FontWeight.w500,
                              //color: Colors.red,
                              color: Color(0xFF395477),
                              //color: Colors.white,
                            ),
                          ),
                        );
                      }
                      return const Center(child: CircularProgressIndicator());
                    },
                  ),
                ),
              ),
            ),
            SizedBox(height: 10.0),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 8.0),
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
                onChanged: (value) {},
              ),
            ),
            SizedBox(height: 10.0),
            Expanded(
              child: Consumer<MabrukProvider>(
                builder: (context, value, child) {
                  if (value.productsModel.isNotEmpty) {
                    return ListProduct(
                      products: context.watch<MabrukProvider>().productsModel,
                      returnValue: widget.returnValue,
                    );
                  }
                  return Center(
                    child: Text("No hay resultados")
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

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
        _upload(productId);
      });
    } catch (e) {
      setState(() {
        pickImageError = e;
      });
    }
  }

  void _upload(int productId) {
    /*uploadImage(_imageFile!.path.toString(), productId).then((value) {
      if (value.isSuccessful) {
        ScaffoldMessenger.of(context)
          ..removeCurrentSnackBar()
          ..showSnackBar(SnackBar(content: Text('¡Imagen actuailzada!')));
      }
    });*/
  }
}
