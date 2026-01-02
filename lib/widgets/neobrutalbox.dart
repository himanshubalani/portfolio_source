import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portfolio/consts/style.dart';
import 'package:portfolio/presentation/onhover.dart';

class NeoBrutalBox extends StatelessWidget {
  final String headerText;
  final Color headerColor;
  final Widget containerChild;

  const NeoBrutalBox({
    super.key,
    required this.headerText,
    required this.headerColor,
    required this.containerChild,
  });

  @override
  Widget build(BuildContext context) {
    // 1. Check Theme
    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    // 2. Define Colors based on Theme
    final Color mainBgColor = isDark ? Colors.black : Colors.white;
    final Color borderColor = isDark ? headerColor : Colors.black;
    final Color shadowColor = isDark ? headerColor : Colors.black;
    final Color boxCircleColor = isDark ? headerColor : Colors.white;


    return Container(
      decoration: BoxDecoration(
        color: mainBgColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          width: 2,
          color: borderColor, // Dynamic Border
        ),
        boxShadow: [
          BoxShadow(
            color: shadowColor, // Dynamic Shadow
            spreadRadius: 2.0,
            offset: const Offset(4, 6),
          ),
        ],
      ),
      child: Column(
        children: [
          // Header Section
          Container(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(18),
                topRight: Radius.circular(18),
              ),
              border: Border(
                bottom: BorderSide(
                  color: borderColor, // Match the main border
                  width: 2,
                ),
                top: BorderSide(
                  color: borderColor, 
                  width: 0,
                ),
                left: BorderSide(
                  color: borderColor,
                  width: 0,
                ),
                right: BorderSide(
                  color: borderColor,
                  width: 0,
                ),
              ),
              color: isDark ? AppColors().black : headerColor,
            ),
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                children: [
                  Text(
                    headerText,
                    style: TextStyle(
                      fontFamily: GoogleFonts.outfit().fontFamily,
                      fontSize:
                          MediaQuery.of(context).size.width <= 900 ? 20 : 5.w,
                      fontWeight: FontWeight.bold,
                      //Text changes color, based on theme
                      color: isDark ? headerColor : Colors.black,
                    ),
                  ),
                  const Spacer(),
                  BoxCircles(hoverEnabled: true, color: boxCircleColor,),
                  BoxCircles(hoverEnabled: true,color: boxCircleColor,),
                  BoxCircles(hoverEnabled: true,color: boxCircleColor,),
                ],
              ),
            ),
          ),
          // Body Section
          Container(
            padding: const EdgeInsets.all(12.0),
            child: containerChild,
          ),
        ],
      ),
    );
  }
}

class BoxCircles extends StatelessWidget {
  final bool hoverEnabled;
  final Color? color; // optional color override

  const BoxCircles({
    super.key,
    this.hoverEnabled = true,
    this.color, 
  });

  @override
  Widget build(BuildContext context) {
    if (hoverEnabled) {
      return OnHover(
        builder: (bool isHovered) {
          return _circle(context);
        },
      );
    } else {
      return _circle(context);
    }
  }

  Widget _circle(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    
    // Logic: 
    // If color is provided manually, use it.
    // Otherwise: Light Mode = White, Dark Mode = Black
    final Color baseColor = color ?? (isDark ? Colors.black : Colors.white);

    return Container(
      width: 20,
      height: 20,
      margin: const EdgeInsets.only(left: 2.0),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: baseColor.withOpacity(0.75),
        border: Border.all(
          width: 2,
          color: Colors.black, 
        ),
      ),
    );
  }
}
