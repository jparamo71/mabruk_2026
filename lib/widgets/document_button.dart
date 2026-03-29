import 'package:flutter/material.dart';
import '../utils/palette_theme.dart';

class DocumentButton extends StatelessWidget {
  final double width;
  final double height;
  final String text;
  final bool enabled;
  final IconData? icon;
  final Color iconColor;
  final Function onClick;
  const DocumentButton(
      {super.key,
      required this.text,
      required this.width,
      required this.height,
      this.icon = Icons.home,
      this.iconColor = const Color(0xff87C235),
      this.enabled = false,
      required this.onClick});

  @override
  Widget build(BuildContext context) {
    return text == ''
        ? _buttonIcon()
        : _buttonIconAndText(); // _buttonIconAndText();
  }

  Widget _buttonIconAndText() {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
          foregroundColor: AppColors.secondaryColor,
          fixedSize: Size(width, height),
          elevation: 0,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(6))),
      onPressed: enabled ? () => onClick() : null,
      icon: Icon(
        icon,
        //size: 40,
        color: enabled ? iconColor : AppColors.disabledText,
      ),
      label: Text(
        text,
        style: TextStyle(color: Color.fromARGB(255, 92, 95, 92)),
      ),
    );
  }

  Widget _buttonIcon() {
    return ElevatedButton(
      onPressed: enabled ? () => onClick() : null,
      style: ElevatedButton.styleFrom(
          fixedSize: Size(width, height),
          foregroundColor: AppColors.secondaryColor,
          elevation: 0),
      child: Icon(
        icon,
        size: 35,
        color: Colors.white, //enabled ? iconColor : AppColors.disabledText,
      ),
    );
  }
}
