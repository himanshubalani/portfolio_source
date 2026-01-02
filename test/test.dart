import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:portfolio/consts/style.dart';
import 'package:portfolio/presentation/easteregg.dart';
import 'package:portfolio/presentation/onhover.dart';
import 'package:portfolio/utils/appbar.dart';
import 'package:portfolio/widgets/bottombar.dart';
import 'package:portfolio/widgets/opentowork.dart';
import 'package:simple_icons/simple_icons.dart';
import 'package:url_launcher/url_launcher_string.dart';

import 'darklanguagebox.dart';
import 'darkneobrutalcontainer.dart';

class TestPage extends StatefulWidget {
  const TestPage({Key? key}) : super(key: key);

  @override
  State<TestPage> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  @override
  Widget build(BuildContext context) {
    return RawKeyboardListener(
    autofocus: true,
    focusNode: FocusNode(),
    onKey: (event) {
      if (event is RawKeyDownEvent) { // Ensuring it fires only once per press
        if (event.logicalKey == LogicalKeyboardKey.keyD) {
            launchUrlString("https://www.figma.com/design/pXJzYIhRhaEgpSwTWWJUwJ/FIGMA-DESIGN-PORTFOLIO?node-id=0-1&t=SEmMpv3UIPOX52fu-0");
        } else if (event.logicalKey == LogicalKeyboardKey.keyC) {
            launchUrlString("https://github.com/himanshubalani");
        } else if (event.logicalKey == LogicalKeyboardKey.enter || 
                  event.logicalKey == LogicalKeyboardKey.numpadEnter) {
            Get.toNamed('/about');
        }
        }
      },
      child: Scaffold(
          backgroundColor: AppColors().black,
          appBar: const Appbar(),
          body: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
            if (constraints.maxWidth > 700) {
              return desktopHomepage();
            } else {
              return mobileHomepage();
            }
          }),
          bottomNavigationBar: const BottomBar(),
          floatingActionButton: getSocials(),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.miniEndFloat),
    );
  }

//  @override
// void initState() {
//   super.initState();
//   WidgetsBinding.instance.addPostFrameCallback((_) {
//     Get.snackbar(
//       "I'M OPEN TO WORK",
//       "I'm looking for full-time roles as a developer. Email me at hire@himanshubalani.com or click this button ➜",
//       shouldIconPulse: false,
//       snackPosition: SnackPosition.TOP,
//       margin: Get.width <= 900 ? EdgeInsets.only(top: 60.h, left: 20.w, right: 20.w) : EdgeInsets.only(top: 60.h, left: 50.w, right: 50.w),
//       maxWidth: Get.width <= 900 ? 400.w : 150.w,
//       backgroundColor: Colors.white,
//       colorText: AppColors().black,
//       borderColor: AppColors().black,
//       borderWidth: 3,
//       duration: const Duration(seconds: 10),
//       borderRadius: 10.r,
//       padding: Get.width <= 900 ? EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h) : EdgeInsets.symmetric(horizontal: 5.w, vertical: 5.h),
//       boxShadows: [
//         BoxShadow(
//           color: AppColors().black,
//           offset: Offset(5, 5),
//           blurRadius: 0,
//         ),
//       ],
//       isDismissible: true,
//       dismissDirection: DismissDirection.horizontal,
//       forwardAnimationCurve: Curves.easeOutBack,
//       reverseAnimationCurve: Curves.easeInBack,
//       barBlur: 10.0,
//       overlayBlur: 0.0,
//       mainButton: TextButton(
//   onPressed: () => launchUrlString('mailto:hire@himanshubalani.com'),
//   style: TextButton.styleFrom(
//     padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
//     backgroundColor: AppColors().deepSaffron,
//     shape: RoundedRectangleBorder(
//       borderRadius: BorderRadius.circular(10),
//       side: BorderSide(color: AppColors().black, width: 3),
//     ),
//     shadowColor: AppColors().black,
//     elevation: 0,
//   ).copyWith(
//     overlayColor: MaterialStateProperty.all(Colors.black.withOpacity(0.1)),
//   ),
//   child: Text(
//     'Hire Me',
//     style: TextStyle(
//       fontFamily: GoogleFonts.rubik().fontFamily,
//       color: AppColors().black,
//       fontSize: Get.width <= 900 ? 12.sp : 5.sp,
//       fontWeight: FontWeight.bold,
//     ),
//   ),
// ),

