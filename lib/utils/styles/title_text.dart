import 'package:flutter/material.dart';

class TitleText extends StatelessWidget {
  final String text;
  final double size;
  const TitleText(this.text, {super.key, this.size = 18});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black38),
    );
  }
}
