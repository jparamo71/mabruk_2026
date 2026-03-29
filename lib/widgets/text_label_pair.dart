import 'package:flutter/material.dart';
import 'package:mabruk_2026/utils/styles/normal_text.dart';


class TextLabelPair extends StatelessWidget {
  final String caption;
  final String text;

  const TextLabelPair({
    Key? key,
    required this.caption,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        NormalText(
          caption,
          bold: true,
        ),
        NormalText(text),
      ],
    );
  }
}