//     );
//   });
// }

  Widget desktopHomepage() {
    return Stack(
      children: [
        // const CustomSnackbarContainer(),
        Flex(
          direction: Axis.horizontal,
          children: [
            Expanded(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const HoverTextWidget(
                          mainText: 'Hello there, ',
                          smallText: 'General Kenobi',
                          textColor: Colors.white70,
                        ),
                        Text(
                          'I am ',
                          style: TextStyle(
                            fontSize: 10.sp,
                            color: Colors.white70,
                          ),
                        ),
                        DarkNeoBrutalContainer(
                          text: '   Himanshu Balani ↵',
                          path: '/about',
                          width: 100.w,
                          height: 25.w,
                          fontsize: 10.sp,
                          color: Colors.black,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10.w,
                    ),
                    mottoWid(
                      widfontsize: 5.sp,
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget mobileHomepage() {
    return Stack(
      children: [
        // const CustomSnackbarContainer(),
        Flex(
          direction: Axis.horizontal,
          children: [
            Expanded(
              flex: 1,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Hello, I am ',
                      style: TextStyle(
                        fontSize: 20.sp,
                      ),
                    ),
                    SizedBox(
                      height: 10.sp,
                    ),
                   DarkNeoBrutalContainer(
                      text: '  Himanshu Balani ↵',
                      path: '/about',
                      width: 300.w,
                      height: 75.w,
                      fontsize: 30.w,
                      color: Colors.white,
                    ),
                    SizedBox(
                      height: 25.h,
                    ),
                    mottoWid(widfontsize: 15.sp),
                  ],
                ),
              ),
            )
          ],
        ),
      ],
    );
  }

  Widget getSocials() {
    final socialLinks = [
      {
        'tooltip': 'Email',
        'icon': FontAwesomeIcons.envelope,
        'url':
            'https://mail.google.com/mail/u/0/?to=hello@himanshubalani.com&fs=1&tf=cm',
        'color': AppColors().email
      },
      {
        'tooltip': 'LinkedIn',
        'icon': FontAwesomeIcons.linkedinIn,
        'url': 'https://www.linkedin.com/in/himanshubalani/',
        'color': AppColors().linkedin
      },
      {
        'tooltip': 'Peerlist',
        'icon': SimpleIcons.peerlist,
        'url': 'https://www.peerlist.io/himanshubalani/',
        'color': AppColors().peerlist,
      },
      {
        'tooltip': 'Github',
        'icon': FontAwesomeIcons.github,
        'url': 'https://github.com/himanshubalani',
        'color': Colors.white70
      },
      {
        'tooltip': 'Twitter',
        'icon': FontAwesomeIcons.xTwitter,
        'url': 'https://twitter.com/himanshubalani5',
        'color': Colors.white70,
      },
    ];

    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: socialLinks
          .map((social) => Padding(
                padding: const EdgeInsets.all(4.0),
                child: OnHover(
                  builder: (bool isHovered) {
                    return IconButton(
                      padding: EdgeInsets.zero,
                      tooltip: social['tooltip'] as String?,
                      style: ButtonStyle(
    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
    ),
    padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
      const EdgeInsets.all(12.0),
    ),
   
                            backgroundColor: MaterialStateProperty.all<Color>(
                                Colors.black),
    side: MaterialStateProperty.all<BorderSide>(
      BorderSide(
        color: social['color'] as Color,
        width: 3.0,
      ),
    ),
                      ),
                      icon: Icon(
                        social['icon'] as IconData,
                        color: Colors.white70,
                        size: 5.w,
                      ),
                      onPressed: () =>
                          launchUrlString(social['url']! as String),
                    );
                  },
                ),
              ))
          .toList(),
    );
  }
}

class mottoWid extends StatelessWidget {
  final double widfontsize;

  const mottoWid({
    required this.widfontsize,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final fontsize = widfontsize;

    return Wrap(
      alignment: WrapAlignment.center,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        Text(
            'Sometimes',
            style: TextStyle(
              color: AppColors().white,
              fontSize: fontsize,
            ),
          ),
        GestureDetector(
    onTap: () {
      launchUrlString("https://www.figma.com/design/pXJzYIhRhaEgpSwTWWJUwJ/FIGMA-DESIGN-PORTFOLIO?node-id=0-1&t=SEmMpv3UIPOX52fu-0");
    },
    child: darkLanguageBox(text: 'Designing ᵈ', fontsize: fontsize),
  ),

        Text(
          'Sometimes',
          style: TextStyle(color: AppColors().white, fontSize: fontsize),
        ),
        GestureDetector(
    onTap: () {
      launchUrlString("https://github.com/himanshubalani");
    },
    child: darkLanguageBox(text: 'Coding ᶜ', fontsize: fontsize),),
        Text(
          'Always',
          style: TextStyle(color: AppColors().white, fontSize: fontsize),
        ),
        darkLanguageBox(text: 'Engineering', fontsize: fontsize)
      ]
          .map((e) => Padding(
                padding: const EdgeInsets.all(2.0),
                child: e,
              ))
          .toList(),
    );
  }
}
