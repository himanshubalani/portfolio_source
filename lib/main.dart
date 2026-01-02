import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portfolio/pages/about.dart';
import 'package:portfolio/pages/contact.dart';
import 'package:portfolio/pages/projects.dart';
import 'pages/homepage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: ScreenUtil.defaultSize,
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, _) {
        return WillPopScope(
          onWillPop: () async => false,
          child: GetMaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Himanshu Balani Portfolio',

            // 🔑 important
            themeMode: ThemeMode.system,

            theme: ThemeData(
              brightness: Brightness.light,
              useMaterial3: true,
              fontFamily:
                  GoogleFonts.outfit(fontWeight: FontWeight.bold).fontFamily,
            ),

            darkTheme: ThemeData(
              brightness: Brightness.dark,
              useMaterial3: true,
              fontFamily:
                  GoogleFonts.outfit(fontWeight: FontWeight.bold).fontFamily,
            ),

            routes: {
              '/home': (_) => const HomePage(),
              '/projects': (_) => const projects(),
              '/about': (_) => const AboutPage(),
              '/socials': (_) => const social(),
            },

            home: const HomePage(),
          ),
        );
      },
    );
  }
}
