import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class IconRounded extends StatelessWidget {
  final IconData icon;
  final bool enabled;
  final AsyncCallback onClick;

  const IconRounded({
    super.key,
    required this.icon,
    required this.enabled,
    required this.onClick
  });


  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: enabled ? Colors.orange : Colors.black26, //const Color(0xFF1B5E20), // Dark green background
        borderRadius: BorderRadius.circular(25), // Rounded corners
        border: Border.all(color: Colors.white, width: 1), // The border
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2), // Subtle dark shadow
            blurRadius: 3,   // Softness of the shadow
            spreadRadius: 2, // Size of the shadow
            offset: const Offset(0, 2), // Position (horizontal, vertical)
          ),
        ],
      ),
      child: IconButton(
          icon: Icon(icon, color: Colors.white),
          onPressed: () {
            if (enabled)
              {
                onClick();
              }
          }
      ),
    );
  }

}


