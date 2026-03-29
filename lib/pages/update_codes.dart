import 'package:flutter/material.dart';
import 'package:mabruk_2026/models/product_model.dart';
import 'package:mabruk_2026/utils/palette_theme.dart';

class UpdateCodes extends StatefulWidget {
  const UpdateCodes({super.key});

  @override
  State<UpdateCodes> createState() => _UpdateCodesState();
}

class _UpdateCodesState extends State<UpdateCodes> {
  List<ProductModel> products = [];
  TextEditingController txtController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.mainColor,
        title: const Text('ACTUALIZAR CÓDIGOS'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Lea el código de barras del producto'),
              SizedBox(height: 8.0),
              SizedBox(
                width: 300,
                child: TextField(
                  controller: txtController,
                  textInputAction: TextInputAction.go,
                  onSubmitted: (value) async {
                    /*products = await ProductDto.searchProductByCode(
                        txtController.text);*/
                    setState(() {});
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Código del producto',
                  ),
                ),
              ),
              SizedBox(height: 10.0),
              _buildTable(products),              
            ],
          ),
        ),
      ),
    );
  }

  Expanded _buildTable(List<ProductModel> prds) {
    return Expanded(
      child: SingleChildScrollView(
        child: Table(
          border: TableBorder.all(),
          columnWidths: const <int, TableColumnWidth>{
            0: IntrinsicColumnWidth(),
            1: FlexColumnWidth(),
            //2: FixedColumnWidth(124),
            2: FixedColumnWidth(164),
            3: FixedColumnWidth(64),
          },
          defaultVerticalAlignment: TableCellVerticalAlignment.middle,
          children: [
            TableRow(children: [
              Container(
                padding: const EdgeInsets.all(8.0),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.black12,
                ),
                child: Text(
                  "Código",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.black12,
                ),
                child: Text(
                  "Producto",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              /*Container(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.black12,
                ),
                child: Text(
                  "Marca",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),*/
              Container(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.black12,
                ),
                child: Text(
                  "Código de barras",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              /*Container(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.black12,
                ),
                child: Text(
                  "Código UPC",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),*/
              Container(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.black12,
                ),
                child: Text(
                  " ",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ]),
            ...prds.map((e) => _buildTableRow(e))
          ],
        ),
      ),
    );
  }

  TableRow _buildTableRow(ProductModel p) {
    return TableRow(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(p.productCode),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(p.productName),
        ),
        /*Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(p.markName),
        ),*/
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(p.barcharCode),
        ),
        /*Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(p.UPCCode),
        ),*/
        IconButton(
          onPressed: () {
            p.barcharCode = txtController.text;
            /*p.updateCode().then((value) {
              txtController.text = "";
              products = [];
              setState(() {});
            });*/
          },
          icon: Icon(Icons.check),
        ),
      ],
    );
  }
}