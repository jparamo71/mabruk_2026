
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:mabruk_2026/utils/palette_theme.dart';
import 'package:mabruk_2026/utils/styles/normal_text.dart';

class ItemCustomer extends StatelessWidget {
  final String customerName;
  final String nit;
  final String address;
  final String phoneNumber;
  final String email;
  final Function onSelect;
  const ItemCustomer({
    Key? key,
    required this.customerName,
    required this.nit,
    required this.address,
    required this.phoneNumber,
    required this.email,
    required this.onSelect,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onSelect(),
      child: Container(
        padding: EdgeInsets.all(
          8.0
        ),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              width: 2.0,
              color: Color(0xFFD4D4D4),
            ),
          ),
        ),
        child: Row(
          children: [
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    NormalText(customerName, bold: true, size: 14, color: Color(0xff693535)),
                    const SizedBox(height: 4.0,),
                    NormalText(nit, size: 14),
                    const SizedBox(height: 4.0),
                    NormalText(address, size: 14),
                    const SizedBox(height: 4.0,),
                    NormalText(email, size: 14),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
