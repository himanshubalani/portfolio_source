import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portfolio/consts/style.dart';
import 'package:timeline_list/timeline_list.dart';
import 'package:url_launcher/url_launcher_string.dart';

class WorkExpContainer extends StatelessWidget {
  const WorkExpContainer({
    super.key,
    required this.companyname,
    this.width, // Nullable: Let the parent decide the width
    this.onTap,
    required this.color,
    required this.role,
    required this.duration,
    required this.techstack,
  });

  final String companyname;
  final String role;
  final String duration;
  final String techstack;
  final double? width;
  final VoidCallback? onTap;
  final Color color;

  @override
  Widget build(BuildContext context) {
    // 1. Determine Theme State
    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    final Color bgColor = isDark ? AppColors.black : color;
    final Color borderColor = isDark ? color : AppColors.black;
    final Color textColor = isDark ? color : AppColors.black;

    // Adjusted font sizes slightly for better wrapping on mobile
    double rolefontsize = MediaQuery.of(context).size.width <= 900 ? 12.sp : 5.sp;
    double companyfontsize = MediaQuery.of(context).size.width <= 900 ? 10.sp : 4.sp;
    double durationfontsize = MediaQuery.of(context).size.width <= 900 ? 9.sp : 3.5.sp;
    
    var fontFamily = GoogleFonts.outfit().fontFamily;

    return InkWell(
      onTap: onTap,
      child: Container(
        width: width ?? double.infinity, // If null, it fills available space
        constraints: BoxConstraints(
    maxWidth: MediaQuery.of(context).size.width <= 900
        ? 200.w
        : MediaQuery.of(context).size.width / 3.8, // mobile : desktop
          ),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: borderColor,
            width: 3.0,
          ),
          boxShadow: isDark
              ? [
                  BoxShadow(
                      color: borderColor.withValues(alpha: 0.3),
                      blurRadius: 0,
                      offset: const Offset(4, 4))
                ]
              : null,
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0), // Increased padding slightly
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                role,
                softWrap: true,
                style: TextStyle(
                    fontSize: rolefontsize,
                    fontFamily: fontFamily,
                    color: textColor,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 4),
              Text(
                companyname,
                softWrap: true,
                style: TextStyle(
                    fontSize: companyfontsize,
                    fontFamily: fontFamily,
                    color: textColor,
                    fontWeight: FontWeight.w600),
              ),
              Text(
                duration,
                softWrap: true,
                style: TextStyle(
                    fontSize: durationfontsize,
                    fontFamily: fontFamily,
                    color: textColor,
                    fontWeight: FontWeight.w400),
              ),
              const SizedBox(height: 4),
              Text(
                techstack,
                softWrap: true,
                style: TextStyle(
                  fontSize: durationfontsize,
                  fontFamily: fontFamily,
                  color: textColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class WorkTimeline extends StatelessWidget {
  const WorkTimeline({
    super.key,
  });

  // Helper to build the dot icon
  Widget _buildTimelineIcon(Color bgColor, IconData iconData) {
    return Container(
      width: 30, // Reduced slightly to fit tighter layouts
      height: 30,
      decoration: BoxDecoration(
        color: bgColor,
        shape: BoxShape.circle,
      ),
      child: Icon(iconData, color: Colors.white, size: 16),
    );
  }

  @override
  Widget build(BuildContext context) {
    List<Marker> items = [
      Marker(
        child: workExpFour(),
        icon: _buildTimelineIcon(AppColors.toolJetBlue, Icons.edit_note_rounded),
      ),
      Marker(
        child: workExpThree(),
        icon: _buildTimelineIcon(AppColors.darkPurple, Icons.flutter_dash),
      ),
      Marker(
        child: workExpTwo(),
        icon: _buildTimelineIcon(AppColors.rustyOrange, Icons.api),
      ),
      Marker(
        child: workExpOne(),
        icon: _buildTimelineIcon(AppColors.darkRed, Icons.flutter_dash),
      ),
    ];

    return Timeline(
      children: items,
      properties: TimelineProperties(
        timelinePosition: TimelinePosition.start,
        iconSize: 30, // Matches the container size above
        iconGap: 12,  // Adds space between the dot and the card
        lineColor: Theme.of(context).brightness == Brightness.dark
            ? Colors.white
            : Colors.black,
      ),
    );
  }
}


Widget workExpOne() {
  return WorkExpContainer(
    companyname: 'First Impression Technologies',
    role: 'Flutter Developer Intern  ↗',
    duration: 'Nov 2021 - Feb 2022',
    techstack: 'Tech Stack: Flutter, Dart, Java, Android Studio, Firebase',
    // Removed width: 600.0
    color: AppColors.lightPeach,
    onTap: () => launchUrlString(
        'https://www.linkedin.com/company/first-impression-technologies/about/'),
  );
}

Widget workExpTwo() {
  return WorkExpContainer(
    companyname: 'Keploy',
    role: 'API Fellowhship / Keploy Ninja   ↗',
    duration: 'Jan 2023 - Mar 2023',
    techstack:
        'Tech Stack: Nodejs, Expressjs, MongoDB, REST APIs, Git, Postman',
    color: AppColors.paleYellow,
    onTap: () => launchUrlString(
        'https://himanshubalani.hashnode.dev/my-experience-with-keploy-api-fellowship'),
  );
}

Widget workExpThree() {
  return const WorkExpContainer(
    companyname: 'Stardust IT Solutions',
    role: 'Flutter Developer Intern',
    duration: 'Sep 2023 - Nov 2023',
    techstack:
        'Tech Stack: Flutter, Dart, Figma, REST APIs, Git, Getx State Management',
    color: AppColors.lightLavender,
  );
}

Widget workExpFour() {
  return WorkExpContainer(
    companyname: 'ToolJet',
    role: 'Technical Content Writer Intern  ↗',
    duration: 'Oct 2024 - Jan 2025',
    techstack:
        'Google Docs, Markdown, Research, SEO, Content Writing, User Experience',
    color: AppColors.royalBlue,
    onTap: () => launchUrlString(
        'https://himanshubalani.notion.site/My-Work-ToolJet-15022caf97e080d6850dd24468de50f7?pvs=4'),
  );
}