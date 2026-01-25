import 'package:flutter/material.dart';
import 'package:mabruk_2026/providers/mabruk_provider.dart';
import 'package:mabruk_2026/utils/palette_theme.dart';
import 'package:mabruk_2026/widgets/list_product.dart';
import 'package:provider/provider.dart';

class ProductList extends StatefulWidget {
  const ProductList({super.key});

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  @override
  void initState() {
    Provider.of<MabrukProvider>(
      context,
      listen: false,
    ).getProductsData("", 7, false, 0, true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
            Expanded(
              child: Consumer<MabrukProvider>(
                builder: (context, value, child) {
                  if (value.productsModel.isNotEmpty) {
                    return ListProduct(
                      products: context.watch<MabrukProvider>().productsModel,
                    );
                  }

                  return const Center(child: Text("xxxx"));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
