import 'package:flutter/material.dart';
import 'package:mabruk_2026/utils/globals.dart';
import 'package:mabruk_2026/utils/palette_theme.dart';
import 'package:mabruk_2026/utils/styles/normal_text.dart';

class ItemProductList extends StatelessWidget {
  final String productCode;
  final String productName;
  final String productMark;
  final double available;
  final double prize;
  final Function? onSelect;
  final Function? onPicture;
  final String imagePath;
  const ItemProductList({
    super.key,
    required this.productCode,
    required this.productName,
    required this.productMark,
    required this.available,
    required this.prize,
    required this.onSelect,
    required this.onPicture,
    this.imagePath = '',
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onSelect!(),
      child: Container(
        padding: EdgeInsets.all(15.0),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(width: 2.0, color: Color(0xFFD4D4D4)),
          ),
        ),
        child: Row(
          children: [
            // Image in left side
            _imageLeftSide(),
            // Product description
            _productInformation(),
          ],
        ),
      ),
    );
  }

  // Imagen with take and upload photo optionallly
  Widget _imageLeftSide() {
    return Stack(
      children: [
        Container(
          height: 80,
          width: 80,
          padding: EdgeInsets.all(0.0),
          /*decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Color(0xFFDBDBDB),
                spreadRadius: 2.0,
                blurRadius: 2,
                offset: Offset(0, 3),
              ),
            ],
          ),*/
          child: imagePath == ''
              ? Image(image: AssetImage("assets/no_image.png"))
              : Image(image: NetworkImage(imagePath)),
        ),
        allowUploadImages
            ? Positioned(
                bottom: -5,
                right: -5,
                child: IconButton(
                  icon: Icon(Icons.camera_alt, color: AppColors.secondaryColor),
                  onPressed: () => onPicture!(),
                ),
              )
            : Container(),
      ],
    );
  }

  Widget _productInformation() {
    return Expanded(
      child: Container(
        //height: 0,
        margin: EdgeInsets.only(top: 4.0, bottom: 4.0, left: 5.0),
        padding: EdgeInsets.only(left: 4.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            NormalText(productCode, bold: true), SizedBox(height:2.0),
            NormalText(productName), SizedBox(height:2.0),
            NormalText(productMark), SizedBox(height:2.0),
            NormalText("$available unidades disponibles"),
          ],
        ),
      ),
    );
  }
}
