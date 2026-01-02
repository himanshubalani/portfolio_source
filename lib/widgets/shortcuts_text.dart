import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class ShortcutsText extends StatelessWidget {
  const ShortcutsText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: SwallowTailPainter(),
      child: Container(
        padding: EdgeInsets.fromLTRB(10.w, 4.h, 12.w, 4.h),
        child: Text(
          "Shortcuts -   Enter: About Page   D: Figma Design Portfolio   C: GitHub Profile",
          style: TextStyle(
            color: Colors.black,
            fontSize: 3.w,
            fontFamily: GoogleFonts.quicksand().fontFamily,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

class SwallowTailPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    final border = Paint()
      ..color = Colors.black
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    final path = Path();
    path.moveTo(0, 0); // top-left
    path.lineTo(size.width, 0); // top-right
    path.lineTo(size.width * 0.95, size.height / 2); // inward tip
    path.lineTo(size.width, size.height); // bottom-right
    path.lineTo(0, size.height); // bottom-left
    path.close();

    canvas.drawPath(path, paint);
    canvas.drawPath(path, border);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
