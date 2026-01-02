import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class BottomBar extends StatelessWidget {
  const BottomBar({super.key});

  @override
  Widget build(BuildContext context) {
    var bbfontsize = 10.sp.clamp(5.0, 12.0).toDouble();
    return Theme(
      data: ThemeData(
        useMaterial3: false,
        fontFamily:
            GoogleFonts.quicksand(fontWeight: FontWeight.bold).fontFamily,
      ),
      child: BottomAppBar(
        color: const Color(0xFF101010),
        padding: const EdgeInsets.symmetric(horizontal: 20),
        elevation: 0.0,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '©',
                style: TextStyle(fontSize: bbfontsize, color: Colors.white),
              ),
              Text(
                DateTime.now().year.toString(),
                style: TextStyle(fontSize: bbfontsize, color: Colors.white),
              ),
              const SizedBox(width: 5),
              Text(
                'Made with ',
                style: TextStyle(fontSize: bbfontsize, color: Colors.white),
              ),
              const Icon(
                Icons.favorite,
                color: Colors.red,
                size: 12,
              ),
              Text(
                ' and Flutter by Himanshu Balani',
                style: TextStyle(fontSize: bbfontsize, color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
