import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portfolio/consts/style.dart';
import 'package:portfolio/utils/appbar.dart';
import 'package:portfolio/widgets/animated_pill_bg.dart';
import 'package:portfolio/widgets/neobrutalbox.dart';
import 'package:portfolio/widgets/neobrutalcontainer.dart';
import 'package:portfolio/widgets/profileimage.dart';
import 'package:portfolio/widgets/skillsbento.dart';
import 'package:simple_icons/simple_icons.dart';
import 'package:portfolio/widgets/socialbox.dart';
import '../widgets/bottombar.dart';
import '../widgets/worktimeline.dart';

class AboutPage extends StatefulWidget {
  const AboutPage({super.key});

  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).brightness == Brightness.light
              ? AppColors().skyBlue
              : AppColors().black,
      appBar: const Appbar(),
      body: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
        if (constraints.maxWidth > 900) {
          return desktopAboutpage();
        } else {
          return mobileAboutpage();
        }
      }),
      bottomNavigationBar: const BottomBar(),
    );
  }

  Widget desktopAboutpage() {
    return Flex(
      direction: Axis.vertical,
      children: [
        Expanded(
          flex: 1,
          child: Stack(
            children: [
              AnimatedPillsBackground(
                rows: 10,
                columns: 24,
                color: AppColors().toolJetBlue.withOpacity(0.2),
                duration: const Duration(seconds: 4),
              ),
              SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 10.w),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            //_headDesc(),
                            _aboutDesc(),
                          ]
                              .map((e) => Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: e))
                              .toList(),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const ProfileImage(),
                            RepaintBoundary(
                              child: NeoBrutalContainer(
                                text: 'let\'s chat',
                                width: 60.w,
                                height: 15.w,
                                fontsize: 8.w,
                                color: AppColors().lightPink,
                                path: '/socials',
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 10.w),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          children: [
                            IntrinsicWidth(child: SkillsBento()),
                            SizedBox(
                              width: 120.w,
                              child: const OtherLinks(),
                            ),
                          ]
                              .map((e) => Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: e))
                              .toList(),
                        ),
                        Container(
                          constraints: BoxConstraints(
                            maxWidth: MediaQuery.of(context).size.width <= 900
                                ? 300
                                : MediaQuery.of(context).size.width / 2.8,
                          ),
                          child: NeoBrutalBox(
                              headerText: 'work experience',
                              headerColor: Colors.indigoAccent,
                              containerChild: Container(
                                  constraints: BoxConstraints(
                                    maxHeight: MediaQuery.of(context)
                                                .size
                                                .width <=
                                            1000
                                        ? 300.w
                                        : MediaQuery.of(context).size.width /
                                            2.1,
                                    maxWidth: MediaQuery.of(context)
                                                .size
                                                .width <=
                                            1000
                                        ? 300.w
                                        : MediaQuery.of(context).size.width /
                                            2.6,
                                  ),
                                  child: const RepaintBoundary(
                                      child: WorkTimeline()))),
                        ),
                      ]
                          .map((e) => Padding(
                              padding: const EdgeInsets.all(12.0), child: e))
                          .toList(),
                    ),
                    SizedBox(height: 10.w),
                  ],
                ),
              ),
              Positioned(
                left: 0,
                top: MediaQuery.of(context).size.height / 2.5,
                child: Transform.rotate(
                  angle: -pi / 2, // Rotate 90 degrees clockwise
                  child: Text(
                    "about",
                    style: TextStyle(
                      fontFamily:
                          GoogleFonts.quicksand(fontWeight: FontWeight.bold)
                              .fontFamily,
                      fontSize: MediaQuery.of(context).size.width <= 900
                          ? 50.w
                          : 25.w,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
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

  Widget mobileAboutpage() {
    return Stack(
            children: [
              AnimatedPillsBackground(
                rows: 10,
                columns: 24,
                color: AppColors().skyBlue,
                duration: const Duration(seconds: 4),
              ),
              SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'about',
                style: TextStyle(
                    fontFamily:
                        GoogleFonts.quicksand(fontWeight: FontWeight.bold)
                            .fontFamily,
                    fontSize: 50.spMin,
                    color: Colors.black),
              ),
              ProfileImage(),
              NeoBrutalContainer(
                  text: "let's chat",
                  width: 150.w,
                  height: 50.w,
                  fontsize: 20.sp,
                  path: '/socials',
                  color: AppColors().lightPink),
              _aboutDesc(),
              RepaintBoundary(child: SkillsBento()),
              SizedBox(height: 10.w),
              const OtherLinks(),
              SizedBox(height: 10.w),
              Container(
                constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width <= 900
                      ? 300.w
                      : MediaQuery.of(context).size.width / 2.8,
                ),
                child: NeoBrutalBox(
                    headerText: 'work experience',
                    headerColor: Colors.blueAccent,
                    containerChild: Container(
                        color: Colors.white,
                        constraints: BoxConstraints(
                          maxHeight: MediaQuery.of(context).size.height / 1.6,
                        ),
                        child: const RepaintBoundary(child: WorkTimeline()))),
              ),
              SizedBox(height: 10.w),
              NeoBrutalContainer(
                  text: "see projects next",
                  width: 250.w,
                  height: 50.w,
                  fontsize: 20.sp,
                  path: '/projects',
                  color: AppColors().lightPeach),
              SizedBox(height: 10.w),
            ]
                .map((e) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 6.0),
                    child: e))
                .toList(),
          ),
        ))
            ],
          );
  }

  Widget _aboutDesc() {
    return Container(
      constraints: BoxConstraints(
        maxWidth: MediaQuery.of(context).size.width <= 900
            ? 350.w
            : MediaQuery.of(context).size.width / 2.0,
      ),
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          NeoBrutalBox(
            headerText: "about me",
            headerColor: Colors.redAccent,
            containerChild: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                return Text(
                  '''I'm Himanshu Balani, a Computer Science graduate from India. I love building random tools that help my work. My most recent job was to write SEO ranking content for ToolJet, where I did a dive deep into working with their platform and wrote over 10 blogs for them. I "try" to maintain a personal blog where I share what I learn along the way too. Feel free to check it out! I also love interacting with folks and have been a speaker 4 times. Things I enjoy: astronomy, physics, computers and finding out how things work under the hood. If you're into building cool things or just want to chat about tech, please reach out!''',
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontSize: Get.width <= 900 ? 12.sp : 4.sp,
                    fontWeight: FontWeight.normal,
                    fontFamily: GoogleFonts.rubik().fontFamily,
                    color: Theme.of(context).brightness == Brightness.dark
                        ? Colors.white
                        : Colors.black,
                    height: 1.8,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget profileimage() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Container(
        decoration: AppStyles().neoContainerDecorationOne(),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Container(
            constraints: const BoxConstraints(
              maxWidth: 300,
              maxHeight: 300,
            ),
            decoration: AppStyles().neoContainerDecorationTwo(),
            child: Image.asset(
              'assets/images/profileimage.webp',
              fit: BoxFit.cover,
              cacheWidth: MediaQuery.of(context).size.width <= 900
                  ? 250
                  : 375, //mobile : desktop
            ),
          ),
        ),
      ),
    );
  }
}

