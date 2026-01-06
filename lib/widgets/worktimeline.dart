import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portfolio/consts/style.dart';
import 'package:timeline_list/timeline_list.dart';
import 'package:url_launcher/url_launcher_string.dart';

// WorkExpContainer remains exactly the same as your original code
class WorkExpContainer extends StatelessWidget {
  const WorkExpContainer(
      {super.key,
      required this.companyname,
      this.width,
      this.onTap,
      required this.color,
      required this.role,
      required this.duration,
      required this.techstack});

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

    double rolefontsize = MediaQuery.of(context).size.width <= 900 ? 14.w : 6.w;
    double companyfontsize =
        MediaQuery.of(context).size.width <= 900 ? 12.w : 5.w;
    double durationfontsize =
        MediaQuery.of(context).size.width <= 900 ? 10.w : 4.w;
    var fontFamily = GoogleFonts.outfit().fontFamily;

    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: InkWell(
        onTap: onTap,
        child: Container(
          width: width,
          constraints: const BoxConstraints(
            maxWidth: 900,
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
            padding: const EdgeInsets.all(8.0),
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
                Text(
                  companyname,
                  style: TextStyle(
                      fontSize: companyfontsize,
                      fontFamily: fontFamily,
                      color: textColor,
                      fontWeight: FontWeight.w600),
                ),
                Text(
                  duration,
                  style: TextStyle(
                      fontSize: durationfontsize,
                      fontFamily: fontFamily,
                      color: textColor,
                      fontWeight: FontWeight.w400),
                ),
                Text(techstack,
                    style: TextStyle(
                      fontSize: durationfontsize,
                      fontFamily: fontFamily,
                      color: textColor,
                      fontWeight: FontWeight.w600,
                    )),
              ]
                  .map((e) =>
                      Padding(padding: const EdgeInsets.all(2.0), child: e))
                  .toList(),
            ),
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

  // Helper method to create the styled icon (replaces iconBackground)
  Widget _buildTimelineIcon(Color bgColor, IconData iconData) {
    return Container(
      width: 40, 
      height: 40,
      decoration: BoxDecoration(
        color: bgColor,
        shape: BoxShape.circle,
      ),
      child: Icon(iconData, color: Colors.white, size: 20),
    );
  }

  @override
  Widget build(BuildContext context) {
    // UPDATED: Changed List<TimelineModel> to List<Marker>
    List<Marker> items = [
      Marker(
        child: workExpFour(),
        // Updated: Manually building the icon container
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
        // 'start' puts the line on the left.
        // If you want a center line, change this to TimelinePosition.center
        timelinePosition: TimelinePosition.start, 
        iconSize: 40, // Ensures the icon fits the container size defined above
        lineColor: Theme.of(context).brightness == Brightness.dark
            ? Colors.white
            : Colors.black,
      ),
    ); // Fixed: Missing closing parenthesis and semicolon here
  }
}

// Helper functions (Unchanged)
Widget workExpOne() {
  return WorkExpContainer(
      companyname: 'First Impression Technologies',
      role: 'Flutter Developer Intern',
      duration: 'Nov 2021 - Feb 2022',
      techstack: 'Tech Stack: Flutter, Dart',
      width: 600.0,
      color: AppColors.lightPeach,
      onTap: () => launchUrlString(
          'https://www.linkedin.com/company/first-impression-technologies/about/'));
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
