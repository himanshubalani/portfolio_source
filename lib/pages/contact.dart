import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portfolio/consts/style.dart';
import 'package:portfolio/widgets/animated_pill_bg.dart';

import '../utils/appbar.dart';
import '../widgets/bottombar.dart';
import '../widgets/socialbox.dart';

class social extends StatelessWidget {
  const social({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).brightness == Brightness.light
              ? AppColors().lightPink
              : AppColors().black,
      appBar: const Appbar(),
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          if (constraints.maxWidth > 900) {
            return const DesktopSocialPage();
          } else {
            return const MobileSocialPage();
          }
        },
      ),
      bottomNavigationBar: const BottomBar(),
    );
  }
}

class DesktopSocialPage extends StatelessWidget {
  const DesktopSocialPage({super.key});


  @override
  Widget build(BuildContext context) {
    final bool isDark =
    Theme.of(context).brightness == Brightness.dark;

    return Flex(
      direction: Axis.horizontal,
      children: [
        Expanded(
          flex: 1,
          child: Stack(
            children: [
              AnimatedPillsBackground(
                rows: 10,
                columns: 24,
                color: AppColors().lavenderPink,
                duration: const Duration(seconds: 4),
              ),
              SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    SizedBox(height: 10.w),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const socialBox(),
                      ]
                          .map((e) => Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: e,
                              ))
                          .toList(),
                    ),
                    SizedBox(height: 20.w),
                  ],
                ),
              ),
              Positioned(
                left: 0,
                top: MediaQuery.of(context).size.height / 2.5,
                child: Transform.rotate(
                  angle: -pi / 2,
                  child: Text(
                    'socials',
                    style: TextStyle(
                      fontFamily:
                          GoogleFonts.quicksand(fontWeight: FontWeight.bold)
                              .fontFamily,
                      fontSize: 25.w,
                      fontWeight: FontWeight.bold,
                      color: isDark ? AppColors().lightPink : Colors.black,

                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class MobileSocialPage extends StatelessWidget {
  const MobileSocialPage({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isDark =
    Theme.of(context).brightness == Brightness.dark;

    return Stack(
      children: [
        Positioned(
          child: AnimatedPillsBackground(
            rows: 10,
          columns: 14,
          color: AppColors().lavenderPink,
        )
        ),
SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                'socials',
                style: TextStyle(
                  fontSize: 50.spMin,
                  fontFamily: GoogleFonts.quicksand(fontWeight: FontWeight.bold)
                      .fontFamily,
                  fontWeight: FontWeight.bold,
                  color: isDark ? AppColors().lightPink : Colors.black,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const socialBox(),
                ]
                    .map((e) => Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: e,
                        ))
                    .toList(),
              ),
              SizedBox(
                height: 20.w,
              )
            ]
                .map((e) => Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: e,
                    ))
                .toList(),
          ),
        ),
      ),
      ]
    );
  }
}
