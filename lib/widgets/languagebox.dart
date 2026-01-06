import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class LanguageBox extends StatelessWidget {
  final String text;
  final double fontsize;
  final Color? darkModecolor;

  const LanguageBox({
    super.key,
    required this.text,
    required this.fontsize,
    this.darkModecolor,
  });

  @override
  Widget build(BuildContext context) {
    double pageWidth = MediaQuery.of(context).size.width;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 4.0),
      decoration: BoxDecoration(
        color: Theme.of(context).brightness == Brightness.light
            ? getColorForItem(text)
            : Colors.transparent,
        borderRadius: BorderRadius.circular(
            (pageWidth <= 900 ? 12.sp : 5.sp).clamp(12, 16)),
        border: Border.all(
            color: Theme.of(context).brightness == Brightness.light
                ? Colors.black
                : getColorForItem(text),
            width: 3.0),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: Theme.of(context).brightness == Brightness.light
              ? Colors.black
              : getColorForItem(text),
          fontSize: fontsize,
          fontFamily: GoogleFonts.outfit().fontFamily,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Color getColorForItem(String item) {
    const Map<String, Color> colorMap = {
      "Python": Color(0xFFFFE873),
      "Dart": Color(0xFF1CDAC5),
      "HTML": Color(0xFF95BAF0),
      "CSS": Color(0xFFE76F51),
      "Express.js": Color(0xFF2CBF29),
      "Google Cloud": Color(0xFFEA4335),
      "Firebase": Color(0xFFF6820D),
      "Adobe Illustrator": Color(0xFFF8A829),
      "Git": Color(0xFFFA5E3C),
      "Rest APIs": Color(0xFFEA37AD),
      "Flutter": Color(0xFFF2F2F2),
      "Figma": Color(0xFFA259FF),
      "Markdown": Color(0xFF99C1DD),
      "JavaScript": Color(0xFFE9D44D),
      "Java": Color(0xFF007396),
      "C++": Color(0xFF00599C),
      "Visual Studio Code": Color(0xFF007ACC),
      "Android Studio": Color(0xFF3DDC84),
      "Postman": Color(0xFFEF5B25),
      "MongoDB": Color(0xFF13AA52),
      "GitHub": Color(0x20181717),
      "UI/UX": Color(0xFFF7DEDE),
      "PowerShell": Color(0xFF0374b7),
      "CLI": Color(0xFF99999A),
      "Designing ᵈ": Color(0xFFEDD590),
      "Coding ᶜ": Color(0xFFA8ED90),
      'Engineering': Color(0xFFED90A8),
    };

    return colorMap[item] ?? Colors.grey;
  }
}
