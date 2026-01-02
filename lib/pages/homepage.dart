import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:portfolio/consts/style.dart';
import 'package:portfolio/presentation/easteregg.dart';
import 'package:portfolio/widgets/languagebox.dart';
import 'package:portfolio/widgets/neobrutalcontainer.dart';
import 'package:portfolio/widgets/animated_pill_bg.dart';
import 'package:portfolio/widgets/shortcuts_text.dart';
import 'package:simple_icons/simple_icons.dart';
import 'package:url_launcher/url_launcher_string.dart';
import '../presentation/onhover.dart';
import '../utils/appbar.dart';
import '../widgets/bottombar.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    return RawKeyboardListener(
      autofocus: true,
      focusNode: FocusNode(),
      onKey: (event) {
        if (event is RawKeyDownEvent) {
          // Ensuring it fires only once per press
          if (event.logicalKey == LogicalKeyboardKey.keyD) {
            launchUrlString(
                "https://www.figma.com/design/pXJzYIhRhaEgpSwTWWJUwJ/FIGMA-DESIGN-PORTFOLIO?node-id=0-1&t=SEmMpv3UIPOX52fu-0");
          } else if (event.logicalKey == LogicalKeyboardKey.keyC) {
            launchUrlString("https://github.com/himanshubalani");
          } else if (event.logicalKey == LogicalKeyboardKey.enter ||
              event.logicalKey == LogicalKeyboardKey.numpadEnter) {
            Get.toNamed('/about');
          }
          // Add navmenu / key to open showshortcutmenu
        }
      },
      child: Scaffold(
          backgroundColor: Theme.of(context).brightness == Brightness.light
              ? AppColors().primaryPurple
              : AppColors().black,
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
//       fontFamily: kfontfamilyontFamily,
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
    var kfontfamily = GoogleFonts.outfit(fontWeight: FontWeight.bold).fontFamily;
    return Stack(
      children: [
        // const CustomSnackbarContainer(),
        Positioned(
  bottom: 15.h,
  left: -1,
  child: const ShortcutsText(),
),
AnimatedPillsBackground(
          rows: 10,
          columns: 24,
          color: AppColors().discord,
          duration: const Duration(seconds: 4),
        ),
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
                        HoverTextWidget(
                          mainText: 'Hello there, ',
                          smallText: 'General Kenobi',
                          textColor:
                              Theme.of(context).brightness == Brightness.light
                                  ? AppColors().black
                                  : AppColors().white,
                        ),
                        Text(
                          'I am ',
                          style: TextStyle(
                            fontFamily: kfontfamily,
                            fontSize: 10.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        NeoBrutalContainer(
                          text: '   Himanshu Balani ↵',
                          path: '/about',
                          width: 100.w,
                            height: 25.w,
                            fontsize: 10.sp,
                            color: Theme.of(context).brightness == Brightness.light
                                ? AppColors().white
                                : AppColors().primaryPurple,
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
              AnimatedPillsBackground(
                rows: 10,
                columns: 24,
                color: AppColors().discord,
                duration: const Duration(seconds: 4),
              ),
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
                        fontFamily: GoogleFonts.outfit(fontWeight: FontWeight.bold).fontFamily,
                        fontSize: 20.sp,
                      ),
                    ),
                    SizedBox(
                      height: 10.sp,
                    ),
                    NeoBrutalContainer(
                        text: '  Himanshu Balani ↵',
                        path: '/about',
                        width: 300.w,
                        height: 75.w,
                        fontsize: 30.w,
                        color: Theme.of(context).brightness == Brightness.light
                                ? AppColors().white
                                : AppColors().primaryPurple,
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
        'tooltip': 'Github',
        'icon': FontAwesomeIcons.github,
        'url': 'https://github.com/himanshubalani',
        'color': Colors.black
      },
      {
        'tooltip': 'Peerlist',
        'icon': SimpleIcons.peerlist,
        'url': 'https://www.peerlist.io/himanshubalani/',
        'color': AppColors().peerlist,
      },
      {
        'tooltip': 'LinkedIn',
        'icon': FontAwesomeIcons.linkedinIn,
        'url': 'https://www.linkedin.com/in/himanshubalani/',
        'color': AppColors().linkedin
      },
      {
        'tooltip': 'Twitter',
        'icon': FontAwesomeIcons.xTwitter,
        'url': 'https://twitter.com/himanshubalani5',
        'color': AppColors().xtwitter
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
                      style: AppStyles().socialIconStyle.copyWith(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                social['color'] as Color),
                          ),
                      icon: Icon(
                        social['icon'] as IconData,
                        color: Colors.white,
                        size: 15.w.clamp(18, 24),
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
    TextStyle mottotextStyle = TextStyle(
      fontFamily: GoogleFonts.outfit().fontFamily,
      fontSize: fontsize,
      fontWeight: FontWeight.bold,
      color: Theme.of(context).brightness == Brightness.light
          ? AppColors().black
          : AppColors().white,
    );

    return Wrap(
      alignment: WrapAlignment.center,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        Text(
          'Sometimes',
          style: mottotextStyle,
        ),
        GestureDetector(
          onTap: () {
            launchUrlString(
                "https://www.figma.com/design/pXJzYIhRhaEgpSwTWWJUwJ/FIGMA-DESIGN-PORTFOLIO?node-id=0-1&t=SEmMpv3UIPOX52fu-0");
          },
          child: MouseRegion(
              cursor: SystemMouseCursors.click,
              child: LanguageBox(text: 'Designing ᵈ', fontsize: fontsize)),
        ),
        Text(
          'Sometimes',
          style: mottotextStyle,
        ),
        GestureDetector(
          onTap: () {
            launchUrlString("https://github.com/himanshubalani");
          },
          child: MouseRegion(
              cursor: SystemMouseCursors.click,
              child: LanguageBox(text: 'Coding ᶜ', fontsize: fontsize)),
        ),
        Text(
          'Always',
          style: mottotextStyle,
        ),
        LanguageBox(text: 'Engineering', fontsize: fontsize)
      ]
          .map((e) => Padding(
                padding: const EdgeInsets.all(2.0),
                child: e,
              ))
          .toList(),
    );
  }
}