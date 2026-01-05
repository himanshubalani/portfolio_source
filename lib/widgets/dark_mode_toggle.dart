import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:portfolio/consts/style.dart';

class DarkModeToggle extends StatelessWidget {
  const DarkModeToggle({super.key});

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;

    return GestureDetector(
      onTap: () {
        Get.changeThemeMode(isDark ? ThemeMode.light : ThemeMode.dark);
      },
      child: RepaintBoundary(
        child: SizedBox(
          width: 56,
          height: 56,
          child: Center(
            child: Tooltip(
              message: isDark ? 'En-lighten' : 'Darkseid',
              decoration: TooltipStyles.decoration(isDark: isDark),
              textStyle: TooltipStyles.textStyle(isDark: isDark),
              child: Transform.flip(
                flipY: true,
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  transitionBuilder: (child, animation) {
                    return ScaleTransition(
                      scale: animation,
                      child: RotationTransition(
                        turns: animation,
                        child: child,
                      ),
                    );
                  },
                  child: Icon(
                    isDark ? Icons.light_mode : Icons.lightbulb_outline_rounded,
                    key: ValueKey(isDark),
                    size: 28,
                    color: isDark ? AppColors.brightOrange : Colors.black,
                    semanticLabel: isDark ? 'Light Mode' : 'Dark Mode',
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
