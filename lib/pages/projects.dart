import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portfolio/consts/style.dart';
import 'package:portfolio/utils/appbar.dart';
import 'package:portfolio/widgets/animated_pill_bg.dart';
import 'package:portfolio/widgets/bottombar.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:portfolio/widgets/neobrutalcontainer.dart';

import '../widgets/projectcard.dart'; // Import the ProjectCard widget

class projects extends StatefulWidget {
  const projects({super.key});

  @override
  State<projects> createState() => _projectsState();
}

class _projectsState extends State<projects> {
  bool get isDark {
    final isLight = Theme.of(context).brightness == Brightness.light;
    return isLight;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: isDark ? AppColors().lightPeach : AppColors().black, // Use the lightPeach color
      appBar: const Appbar(),
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          if (constraints.maxWidth > 900) {
            return desktopProjectsPage();
          } else {
            return mobileProjectsPage();
          }
        },
      ),
      bottomNavigationBar: const BottomBar(),
    );
  }

  // Define the list of ProjectCard widgets
  final List<ProjectCard> projectCards = const [
    ProjectCard(
        projectName: "Technical Writing Portfolio",
        projectDescription: "All my writing working for ToolJet",
        imagePath: "assets/images/technical_writing.png",
        projectLink:
            "https://himanshubalani.com/tooljet?ref=portfolio&utm_medium=website&utm_source=himanshubalani.com",
        languages: ["Notion"],
        buttonText: "Open in Notion"),
    ProjectCard(
      projectName: "gogit",
      projectDescription:
          "Windows CLI scripts to open git remote urls in browsers",
      imagePath: "assets/images/gogit.png",
      projectLogo: "assets/images/gogit_logo.png",
      projectLink:
          "https://github.com/himanshubalani/gogit?ref=portfolio&utm_medium=website&utm_source=himanshubalani.com",
      languages: ["PowerShell", "Git", "CLI"],
      buttonText: "View on GitHub",
    ),
    ProjectCard(
      projectName: "Portfolio Website",
      projectDescription:
          "The website you are currently viewing. ;). It's responsive and optimized for web. Follows Accessibility standards and is built using Flutter Web.",
      imagePath: "assets/images/portfolio.png",
      projectLogo: "assets/images/favicon.webp",
      projectLink:
          "https://github.com/himanshubalani/himanshubalani.github.io?ref=portfolio&utm_medium=website&utm_source=himanshubalani.com",
      languages: ["Flutter", "Dart", "Figma", "GitHub"],
      buttonText: "View on GitHub",
    ),
    ProjectCard(
      projectName: "VEDAS",
      projectDescription:
          "A Flutter app built for distraction-free learning. It works on Android and iOS. Watch Ad-free Youtube Videos on topics you want to learn and read books in the app.",
      imagePath: "assets/images/vedas.png",
      projectLogo: "assets/images/vedas_logo.png",
      projectLink:
          "https://github.com/himanshubalani/vedas_flutter?ref=portfolio&utm_medium=website&utm_source=himanshubalani.com",
      languages: ["Flutter", "Dart", "Firebase", "Postman", "Rest APIs"],
      buttonText: "View on GitHub",
    ),
    ProjectCard(
      projectName: "Tilted",
      projectDescription:
          "Internship Project for Stardust IT Solutions. A companion app for games that tracks game sessions and put you in a leaderboard with friends.",
      imagePath: "assets/images/tilted.png",
      projectLink:
          "https://www.figma.com/design/Lu0dPyIInrvLpVOEtNeUWH/Untitled?node-id=0%3A1&t=PPOsy6Qmz4kPUkf3-1",
      languages: ["Flutter", "Dart", "Postman", "Rest APIs"],
      buttonText: "View Figma Design",
    ),
    ProjectCard(
      projectName: "Figma Design Portfolio",
      projectDescription:
          "A design portfolio containing all the presentations, logos and other designs I have made in my college years.",
      imagePath: "assets/images/figma.png",
      projectLink:
          "https://www.figma.com/design/pXJzYIhRhaEgpSwTWWJUwJ/FIGMA-DESIGN-PORTFOLIO?node-id=0-1&t=SEmMpv3UIPOX52fu-0",
      languages: ["Figma", "UI/UX"],
      buttonText: "View Figma Design",
    ),
  ];

  Widget desktopProjectsPage() {
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
                color: AppColors().rustyOrange,
                duration: const Duration(seconds: 4),
              ),
              SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Center(
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width / 1.7,
                    child: Column(
                      children: [
                        SizedBox(height: 10.w),
                        StaggeredGrid.count(
                          crossAxisCount: 2,
                          mainAxisSpacing: 8,
                          crossAxisSpacing: 8,
                          children: projectCards
                              .map((e) => StaggeredGridTile.fit(
                                    crossAxisCellCount: 1,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8),
                                      child: e,
                                    ),
                                  ))
                              .toList(),
                        ),
                        SizedBox(height: 10.w),
                        Text(
                          'more on the way....',
                          style: TextStyle(
                            fontSize: MediaQuery.of(context).size.width <= 900
                                ? 12.w
                                : 5.w,
                            fontFamily: GoogleFonts.quicksand(
                                    fontWeight: FontWeight.bold)
                                .fontFamily,
                            fontWeight: FontWeight.bold,
                            color: isDark ? Colors.black : Colors.white,
                          ),
                        ),
                        SizedBox(height: 10.w),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 0,
                top: MediaQuery.of(context).size.height / 2.5,
                child: Transform.rotate(
                  angle: -pi / 2,
                  child: Text(
                    'projects',
                    style: TextStyle(
                      fontFamily:
                          GoogleFonts.quicksand(fontWeight: FontWeight.bold)
                              .fontFamily,
                      fontSize: 25.w,
                      fontWeight: FontWeight.bold,
                      color: isDark ? Colors.black : AppColors().lightPeach,
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

  Widget mobileProjectsPage() {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              'projects',
              style: TextStyle(
                fontSize: 50.spMin,
                fontFamily: GoogleFonts.quicksand(fontWeight: FontWeight.bold)
                    .fontFamily,
                fontWeight: FontWeight.bold,
                color: isDark ? Colors.black : AppColors().lightPeach),
              ),
            Column(
              children: projectCards
                  .map((e) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 12.0),
                        child: e,
                      ))
                  .toList(),
            ),
            SizedBox(height: 10.w),
            NeoBrutalContainer(
                text: "learn more about me",
                width: 250.w,
                height: 50.w,
                fontsize: 20.sp,
                path: '/about',
                color: AppColors().skyBlue),
            NeoBrutalContainer(
                text: "find me on socials",
                width: 250.w,
                height: 50.w,
                fontsize: 20.sp,
                path: '/socials',
                color: AppColors().lightPink),
            SizedBox(height: 10.w),
            Text(
              'more on the way....',
              style: TextStyle(
                fontSize: MediaQuery.of(context).size.width <= 900 ? 12.w : 5.w,
                fontFamily: GoogleFonts.quicksand(fontWeight: FontWeight.bold)
                    .fontFamily,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ]
              .map(
                  (e) => Padding(padding: const EdgeInsets.all(12.0), child: e))
              .toList(),
        ),
      ),
    );
  }
}
