import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher_string.dart';

class MobileAppbar extends StatelessWidget implements PreferredSizeWidget {
  const MobileAppbar({Key? key}) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(60);

  @override
  Widget build(BuildContext context) {
    // 1. Determine Theme
    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    // 2. Define Colors
    final Color bgColor = isDark ? Colors.black : Colors.white;
    final Color fgColor = isDark ? Colors.white : Colors.black;

    return SafeArea(
      child: AppBar(
        automaticallyImplyLeading: false,
        leading: null,
        scrolledUnderElevation: 10,
        backgroundColor: bgColor, // Dynamic Background
        elevation: 0,
        title: AutoSizeText(
          'himanshubalani',
          style: TextStyle(
            color: fgColor, // Dynamic Text
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        shape: RoundedRectangleBorder(
          side: BorderSide(
              style: BorderStyle.solid,
              color: fgColor, // Dynamic Border
              width: 2),
        ),
        actions: <Widget>[
          _appBarButton(
            onPressed: () =>
                launchUrlString('https://flowcv.com/resume/ndw4bwkh38'),
            label: 'resume',
            textColor: fgColor,
          ),
          // Dark Mode Toggle
          IconButton(
            onPressed: () {
              Get.changeThemeMode(
                isDark ? ThemeMode.light : ThemeMode.dark,
              );
            },
            icon: Icon(
              isDark ? Icons.light_mode_rounded : Icons.dark_mode_rounded,
              color: fgColor,
              size: 20,
            ),
          ),
          _menuIconButton(context, fgColor, bgColor),
        ],
      ),
    );
  }

  Widget _appBarButton({
    required VoidCallback onPressed,
    required String label,
    required Color textColor,
  }) {
    return TextButton(
      onPressed: onPressed,
      child: Text(
        label,
        style: TextStyle(
          color: textColor,
          fontSize: 15,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _menuIconButton(BuildContext context, Color fgColor, Color bgColor) {
    return Padding(
      padding: const EdgeInsets.only(right: 12.0),
      child: GestureDetector(
        onTap: () {},
        child: IconButton(
          color: fgColor,
          icon: const Icon(Icons.menu, size: 26.0),
          onPressed: () {
            _showPopupMenu(context, fgColor, bgColor);
          },
        ),
      ),
    );
  }

  void _showPopupMenu(BuildContext context, Color fgColor, Color bgColor) {
    showMenu(
      color: bgColor, // Dynamic Menu Background
      elevation: 0.0,
      context: context,
      position: const RelativeRect.fromLTRB(1000.0, 70.0, 0.0, 0.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18.0),
        side: BorderSide(width: 2, color: fgColor), // Dynamic Menu Border
      ),
      items: [
        _popupMenuItem('home', () => Get.toNamed('/home'), fgColor),
        _popupMenuItem('about', () => Get.toNamed('/about'), fgColor),
        _popupMenuItem('blog',
            () => launchUrlString('https://himanshubalani.hashnode.dev/'), fgColor),
        _popupMenuItem('projects', () => Get.toNamed('/projects'), fgColor),
        _popupMenuItem('socials', () => Get.toNamed('/socials'), fgColor),
      ],
    );
  }

  PopupMenuItem<String> _popupMenuItem(
      String value, VoidCallback onTap, Color textColor) {
    return PopupMenuItem(
      onTap: onTap,
      value: value,
      child: Text(
        value,
        style: TextStyle(
          color: textColor, // Dynamic Item Text
          fontSize: 15,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}