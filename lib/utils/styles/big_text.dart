import 'package:flutter/material.dart';

class BigText extends StatelessWidget {
  final String text;
  final Color color;
  final double size;
  final double height;
  const BigText(
    this.text, {
    super.key,
    this.color = const Color(0xff89dad0),
    this.size = 18,
    this.height = 1.2,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: color,
        fontSize: size,
        height: height,
        overflow: TextOverflow.ellipsis,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}