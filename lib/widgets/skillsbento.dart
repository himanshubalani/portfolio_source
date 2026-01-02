import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portfolio/consts/style.dart';
import 'package:portfolio/widgets/neobrutalbox.dart';
import 'languagebox.dart'; // Import the shared widget

class SkillsBento extends StatelessWidget {
  static double pageWidth = Get.width;

  SkillsBento({super.key});

  final List<String> languages = [
    "Python",
    "Dart",
    "HTML",
    "CSS",
    "JavaScript",
    "C++"
  ];
  final List<String> frameworks = ["Flutter", "Express.js"];
  final List<String> cloud = ["Google Cloud", "Firebase"];
  final List<String> designTools = ["Figma", "Adobe Illustrator"];
  final List<String> others = ["Git", "Rest APIs", "Markdown"];

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
            constraints: BoxConstraints(
              maxWidth: pageWidth <= 900 ? 300.w : pageWidth / 2.6,
            ),
            decoration: BoxDecoration(
              color: isDark ? AppColors().black : const Color(0xFFFFFF00),
              border: Border.all(color: isDark ? const Color(0xFFFBFF2F) : const Color(0xFF000000), width: 2.0),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(18.0),
                topRight: Radius.circular(18.0),
              ),
              boxShadow: [
                BoxShadow(
                  color: isDark ? const Color(0xFFFBFF2F) : const Color(0xFF000000),
                  spreadRadius: 0.0,
                  offset: const Offset(6, 6),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "skills",
                    style: TextStyle(
                      color: isDark ? const Color(0xFFFBFF2F) : const Color(0xFF000000),
                      fontSize: pageWidth <= 900 ? 20 : 5.w,
                      fontFamily: GoogleFonts.outfit().fontFamily,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 12.0),
                  const BoxCircles(),
                ]
              ),
            )),
        Container(
          width: pageWidth <= 900 ? 300.w : pageWidth / 3,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: isDark ? const Color(0xFFFBFF2F) : const Color(0xFF000000),
                spreadRadius: 0.0,
                offset: const Offset(6, 6),
              ),
            ],
            color: isDark ? AppColors().black : const Color(0xFFFBFF2F),
            borderRadius: const BorderRadius.only(
              topRight: Radius.circular(18.0),
              bottomLeft: Radius.circular(18.0),
              bottomRight: Radius.circular(18.0),
            ),
          ),
          child: Column(
            children: [
              _buildSection(
                "languages",
                languages,
                const BorderRadius.only(
                  topRight: Radius.circular(18.0),
                ),
                isDark,
              ),
              _buildSection("frameworks", frameworks, BorderRadius.zero, isDark),
              _buildSection("cloud", cloud, BorderRadius.zero, isDark),
              _buildSection("design tools", designTools, BorderRadius.zero, isDark),
              _buildSection(
                "other",
                others,
                const BorderRadius.only(
                  bottomLeft: Radius.circular(18.0),
                  bottomRight: Radius.circular(18.0),
                ),
                isDark,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSection(
      String title, List<String> items, BorderRadius borderradius, bool isDark) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: borderradius,
        color: isDark ? AppColors().black : AppColors().white,
        border: Border.all(
            color: isDark ? const Color(0xFFFBFF2F) : AppColors().black,
            width: 2.0),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 9.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            title,
            style: TextStyle(
              color: isDark ? const Color(0xFFFBFF2F) : AppColors().black,
              fontSize: pageWidth <= 900 ? 12.w : 5.w.clamp(10, 24),
              fontFamily: GoogleFonts.outfit().fontFamily,
            ),
          ),
          const SizedBox(
              width: 4.0), // Use width to separate columns horizontally
          Expanded(
            child: Wrap(
              alignment: WrapAlignment.end,
              spacing: 6.0,
              runSpacing: 6.0,
              children: items
                  .map((item) => LanguageBox(
                        text: item,
                        fontsize: Get.width <= 900 ? 12.w : 5.w. clamp(10, 24),
                      ))
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}
