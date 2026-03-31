import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mabruk_2026/utils/styles/normal_text.dart';

class ItemDocument extends StatelessWidget {
  final int productId;
  final String productCode;
  final String productName;
  final double quantity;
  final double unitPrize;
  final double total;
  final bool enable;
  final Function onDelete;
  final Function onChangeQuantity;
  final String imagePath;
  const ItemDocument({
    super.key,
    required this.productId,
    required this.productCode,
    required this.productName,
    required this.quantity,
    required this.unitPrize,
    required this.total,
    required this.enable,
    required this.onDelete,
    required this.onChangeQuantity,
    this.imagePath = '',
  });

  //final quantityController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var f = NumberFormat("#,##0.0#", "en_US");
    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(width: 2.0, color: Color(0xFFD4D4D4)),
        ),
      ),
      child: Row(
        children: [
          // Product image
          Container(
            height: 80,
            width: 60,
            padding: EdgeInsets.all(0.0),
            child: imagePath == ''
                ? Image(image: AssetImage("assets/no_image.png"))
                : Image(image: NetworkImage(imagePath)),
          ),
          // Product description
          Expanded(
            child: Stack(
              children: [
                Container(
                  /*height: 100,*/
                  margin: const EdgeInsets.only(
                    top: 8.0,
                    bottom: 8.0,
                    left: 5.0,
                  ),
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      NormalText(productCode, bold: true),
                      Text(
                        productName.trim(),
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 14.0,
                        ),
                      ),
                      GestureDetector(
                        onTap: enable ? () => onChangeQuantity() : null,
                        child: NormalText(
                          "Q ${f.format(unitPrize)} X ${f.format(quantity)} = Q ${f.format(total)}",
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          enable
              ? Align(
                  alignment: Alignment.topRight,
                  child: IconButton(
                    onPressed: () {
                      onDelete();
                      //_showMyDialog(context);
                    },
                    alignment: Alignment.topRight,
                    icon: Icon(Icons.delete_outline, color: Colors.redAccent),
                  ),
                )
              : Container(),
        ],
      ),
    );
  }

  // Delete confirm
  Future<void> _showMyDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Eliminar producto'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text(
                  '¿Está seguro que desea eliminar el producto seleccionado?',
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context, 'No'),
              child: const Text('No'),
            ),
            TextButton(
              onPressed: () {
                onDelete();
                Navigator.pop(context, 'OK');
              },
              child: const Text('Sí'),
            ),
          ],
        );
      },
    );
  }
}
