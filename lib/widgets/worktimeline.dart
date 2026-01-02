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
      /*required this.description, */ required this.techstack});

  final String companyname;
  final String role;
  final String duration;
  final String techstack;
  // final String description;
  final width;
  final onTap;
  final Color color;

  @override
  Widget build(BuildContext context) {
//    double descfontsize = MediaQuery.of(context).size.width <= 900 ? 12.w : 5.w;
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
            color: color,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(
              color: Colors.black, // Border color
              width: 3.0, // Border width
            ),
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
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  companyname,
                  style: TextStyle(
                      fontSize: companyfontsize,
                      fontFamily: fontFamily,
                      fontWeight: FontWeight.w600),
                      
                ),
                Text(
                  duration,
                  style: TextStyle(
                      fontSize: durationfontsize,
                      fontFamily: fontFamily,
                      fontWeight: FontWeight.w400),
                ),
                Text(techstack,
                    style: TextStyle(
                      fontSize: durationfontsize,
                      fontFamily: fontFamily,
                      fontWeight: FontWeight.w600,
                    )),
                /* Text(
                  description,
                  softWrap: true,
                  style: TextStyle(
                      fontSize: descfontsize,
                      fontFamily: fontFamily,
                      fontWeight: FontWeight.w100
                  ),
                ) */
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
    List<TimelineModel> items = [
      TimelineModel(workExpFour(),
          position: TimelineItemPosition.random,
          iconBackground: AppColors().toolJetBlue,
          icon: const Icon(Icons.edit_note_rounded)),
      TimelineModel(workExpThree(),
          position: TimelineItemPosition.random,
          iconBackground: AppColors().darkPurple,
          icon: const Icon(Icons.flutter_dash)),
      TimelineModel(workExpTwo(),
          position: TimelineItemPosition.random,
          iconBackground: AppColors().rustyOrange,
          icon: const Icon(Icons.api)),
      TimelineModel(workExpOne(),
          position: TimelineItemPosition.random,
          iconBackground: AppColors().darkRed,
          icon: const Icon(Icons.flutter_dash)),
    ];
    return Timeline(
      children: items,
      position: TimelinePosition.Left,
    );
  }
}

Widget workExpOne() {
  return WorkExpContainer(
      companyname: 'First Impression Technologies',
      role: 'Flutter Developer Intern',
      duration: 'Nov 2021 - Feb 2022',
      techstack: 'Tech Stack: Flutter, Dart',
      // description: '• Designed and created a quiz game targeted toward 3-5 year olds using the Flutter framework.'
      //     '\n• Researched and improved the engagement to better suit the UI/UX of the app by 60%.'
      //     '\n• Included over 10 audio and visual cues to achieve 80% user-engagement.',
      width: 600,
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
    // description:'• Acquired knowledge on APIs and their various applications.'
    //     '\n• Developed a functional web application using Nodejs, Expressjs, and MongoDB.'
    //     '\n• Authored 3 insightful technical blog posts documenting the entire fellowship experience.',
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
    // description: '•Converting Figma design into Flutter UI prototypes, ensuring accurate visual representation.'
    //     '\n• Enhanced application efficiency by 20% through the implementation of Getx State Management.'
    //     '\n• Optimized data retrieval with REST APIs.'
    //     '\n• Contributed to three high-quality projects, showcasing teamwork and project management skills.',
    color: AppColors().lightLavender,
  );
}

Widget workExpFour() {
  return WorkExpContainer(
    companyname: 'ToolJet',
    role: 'Technical Contert Writer Intern  ↗',
    duration: 'Oct 2024 - Jan 2025',
    techstack: 'Google Docs, Markdown, Research, SEO, Content Writing, User Experience',
    // description: '• Wrote 10+ Articles on various topics like low-code, tools, and using ToolJet'
    //     '\n• Conducted in-depth research on leadaing competitors to create high-quality content.'
    //     '\n• Optimized articles and revamped them for SEO to increase organic traffic by 20%.',
    color: AppColors().royalBlue,
    onTap: () => launchUrlString(
        'https://himanshubalani.notion.site/My-Work-ToolJet-15022caf97e080d6850dd24468de50f7?pvs=4'),
  );
}
