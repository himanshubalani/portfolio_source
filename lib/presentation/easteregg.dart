import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portfolio/consts/style.dart';

import 'onhover.dart';

class HoverTextWidget extends StatefulWidget {
  final String mainText;
  final String smallText;
  final Color textColor;

  const HoverTextWidget({
    super.key,
    required this.mainText,
    required this.smallText,
    required this.textColor,
  });

  @override
  _HoverTextWidgetState createState() => _HoverTextWidgetState();
}

class _HoverTextWidgetState extends State<HoverTextWidget> {
  bool _isHovering = false;
  

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovering = true),
      onExit: (_) => setState(() => _isHovering = false),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          OnHover(builder: (bool isHovered) {
            return Text(
              widget.mainText,
              style: TextStyle(
                fontFamily: GoogleFonts.outfit(fontWeight: FontWeight.bold).fontFamily,
                fontSize: 10.sp,
                color: widget.textColor,
                fontWeight: FontWeight.bold
                ),
            );
          }),
          // if (_isHovering)
          //   ClipRRect(
          //     borderRadius: BorderRadius.all(Radius.circular(18)),
          //     child: Image.asset(
          //       'assets/images/kenobi.jpg', // Path to image file
          //       fit: BoxFit.cover,
          //       width: 50.w,
          //       height: 50.w,
          //     ),
          //   ),
          if (_isHovering)
            Text(
              widget.smallText,
              style: TextStyle(
                  fontFamily: GoogleFonts.outfit().fontFamily,
                  fontSize: 5.sp,
                  color: AppColors().white,
                  fontWeight: FontWeight.bold),
            ),
        ],
      ),
    );
  }
}
