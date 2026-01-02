import 'package:flutter/material.dart';

import '../presentation/desktopappbar.dart';
import '../presentation/mobileappbar.dart';

class Appbar extends StatelessWidget implements PreferredSizeWidget{
  const Appbar({super.key}); // Removed super.key

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(60.0),
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          if (constraints.maxWidth > 900) {
            return const DesktopAppbar();
          } else {
            return const MobileAppbar();
          }
        },
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
