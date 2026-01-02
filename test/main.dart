import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:google_fonts/google_fonts.dart';

import 'test.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    
    return ScreenUtilInit(
        designSize: ScreenUtil.defaultSize,
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, Widget? child) {
          return WillPopScope(
            onWillPop: () async => false,
            child: GetMaterialApp(
              routes: {

                '/test': (context) => const TestPage(),
              },
              debugShowCheckedModeBanner: false,
              title: 'Himanshu Balani Portfolio',
              theme: ThemeData(
                useMaterial3: true,
                fontFamily:
                    GoogleFonts.outfit(fontWeight: FontWeight.bold).fontFamily,
              ),
              home: const TestPage(),
            ),
          );
        });
  }
}
