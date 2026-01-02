import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:portfolio/pages/about.dart';
import 'package:portfolio/pages/homepage.dart';
import 'package:portfolio/presentation/desktopappbar.dart';
import 'package:portfolio/presentation/easteregg.dart';
import 'package:portfolio/presentation/mobileappbar.dart';
import 'package:portfolio/widgets/bottombar.dart';
import 'package:portfolio/widgets/neobrutalcontainer.dart';

class testpage extends StatefulWidget {
  const testpage({super.key});

  @override
  State<testpage> createState() => _testpageState();
}

class _testpageState extends State<testpage> {
  @override
  Widget build(BuildContext context) {
    ScrollController scrollController = ScrollController();
    return Scaffold(
      backgroundColor: const Color(0x0090a8ed),
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60.0),
          child: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
            if (constraints.maxWidth > 600) {
              return const DesktopAppbar();
            } else {
              return const MobileAppbar();
            }
          })),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: ListView(
          controller: scrollController,
          children: const [
            // Your content sections (About, Projects, Contact) go here
            HomePage(),
            AboutPage(),
          ],
        ),
      ),
      bottomNavigationBar: const BottomBar(),
    );
  }

  Widget desktopHomepage() {
    return Flex(
      direction: Axis.horizontal,
      children: [
        Expanded(
          flex: 1,
          child: Container(
            color: const Color(0xFF90a8ed),
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const HoverTextWidget(
                    mainText: 'Hello there, ',
                    smallText: 'General Kenobi',
                    textColor: const Color(0xFF000000),
                  ),
                  Text(
                    'I am ',
                    style: TextStyle(
                      fontSize: ScreenUtil().setSp(
                        MediaQuery.of(context).size.width / 40,
                      ),
                    ),
                  ),
                  NeoBrutalContainer(
                    text: 'Himanshu Balani',
                    path: const AboutPage(),
                    width: ScreenUtil()
                        .setWidth(MediaQuery.of(context).size.width / 15),
                    height: ScreenUtil()
                        .setHeight(MediaQuery.of(context).size.height / 8),
                    fontsize: ScreenUtil()
                        .setSp(MediaQuery.of(context).size.width / 50),
                  ),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget mobileHomepage() {
    return Flex(
      direction: Axis.horizontal,
      children: [
        Expanded(
          flex: 1,
          child: Container(
            color: const Color(0xFF90a8ed),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Hello there, ',
                    style: TextStyle(
                      fontSize: ScreenUtil().setSp(
                        MediaQuery.of(context).size.width / 20,
                      ),
                    ),
                  ),
                  Text(
                    'I am ',
                    style: TextStyle(
                      fontSize: ScreenUtil().setSp(
                        MediaQuery.of(context).size.width / 20,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: ScreenUtil().setHeight(
                      MediaQuery.of(context).size.height / 30,
                    ),
                  ),
                  NeoBrutalContainer(
                    text: 'Himanshu Balani',
                    path: const AboutPage(),
                    width: ScreenUtil()
                        .setWidth(MediaQuery.of(context).size.width / 2),
                    height: ScreenUtil()
                        .setHeight(MediaQuery.of(context).size.height / 10),
                    fontsize: ScreenUtil().setSp(
                      MediaQuery.of(context).size.width / 20,
                    ),
                  ),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}
