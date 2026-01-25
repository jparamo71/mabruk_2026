import 'package:flutter/material.dart';
import 'package:mabruk_2026/utils/palette_theme.dart';
import 'package:mabruk_2026/widgets/normal_text.dart';

class MainMenuButton extends StatelessWidget {
  final double width;
  final double height;
  final String text;
  final IconData? icon;
  final bool leftButton;
  final Function onNavigate;
  const MainMenuButton({
    super.key,
    required this.width,
    required this.height,
    required this.text,
    required this.onNavigate,
    this.icon = Icons.home,
    this.leftButton = true,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(0),
      child: ElevatedButton(
        onPressed: () {
          onNavigate();
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 40, color: AppColors.mainColor),
            NormalText(text, size: 14, color: AppColors.mainColor),
          ],
        ),
        /*
        style: ElevatedButton.styleFrom(
          fixedSize: Size(width, height),
          foregroundColor: Colors.white,
          elevation: 0,
        ),
        */
      ),
    );
  }
}
