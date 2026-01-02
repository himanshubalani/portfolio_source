import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portfolio/consts/style.dart';
import 'package:url_launcher/url_launcher_string.dart';

class CustomSnackbarContainer extends StatefulWidget {
  const CustomSnackbarContainer({Key? key}) : super(key: key);

  @override
  _CustomSnackbarContainerState createState() =>
      _CustomSnackbarContainerState();
}

class _CustomSnackbarContainerState extends State<CustomSnackbarContainer>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<Offset> _offsetAnimation;
  bool _isVisible = true;

  @override
  void initState() {
    super.initState();

    // Animation controller for slide transition
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    _offsetAnimation = Tween<Offset>(
      begin: const Offset(0, -1),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOutBack,
        reverseCurve: Curves.easeInBack,
      ),
    );

    // Start entrance animation
    _controller.forward();

    // Auto-dismiss after 10 seconds
    Future.delayed(const Duration(seconds: 10), () {
      _controller.reverse().then((_) {
        if (mounted) {
          setState(() {
            _isVisible = false;
          });
        }
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!_isVisible) return const SizedBox.shrink();

    return Dismissible(
      key: UniqueKey(),
      direction: DismissDirection.horizontal,
      onDismissed: (_) {
        // Reverse animation then hide on dismiss
        _controller.reverse().then((_) {
          if (mounted) {
            setState(() {
              _isVisible = false;
            });
          }
        });
      },
      child: SlideTransition(
        position: _offsetAnimation,
        child: Align(
          alignment: Alignment.topCenter,
          child: Container(
            margin: Get.width <= 900
                ? EdgeInsets.only(top: 30.h, left: 20.w, right: 20.w)
                : EdgeInsets.only(top: 5.h, left: 50.w, right: 50.w),
            constraints: BoxConstraints(
              maxWidth: Get.width <= 900 ? 400.w : 150.w,
              maxHeight: Get.width <= 900 ? 130.h : 200.h,
            ),
            padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 5.h),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10.r),
              border: Border.all(color: AppColors().black, width: 3),
              boxShadow: [
                BoxShadow(
                  color: AppColors().black,
                  offset: const Offset(5, 5),
                  blurRadius: 0,
                ),
              ],
            ),
            child: Column(
              children: [
                      Row(
                        children: [
                          Icon(
                            Icons.campaign_rounded,
                            color: AppColors().black,
                            size: Get.width <= 900 ? 20.sp : 10.sp,
                          ),  
                          Text(
                            "I'M OPEN TO WORK",
                            style: TextStyle(
                              fontFamily: GoogleFonts.rubik().fontFamily,
                              color: AppColors().black,
                              fontWeight: FontWeight.bold,
                              fontSize: Get.width <= 900 ? 14.sp : 5.sp,
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "I'm looking for full-time roles as a developer. Reach out by clicking the button below or head to socials page",
                          style: TextStyle(
                            fontFamily: GoogleFonts.rubik().fontFamily,
                            color: AppColors().black,
                            fontSize: Get.width <= 900 ? 12.sp : 5.sp,
                          ),
                        ),
                      ),
                TextButton(
                  onPressed: () =>
                      launchUrlString('mailto:hire@himanshubalani.com'),
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                    backgroundColor: AppColors().mustardYellow,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: BorderSide(color: AppColors().black, width: 3),
                    ),
                    shadowColor: AppColors().black,
                    elevation: 0,
                  ).copyWith(
                    overlayColor:
                        MaterialStateProperty.all(Colors.black.withOpacity(0.1)),
                  ),
                  child: Text(
                    'Email me at hire@himanshubalani.com',
                    style: TextStyle(
                      fontFamily: GoogleFonts.rubik().fontFamily,
                      color: AppColors().black,
                      fontSize: Get.width <= 900 ? 12.sp : 5.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}