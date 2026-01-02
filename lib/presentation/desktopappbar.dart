import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'hertz_animation.dart'; 

class DesktopAppbar extends StatelessWidget implements PreferredSizeWidget {
  const DesktopAppbar({Key? key}) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(60);

  @override
  Widget build(BuildContext context) {
    // FIX: Use Theme.of(context).brightness instead of Get.isDarkMode.
    // This ensures the widget rebuilds immediately when the theme changes.
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final bgColor = isDark ? Colors.black : Colors.white;
    final fgColor = isDark ? Colors.white : Colors.black;

    return RepaintBoundary(
      child: AppBar(
        automaticallyImplyLeading: false,
        scrolledUnderElevation: 10,
        backgroundColor: bgColor,
        elevation: 0,

        title: InkWell(
          onTap: () => Get.offAllNamed('/home'),
          child: Text(
            'himanshubalani',
            style: TextStyle(
              letterSpacing: 1.2,
              color: fgColor,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),

        shape: RoundedRectangleBorder(
          side: BorderSide(color: fgColor, width: 2),
        ),

        actions: [
          _appBarButton(
            label: 'resume',
            onPressed: () => launchUrlString(
              'https://flowcv.com/resume/ndw4bwkh38',
            ),
            color: fgColor,
          ),

          _appBarButton(
            label: 'home',
            onPressed: () => Get.offAllNamed('/home'),
            color: fgColor,
          ),

          _appBarButton(
            label: 'about',
            onPressed: () => Get.offAllNamed('/about'),
            color: fgColor,
          ),

          _appBarButton(
            label: 'blog',
            icon: Icon(Icons.launch_rounded, size: 15, color: fgColor),
            animated: true,
            onPressed: () => launchUrlString(
              'https://blog.himanshubalani.com?utm_source=portfolio',
            ),
            color: fgColor,
          ),

          _appBarButton(
            label: 'projects',
            onPressed: () => Get.toNamed('/projects'),
            color: fgColor,
          ),

          _appBarButton(
            label: 'socials',
            onPressed: () => Get.toNamed('/socials'),
            color: fgColor,
          ),

          // Dark mode toggle
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: IconButton(
              // The icon will now update immediately because build() is called again
              icon: Icon(
                isDark ? Icons.light_mode_rounded : Icons.dark_mode_rounded,
                color: fgColor,
              ),
              onPressed: () {
                Get.changeThemeMode(
                  isDark ? ThemeMode.light : ThemeMode.dark,
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _appBarButton({
    required VoidCallback onPressed,
    required String label,
    required Color color,
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
                  color: color,
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
              color: color,
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