import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portfolio/consts/style.dart';

class darkLanguageBox extends StatelessWidget {
  final String text;
  final double fontsize;

  const darkLanguageBox({Key? key, required this.text, required this.fontsize}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 6.0),
      decoration: BoxDecoration(
        color: AppColors().black,
        borderRadius: BorderRadius.circular(16.0),
        border: Border.all(color: getColorForItem(text), width: 3.0),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: getColorForItem(text),
          fontSize: fontsize,
          fontFamily: GoogleFonts.outfit().fontFamily,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Color getColorForItem(String item) {
    final Map<String, Color> colorMap = {
      "Python": const Color(0xFFFFE873),
      "Dart": const Color(0xFF1CDAC5),
      "HTML": const Color(0xFF95BAF0),
      "CSS": const Color(0xFFE76F51),
      "Express.js": const Color(0xFF2CBF29),
      "Google Cloud": const Color(0xFFEA4335),
      "Firebase": const Color(0xFFF6820D),
      "Adobe Illustrator": const Color(0xFFF8A829),
      "Git": const Color(0xFFFA5E3C),
      "Rest APIs": const Color(0xFFEA37AD),
      "Flutter": const Color(0xFFF2F2F2),
      "Figma": const Color(0xFFA259FF),
      "Markdown": const Color(0xFF99C1DD),
      "JavaScript": const Color(0xFFE9D44D),
      "Java": const Color(0xFF007396),
      "C++": const Color(0xFF00599C),
      "Visual Studio Code": const Color(0xFF007ACC),
      "Android Studio": const Color(0xFF3DDC84),
      "Postman": const Color(0xFFEF5B25),
      "MongoDB": const Color(0xFF13AA52),
      "GitHub": const Color(0x20181717),
      "UI/UX": const Color(0xFFF7DEDE),
      "Designing ᵈ": const Color(0xFFEDD590),
      "Coding ᶜ": const Color(0xFFA8ED90),
      'Engineering': const Color(0xFFED90A8),

    };

    return colorMap[item] ?? Colors.grey;
  }
}
