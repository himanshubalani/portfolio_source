import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
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
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          width: 2,
        ),
        boxShadow: const [
          BoxShadow(
            color: Colors.black,
            spreadRadius: 2.0,
            offset: Offset(4, 6),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(18),
                topRight: Radius.circular(18),
              ),
              border: const Border(
                bottom: BorderSide(
                  color: Colors.black,
                  width: 2,
                ),
                top: BorderSide(
                  color: Colors.black,
                  width: 0,
                ),
                left: BorderSide(
                  color: Colors.black,
                  width: 0,
                ),
                right: BorderSide(
                  color: Colors.black,
                  width: 0,
                ),
              ),
              color: headerColor,
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
                    ),
                  ),
                  const Spacer(),
                  const BoxCircles(hoverEnabled: true,),
                  const BoxCircles(hoverEnabled: true,),
                  const BoxCircles(hoverEnabled: true,),
                ],
              ),
            ),
          ),
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
  final Color? color; // optional color

  const BoxCircles({
    super.key,
    this.hoverEnabled = true,
    this.color, // default: null → fallback to white
  });

  @override
  Widget build(BuildContext context) {
    if (hoverEnabled) {
      return OnHover(
        builder: (bool isHovered) {
          return _circle();
        },
      );
    } else {
      return _circle();
    }
  }

  Widget _circle() {
    final baseColor = color ?? Colors.white;

    return Container(
      width: 20,
      height: 20,
      margin: const EdgeInsets.only(left: 2.0),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: baseColor.withOpacity(0.75), // opacity stays the same
        border: Border.all(
          width: 2,
          color: Colors.black
        ),
      ),
    );
  }
}
