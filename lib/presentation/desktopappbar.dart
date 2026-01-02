import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'hertz_animation.dart'; // Import the animation file

class DesktopAppbar extends StatelessWidget implements PreferredSizeWidget {
  const DesktopAppbar({Key? key}) : super(key: key);
  
  @override
  Size get preferredSize => const Size.fromHeight(60);
  
  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: AppBar(
        automaticallyImplyLeading: false,
        scrolledUnderElevation: 10,
        backgroundColor: Colors.white,
        elevation: 0,
        title: InkWell(
          focusColor: Colors.transparent,
          hoverColor: Colors.transparent,
          splashColor: Colors.transparent,
          onTap: () => Get.offAllNamed('/home'),
          child: const Text(
            'himanshubalani',
            style: TextStyle(
              letterSpacing: 1.2,
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        shape: const RoundedRectangleBorder(
          side: BorderSide(
            style: BorderStyle.solid,
            color: Colors.black,
            width: 2,
          ),
        ),
        actions: <Widget>[
          _appBarButton(
            onPressed: () => launchUrlString('https://flowcv.com/resume/ndw4bwkh38'),
            label: 'resume',
          ),
          _appBarButton(onPressed: () => Get.offAllNamed('/home'), label: 'home'),
          _appBarButton(onPressed: () => Get.offAllNamed('/about'), label: 'about'),
          //animated blog button
          _appBarButton(
            onPressed: () => launchUrlString('https://blog.himanshubalani.com?utm_source=portfolio'),
            label: ' blog',
            icon: const Icon(Icons.launch_rounded, color: Colors.black, size: 15),
            animated: true, // Enable animation for blog button see hertz_animation.dart
          ),
          _appBarButton(onPressed: () => Get.toNamed('/projects'), label: 'projects'),
          _appBarButton(onPressed: () => Get.toNamed('/socials'), label: 'socials'),
        ],
      ),
    );
  }
  
  Widget _appBarButton({
    required VoidCallback onPressed,
    required String label,
    Widget? icon,
    bool animated = false,
  }) {
    final buttonContent = icon != null
        ? Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                label,
                style: TextStyle(
                  color: Colors.black,
                  fontFamily: GoogleFonts.outfit().fontFamily,
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
              icon,
            ],
          )
        : Text(
            label,
            style: TextStyle(
              fontFamily: GoogleFonts.outfit().fontFamily,
              color: Colors.black,
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          );

    final button = Padding(
      padding: const EdgeInsets.only(right: 15.0),
      child: TextButton(
        onPressed: onPressed,
        child: buttonContent,
      ),
    );

    // Wrap with animation if animated is true
    if (animated) {
      return SineWaveAnimation(
        duration: const Duration(seconds: 2),
        child: button,
      );
    }

    return button;
  }
}