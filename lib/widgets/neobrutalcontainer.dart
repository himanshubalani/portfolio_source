import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:portfolio/consts/style.dart';

import '../presentation/onhover.dart';

class NeoBrutalContainer extends StatelessWidget {
  final String text;
  final dynamic fontsize;
  final dynamic width;
  final dynamic height;
  final String? path;
  final Color color;

  const NeoBrutalContainer({
    super.key,
    required this.text,
    required this.width,
    required this.height,
    required this.fontsize,
    this.path,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    // 1. Check Theme
    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    // 2. Define Colors
    // Light Mode: Color BG, Black Elements
    // Dark Mode: Black BG, Color Elements (Neon look)
    final Color bgColor = isDark ? Colors.black : color;
    final Color accentColor = isDark ? color : Colors.black;

    return OnHover(builder: (bool isHovered) {
      return InkWell(
        onTap: () {
          if (path != null) {
            Get.toNamed(path!);
          }
        },
        child: Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            color: bgColor, // Dynamic Background
            borderRadius: BorderRadius.circular(18),
            boxShadow: [
              BoxShadow(
                color: accentColor, // Dynamic Shadow
                spreadRadius: 2.0,
                offset: const Offset(3, 3), 
              ),
            ],
            border: Border.all(
              color: accentColor, // Dynamic Border
              width: 3.0, 
            ),
          ),
          child: Center(
            child: Text(
              text,
              textAlign: TextAlign.center,
              style: TextStyle(
                // Dynamic Text Color (Matches border in dark mode)
                color: accentColor,
                fontSize: fontsize,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      );
    });
  }
}
