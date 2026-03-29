import 'package:flutter/material.dart';
import 'package:mabruk_2026/models/product_model.dart';
import 'package:mabruk_2026/pages/products/item_product_list.dart';

class ListProduct extends StatelessWidget {
  final List<ProductModel> products;
  final bool returnValue;
  const ListProduct({
    super.key,
    required this.products,
    required this.returnValue,
  });

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
          onSelect: () {
            if (this.returnValue) {
              Navigator.pop(context, currentProduct);
            }
          },
          /*widget.parameters.returnValue
              ? () {

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
