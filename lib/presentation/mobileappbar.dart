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
    return SafeArea(
      child: AppBar(
        automaticallyImplyLeading: false,
        leading: null,
        scrolledUnderElevation: 10,
        backgroundColor: Colors.white,
        title: const AutoSizeText(
          'himanshubalani',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
          ),
        ),
        shape: const RoundedRectangleBorder(
          side: BorderSide(style: BorderStyle.solid, color: Colors.black, width: 2),
        ),
        actions: <Widget>[
          _appBarButton(
            onPressed: () => launchUrlString('https://flowcv.com/resume/ndw4bwkh38'),
            label: 'resume',
          ),
          _menuIconButton(context),
        ],
      ),
    );
  }

  Widget _appBarButton({
    required VoidCallback onPressed,
    required String label,
  }) {
    return Padding(
      padding: const EdgeInsets.only(right: 16.0),
      child: TextButton(
        onPressed: onPressed,
        child: const Text(
          'resume',
          style: TextStyle(
            color: Colors.black,
            fontSize: 15,
          ),
        ),
      ),
    );
  }

  Widget _menuIconButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 20.0),
      child: GestureDetector(
        onTap: () {},
        child: IconButton(
          color: Colors.black,
          icon: const Icon(Icons.menu, size: 26.0),
          onPressed: () {
            _showPopupMenu(context);
          },
        ),
      ),
    );
  }

  void _showPopupMenu(BuildContext context) {
    showMenu(
      color: Colors.white,
      elevation: 0.0,
      context: context,
      position: const RelativeRect.fromLTRB(1000.0, 70.0, 0.0, 0.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0), side: const BorderSide(width: 2)),
      items: [
        _popupMenuItem('home', () => Get.toNamed('/home')),
        _popupMenuItem('about', () => Get.toNamed('/about')),
        _popupMenuItem('blog', () => launchUrlString('https://himanshubalani.hashnode.dev/')),
        _popupMenuItem('projects', () => Get.toNamed('/projects')),
        _popupMenuItem('socials', () => Get.toNamed('/socials')),
      ],
    );
  }

  PopupMenuItem<String> _popupMenuItem(String value, VoidCallback onTap) {
    return PopupMenuItem(
      onTap: onTap,
      value: value,
      child: Text(
        value,
        style: const TextStyle(
          color: Colors.black,
          fontSize: 15,
        ),
      ),
    );
  }
}