class OtherLinks extends StatelessWidget {
  const OtherLinks({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: Get.width <= 900 ? 4 : 12,
      runSpacing:  Get.width <= 900 ? 4 : 15,
      runAlignment: WrapAlignment.end,
      crossAxisAlignment: WrapCrossAlignment.center,
      alignment: WrapAlignment.end,
      children: [
                sociallinkbutton(link: "https://album.himanshubalani.com?utm_source=portfolio", icon: FontAwesomeIcons.recordVinyl, pfname: "photo album", pfcolor: AppColors().darkPurple, vmainaxissize: MainAxisSize.min),
        sociallinkbutton(
          link:
              'https://himanshubalani.notion.site/187decd95c4c4197ad2cd8053cb85b80?v=ee7f6c0db0044487964238ffc2589b29&ref=portfolio&utm_medium=website',
          icon: SimpleIcons.notion,
          pfname: 'list of events   ',
          pfcolor: AppColors().black,
          vmainaxissize: MainAxisSize.min,
        ),
        sociallinkbutton(
          link:
              'https://sessionize.com/himanshubalani/?ref=portfolio&utm_medium=website',
          icon: SimpleIcons.sessionize,
          pfname: 'talks ',
          pfcolor: AppColors().sessionize,
          vmainaxissize: MainAxisSize.min,
        ),
        sociallinkbutton(
          link: "https://doi.org/10.1063/5.0234110?ref=portfolio&utm_medium=website",
          icon: SimpleIcons.orcid,
          pfname: 'published thesis on LLMs',
          pfcolor: AppColors().orchid,
          vmainaxissize: MainAxisSize.min,
        ),

      ],
    );
  }
}
