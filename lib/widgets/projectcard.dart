import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portfolio/consts/style.dart';
import 'package:url_launcher/url_launcher.dart';
import '../presentation/onhover.dart';
import 'languagebox.dart';

class ProjectCard extends StatelessWidget {
  static double pageWidth = Get.width;
  final String projectName;
  final String projectDescription;
  final String imagePath;
  final String projectLink;
  final List<String> languages;
  final String buttonText;
  final String? projectLogo;

  const ProjectCard({
    super.key,
    required this.projectName,
    required this.projectDescription,
    required this.imagePath,
    required this.projectLink,
    required this.languages,
    this.projectLogo,
    required this.buttonText,
  });

  @override
  Widget build(BuildContext context) {
    final Uri toLaunch = Uri.parse(projectLink);
    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      width: MediaQuery.of(context).size.width <= 900
          ? 300.w
          : MediaQuery.of(context).size.width / 3.5,
      decoration: BoxDecoration(
        color: isDark ? AppColors().black : AppColors().white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: isDark ? AppColors().lightPeach : Colors.black,
          width: 3.0,
        ),
        boxShadow: [
          BoxShadow(
            color: isDark ? AppColors().lightPeach : Colors.black,
            spreadRadius: 2.0,
            offset: const Offset(3, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(14),
              topRight: Radius.circular(14),
            ),
            child: Image.asset(
              imagePath,
              height: 150,
              width: MediaQuery.of(context).size.width,
              fit: BoxFit.cover,
              cacheHeight: 360,
            ),
          ),

          // Header
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: isDark ? AppColors().black : AppColors().white,
              border: Border.symmetric(
                horizontal: BorderSide(
                  color: isDark ? AppColors().lightPeach : Colors.black,
                  width: 2,
                ),
              ),
            ),
            child: Row(
              children: [
                if (projectLogo != null)
                  Image.asset(
                    projectLogo!,
                    height: 32,
                    width: 32,
                    cacheHeight: 64,
                    cacheWidth: 64,
                  ),
                SizedBox(width: projectLogo != null ? 8.0 : 0),
                Text(
                  projectName,
                  style: AppStyles().outfitTextStyle.copyWith(
                        color: isDark
                            ? AppColors().lightPeach
                            : Colors.black,
                        fontSize: MediaQuery.of(context).size.width <= 900
                            ? 20.w
                            : 5.w,
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ],
            ),
          ),

          // Description
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: isDark ? AppColors().black : AppColors().white,
              border: Border(
                bottom: BorderSide(
                  color: isDark ? AppColors().lightPeach : Colors.black,
                  width: 2,
                ),
              ),
            ),
            child: Text(
              projectDescription,
              textAlign: TextAlign.justify,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color:
                    isDark ? AppColors().lightPeach : Colors.black,
                fontSize: MediaQuery.of(context).size.width <= 900
                    ? 12.w
                    : 4.w,
                fontFamily: GoogleFonts.outfit().fontFamily,
              ),
            ),
          ),

          // Tech stack
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Wrap(
              alignment: WrapAlignment.center,
              runAlignment: WrapAlignment.center,
              runSpacing: 8.0,
              children: [
                Text(
                  'made using:',
                  style: TextStyle(
                    color: isDark
                        ? AppColors().lightPeach
                        : Colors.black,
                    fontSize: MediaQuery.of(context).size.width <= 900
                        ? 12.w
                        : 4.w,
                    fontFamily: GoogleFonts.outfit().fontFamily,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Wrap(
                  runSpacing: 8.0,
                  children: languages
                      .map(
                        (language) => Padding(
                          padding:
                              const EdgeInsets.symmetric(horizontal: 2.0),
                          child: LanguageBox(
                            text: language,
                            fontsize:
                                MediaQuery.of(context).size.width <= 900
                                    ? 12.w
                                    : 4.w,
                          ),
                        ),
                      )
                      .toList(),
                ),
              ],
            ),
          ),

          // Button
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: OnHover(
              builder: (bool isHovered) {
                return GestureDetector(
                  onTap: () async {
                    await launchUrl(toLaunch);
                  },
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(8.0),
                    decoration: AppStyles()
                        .neoContainerDecorationTwo()
                        .copyWith(
                          color:
                              isDark ? AppColors().black : null,
                          border: Border.all(
                            color: isDark
                                ? AppColors().lightPeach
                                : Colors.black,
                            width: 2,
                          ),
                          borderRadius:
                              BorderRadius.circular(12.0),
                        ),
                    child: Center(
                      child: Text(
                        buttonText,
                        style: TextStyle(
                          color: isDark
                              ? AppColors().lightPeach
                              : Colors.black,
                          fontSize:
                              MediaQuery.of(context).size.width <= 900
                                  ? 12.w
                                  : 4.w,
                          fontFamily:
                              GoogleFonts.outfit().fontFamily,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
