import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:portfolio/consts/style.dart';
import 'package:portfolio/presentation/onhover.dart';
import 'package:portfolio/widgets/socialbox.dart';
import 'package:url_launcher/url_launcher_string.dart';

class LinkCard extends StatelessWidget {
  const LinkCard({
    super.key,
    required this.vlink,
    required this.vbuttoncolor,
    required this.imageUrl,
    required this.vtext,
    required this.vicon,
    required this.vframecolor,
    required this.wide,
  });

  final String vlink;
  final Color vbuttoncolor;
  final String imageUrl;
  final String vtext;
  final dynamic vicon;
  final Color vframecolor;
  final bool wide;

  @override
  Widget build(BuildContext context) {
    const double borderWidth = 1.5;

    // Dark mode
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    final Color frameColor = isDark ? AppColors.black : vframecolor;
    final Color borderColor = isDark ? vframecolor : AppColors.black;

    // Screen size logic
    final bool isMobile = MediaQuery.of(context).size.width < 600;

    // Calculate dimensions based on screen size and 'wide' parameter
    final double cardWidth = isMobile
        ? double.infinity // Mobile width
        : (wide ? 120.w : 60.w); // Desktop width (Change these if needed)

    final double cardHeight = isMobile
        ? (wide ? 120.w : 200.h) // Mobile height
        : (wide ? 50.w : 80.w); // Desktop height (Change these if needed)

    return OnHover(
      builder: (bool isHovered) {
        return InkWell(
          onTap: () {
            launchUrlString(vlink);
          },
          child: SizedBox(
            // Apply the variables here
            width: cardWidth,
            height: cardHeight,
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                // Main Card Container
                Container(
                  width: double.infinity,
                  height: double.infinity,
                  decoration: BoxDecoration(
                    color: frameColor, // Dynamic Background
                    borderRadius: BorderRadius.circular(10.r),
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
                  padding: const EdgeInsets.all(5),
                  child: Column(
                    children: [
                      // Image Container
                      Expanded(
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: borderColor, width: borderWidth),
                            borderRadius: BorderRadius.circular(6.r),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(6.r),
                            child: Image.network(
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
                  left: -10,
                  top: -10,
                  child: SocialLinkButton(
                    link: vlink,
                    icon: vicon,
                    pfname: vtext,
                    pfcolor: vbuttoncolor,
                    vmainaxissize: wide ? MainAxisSize.min : MainAxisSize.max,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}