import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portfolio/presentation/onhover.dart';
import 'package:portfolio/widgets/neobrutalbox.dart';
import 'package:simple_icons/simple_icons.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../consts/style.dart';

class socialBox extends StatelessWidget {
  const socialBox({super.key});

  @override
  Widget build(BuildContext context) {
    // Moved pageWidth here so it updates on resize
    double pageWidth = MediaQuery.of(context).size.width;

    return Container(
      width: pageWidth <= 900 ? 300.w : pageWidth / 2.6,
      color: AppColors().transparent,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          sociallinkbutton(
            link: pageWidth <= 900
                ? 'mailto:hello@himanshubalani.com'
                : 'https://mail.google.com/mail/u/0/?to=hello@himanshubalani.com&fs=1&tf=cm',
            icon: FontAwesomeIcons.envelope,
            pfname: 'hello@himanshubalani.com',
            pfcolor: AppColors().email,
            vmainaxissize: MainAxisSize.max,
          ),
          sociallinkbutton(
            link:
                'https://github.com/himanshubalani/?ref=portfolio&utm_medium=website',
            icon: FontAwesomeIcons.github,
            pfname: 'github.com/himanshubalani',
            pfcolor: AppColors().github,
            vmainaxissize: MainAxisSize.max,
          ),
          sociallinkbutton(
            link:
                'http://peerlist.io/himanshubalani?ref=portfolio&utm_medium=website',
            icon: 'assets/images/peerlist_icon2.png',
            pfname: 'peerlist.io/himanshubalani',
            pfcolor: AppColors().peerlist,
            vmainaxissize: MainAxisSize.max,
          ),
          sociallinkbutton(
            link: 'https://www.linkedin.com/in/himanshubalani/',
            icon: FontAwesomeIcons.linkedin,
            pfname: 'linkedin.com/in/himanshubalani',
            pfcolor: AppColors().linkedin,
            vmainaxissize: MainAxisSize.max,
          ),
          sociallinkbutton(
            link:
                'https://twitter.com/himanshubalani5?ref=portfolio&utm_medium=website',
            icon: FontAwesomeIcons.xTwitter,
            pfname: 'x.com/himanshubalani5',
            pfcolor: AppColors().xtwitter,
            vmainaxissize: MainAxisSize.max,
          ),
          sociallinkbutton(
            link: 'https://discord.com/users/759807486831099928',
            icon: SimpleIcons.discord,
            pfname: 'discord.com/users/himanshubalani',
            pfcolor: AppColors().discord,
            vmainaxissize: MainAxisSize.max,
          ),
          sociallinkbutton(
            link:
                'http://instagram.com/himanshubalani?ref=portfolio&utm_medium=website',
            icon: FontAwesomeIcons.instagram,
            pfname: 'instagram.com/himanshubalani',
            pfcolor: AppColors().instagram,
            vmainaxissize: MainAxisSize.max,
          ),
        ]
            .map((e) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: e,
                ))
            .toList(),
      ),
    );
  }
}

class sociallinkbutton extends StatelessWidget {
  final String link;
  final dynamic icon;
  final String pfname;
  final Color pfcolor;
  final MainAxisSize vmainaxissize;

  const sociallinkbutton({
    super.key,
    required this.link,
    required this.icon,
    required this.pfname,
    required this.pfcolor,
    required this.vmainaxissize,
  });

  // REMOVED: static bool isDark = ...

  @override
  Widget build(BuildContext context) {
    // ADDED: This ensures it checks the theme every time the UI rebuilds
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    
    // ADDED: Get width directly here instead of relying on static variable
    final double pageWidth = MediaQuery.of(context).size.width;

    return OnHover(builder: (bool isHovered) {
      return InkWell(
        onTap: () {
          launchUrlString(link);
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 9.0, vertical: 9.0),
          decoration: BoxDecoration(
            color: isDark ? AppColors().black : pfcolor,
            borderRadius: BorderRadius.circular(
                (pageWidth <= 900 ? 12.sp : 5.sp).clamp(12, 18)),
            border:
                Border.all(color: isDark ? pfcolor : Colors.black, width: 3.0),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: vmainaxissize,
            children: [
              Wrap(
                alignment: WrapAlignment.spaceAround,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  _buildIcon(pageWidth), // Pass width to helper
                  AutoSizeText(
                    pfname,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize:
                          (pageWidth <= 900 ? 12.sp : 5.sp).clamp(10, 18),
                      fontFamily:
                          GoogleFonts.quicksand(fontWeight: FontWeight.bold)
                              .fontFamily,
                      color: AppColors().white,
                      overflow: TextOverflow.ellipsis,
                    ),
                  )
                ]
                    .map((e) => Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4.0),
                          child: e,
                        ))
                    .toList(),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 2.0),
                child: BoxCircles(
                  hoverEnabled: false,
                  color: isDark ? pfcolor : AppColors().white,
                ),
              ),
            ],
          ),
        ),
      );
    });
  }

  Widget _buildIcon(double pageWidth) {
    final double iconSize =
        (pageWidth <= 900 ? 20.w : 5.w).clamp(12, 24);

    if (icon is IconData) {
      return Icon(
        icon as IconData,
        size: iconSize,
        color: AppColors().white,
      );
    } else if (icon is String) {
      return Image.asset(
        icon,
        width: iconSize,
        height: iconSize,
      );
    } else {
      return SizedBox(width: iconSize, height: iconSize);
    }
  }
}
