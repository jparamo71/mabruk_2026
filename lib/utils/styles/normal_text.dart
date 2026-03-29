import 'package:flutter/material.dart';

class NormalText extends StatelessWidget {
  final String text;
  final bool bold;
  final Color color;
  final double size;
  final double height;
  final TextOverflow? overflow;
  const NormalText(
    this.text, {
    super.key,
    this.color = const Color(0xFF5C5C5C),
    this.size = 12,
    this.height = 1.2,
    this.bold = false,
    this.overflow = TextOverflow.ellipsis,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: color,
        fontFamily: 'Roboto',
        fontSize: size,
        height: height,
        overflow: overflow,
        fontWeight: bold ? FontWeight.w600 : FontWeight.w500,
      ),
    );
  }
}
