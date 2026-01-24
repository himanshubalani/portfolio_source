import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:portfolio/consts/style.dart';
import 'package:portfolio/presentation/onhover.dart';
import 'package:portfolio/widgets/languagebox.dart';
import 'package:url_launcher/url_launcher_string.dart';

class LinkCard extends StatelessWidget {
  const LinkCard({super.key,
  required this.vlink,
  required this.imageUrl,
  required this.vtext,
  required this.vframecolor,
  required this.wide,
  });

  final String vlink;
  final String imageUrl;
  final String vtext;
  final Color vframecolor;
  final bool wide;



  @override
  Widget build(BuildContext context) {
    const double borderWidth = 1.5;

    //Dark mode
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    final Color frameColor = isDark ? AppColors.black : vframecolor;
    final Color borderColor = isDark ? vframecolor : AppColors.black; //Color(0xFFF1DBBF)

    return OnHover(
      builder: (bool isHovered) {
        return InkWell(
          onTap: () {
            launchUrlString(
                vlink,
                );
          },
          child: SizedBox(
            width: wide? 120.w : 50.w,
            height: wide? 50.w: 120.w,
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                // Main Card Container
                Container(
                  width: double.infinity,
                  height: double.infinity,
                  decoration: BoxDecoration(
                    color: frameColor, // Dynamic Background
                    borderRadius: BorderRadius.circular(18),
                    boxShadow: isDark
                        ? [
                            BoxShadow(
                              color: borderColor.withValues(alpha: 0.9),
                              blurRadius: 12,
                              spreadRadius: 1,
                            ),
                            BoxShadow(
                              color: borderColor.withValues(alpha: 0.5),
                              blurRadius: 30,
                              spreadRadius: 6,
                            ),
                            BoxShadow(
                              color: borderColor.withValues(alpha: 0.25),
                              blurRadius: 60,
                              spreadRadius: 12,
                            ),
                          ]
                        : [],
                    border: Border.all(
                      color: borderColor, // Dynamic Border
                      width: 3.0,
                    ),
                  ),
                  padding: EdgeInsets.all(5),
                  child: Column(
                    children: [
                      // Image Container
                      Expanded(
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: borderColor, width: borderWidth),
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10.r),
                            child: Image.network(
                              //'https://qjvybcivwgqrmexvyzuq.supabase.co/storage/v1/object/public/gallery/test/user_sole_owner/2025-11-27T13-21-21.665005Z_326576.jpg',
                              imageUrl,
                              fit: BoxFit.cover,
                              loadingBuilder:
                                  (context, child, loadingProgress) {
                                if (loadingProgress == null) return child;
                                return Center(
                                  child: CircularProgressIndicator(
                                    value: loadingProgress.expectedTotalBytes !=
                                            null
                                        ? loadingProgress
                                                .cumulativeBytesLoaded /
                                            loadingProgress.expectedTotalBytes!
                                        : null,
                                    color: Colors.black,
                                    strokeWidth: 2,
                                  ),
                                );
                              },
                              errorBuilder: (context, error, stackTrace) {
                                return Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(Icons.image,
                                          size: 6.sp, color: Colors.grey),
                                      SizedBox(height: 8.h),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                Positioned(
                    right: 10,
                    bottom: 10,
                    child: LanguageBox(text:
                    vtext,
                    //'Photo Album',
                    fontsize: 5.sp))
              ],
            ),
          ),
        );
      },
    );
  }
}
