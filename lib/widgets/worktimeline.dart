import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portfolio/consts/style.dart';
import 'package:timeline_list/timeline.dart';
import 'package:timeline_list/timeline_model.dart';
import 'package:url_launcher/url_launcher_string.dart';

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
  final double? width; // Fixed type to double?
  final VoidCallback? onTap; // Fixed type to VoidCallback?
  final Color color;

  @override
  Widget build(BuildContext context) {
    // 1. Determine Theme State
    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    // 2. Define Dynamic Colors
    // Light Mode: Color BG, Black Border, Black Text
    // Dark Mode: Black BG, Color Border, Color Text
    final Color bgColor = isDark ? AppColors().black : color;
    final Color borderColor = isDark ? color : Colors.black;
    final Color textColor = isDark ? color : Colors.black;

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
            color: bgColor, // Dynamic Background
            borderRadius: BorderRadius.circular(18),
            border: Border.all(
              color: borderColor, // Dynamic Border
              width: 3.0,
            ),
             // Optional: Add shadow matching the border for extra pop in dark mode
             boxShadow: isDark
                ? [BoxShadow(color: borderColor.withOpacity(0.3), blurRadius: 0, offset: const Offset(4, 4))]
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
                      color: textColor, // Dynamic Text Color
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  companyname,
                  style: TextStyle(
                      fontSize: companyfontsize,
                      fontFamily: fontFamily,
                      color: textColor, // Dynamic Text Color
                      fontWeight: FontWeight.w600),
                ),
                Text(
                  duration,
                  style: TextStyle(
                      fontSize: durationfontsize,
                      fontFamily: fontFamily,
                      color: textColor, // Dynamic Text Color
                      fontWeight: FontWeight.w400),
                ),
                Text(techstack,
                    style: TextStyle(
                      fontSize: durationfontsize,
                      fontFamily: fontFamily,
                      color: textColor, // Dynamic Text Color
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

  @override
  Widget build(BuildContext context) {
    // Note: timeline_list handles the central line. 
    // The "color" passed here is used for the dot background. 
    // In dark mode, having colorful dots on a dark timeline looks good, 
    // so we keep AppColors() as is.
    
    List<TimelineModel> items = [
      TimelineModel(workExpFour(),
          position: TimelineItemPosition.random,
          iconBackground: AppColors().toolJetBlue,
          icon: const Icon(Icons.edit_note_rounded, color: Colors.white)),
      TimelineModel(workExpThree(),
          position: TimelineItemPosition.random,
          iconBackground: AppColors().darkPurple,
          icon: const Icon(Icons.flutter_dash, color: Colors.white)),
      TimelineModel(workExpTwo(),
          position: TimelineItemPosition.random,
          iconBackground: AppColors().rustyOrange,
          icon: const Icon(Icons.api, color: Colors.white)),
      TimelineModel(workExpOne(),
          position: TimelineItemPosition.random,
          iconBackground: AppColors().darkRed,
          icon: const Icon(Icons.flutter_dash, color: Colors.white)),
    ];
    return Timeline(
      children: items,
      position: TimelinePosition.Left,
      // Optional: You might want to customize the lineColor if the library supports it
      lineColor: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black,
    );
  }
}

// Helper functions remain the same, they just pass the data
// The coloring logic is now handled inside WorkExpContainer's build method

Widget workExpOne() {
  return WorkExpContainer(
      companyname: 'First Impression Technologies',
      role: 'Flutter Developer Intern',
      duration: 'Nov 2021 - Feb 2022',
      techstack: 'Tech Stack: Flutter, Dart',
      width: 600.0,
      color: AppColors().lightPeach,
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
    color: AppColors().paleYellow,
    onTap: () => launchUrlString(
        'https://himanshubalani.hashnode.dev/my-experience-with-keploy-api-fellowship'),
  );
}

Widget workExpThree() {
  return WorkExpContainer(
    companyname: 'Stardust IT Solutions',
    role: 'Flutter Developer Intern',
    duration: 'Sep 2023 - Nov 2023',
    techstack:
        'Tech Stack: Flutter, Dart, Figma, REST APIs, Git, Getx State Management',
    color: AppColors().lightLavender,
  );
}

Widget workExpFour() {
  return WorkExpContainer(
    companyname: 'ToolJet',
    role: 'Technical Contert Writer Intern  ↗',
    duration: 'Oct 2024 - Jan 2025',
    techstack: 'Google Docs, Markdown, Research, SEO, Content Writing, User Experience',
    color: AppColors().royalBlue,
    onTap: () => launchUrlString(
        'https://himanshubalani.notion.site/My-Work-ToolJet-15022caf97e080d6850dd24468de50f7?pvs=4'),
  );
}
