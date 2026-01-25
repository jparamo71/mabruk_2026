import 'package:flutter/material.dart';
import 'package:mabruk_2026/models/product_model.dart';
import 'package:mabruk_2026/widgets/item_product_list.dart';

class ListProduct extends StatelessWidget {
  final List<ProductModel> products;
  const ListProduct({super.key, required this.products});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: products.length,
      itemBuilder: (context, index) {
        ProductModel currentProduct = products[index];
        return ItemProductList(
          productCode: currentProduct.productCode,
          productName: currentProduct.justName,
          productMark: currentProduct.brandName,
          available: currentProduct.quantityAvailable,
          prize: currentProduct.prize,
          imagePath: currentProduct.rutaFisicaImage(),
          onSelect: () {},
          /*widget.parameters.returnValue
              ? () {
                  Navigator.pop(context, currentProduct);
                }
              : () => Navigator.of(
                  context,
                ).pushNamed('/product', arguments: currentProduct),*/
          onPicture: () {}, //async => _takePhoto(currentProduct.productId),
        );
      },
    );
  }
}
