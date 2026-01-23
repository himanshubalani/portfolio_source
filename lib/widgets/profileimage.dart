import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:portfolio/consts/style.dart';

class ProfileImage extends StatelessWidget {
  const ProfileImage({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double frameWidth = (screenWidth * 0.15).clamp(200.0, 280.0);
    double frameHeight = frameWidth * 1.2;
    bool isDark = Theme.of(context).brightness == Brightness.dark;

    return Center(
      child: Transform.rotate(
        angle: -0.06,
        child: Container(
          width: frameWidth,
          height: frameHeight,
          decoration: BoxDecoration(
            color: isDark ? AppColors.black : AppColors.offwhite,
            borderRadius: BorderRadius.circular(5.r),
            border: Border.all(
              color: isDark ? AppColors.lightSeafoamGreen : AppColors.black,
              width: 3,
            ),
            boxShadow: isDark
                ? [
                    BoxShadow(
                      color: AppColors.lightSeafoamGreen.withValues(alpha: 0.9),
                      blurRadius: 12,
                      spreadRadius: 1,
                    ),
                    BoxShadow(
                      color: AppColors.lightSeafoamGreen.withValues(alpha: 0.5),
                      blurRadius: 30,
                      spreadRadius: 6,
                    ),
                    BoxShadow(
                      color:
                          AppColors.lightSeafoamGreen.withValues(alpha: 0.25),
                      blurRadius: 60,
                      spreadRadius: 12,
                    ),
                  ]
                : [],
          ),
          padding: EdgeInsets.only(
            top: 5.h,
            left: 5.h,
            right: 5.h,
            bottom: 50.h.clamp(0, 40),
          ),
          child: ClipRRect(
            clipBehavior: Clip.antiAlias,
            borderRadius: BorderRadius.all(Radius.circular(2.r)),
            child: Container(
              decoration: BoxDecoration(
                  border: Border.all(
                      color: isDark
                          ? AppColors.lightSeafoamGreen
                          : AppColors.black,
                      width: 2)),
              child: Image.asset(
                'assets/images/profileimage2.webp',
                fit: BoxFit.cover,
                width: double.infinity,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
