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
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        width: 56,
        height: 56,
        child: Center(
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
              child: Tooltip(
                message: isDark ? 'En-lighten' : 'Break the bulb',
                decoration: TooltipStyles.decoration(isDark: isDark),
                textStyle: TooltipStyles.textStyle(isDark: isDark),
                child: Icon(
                  isDark ? Icons.light_mode : Icons.lightbulb_outline_rounded,
                  key: ValueKey(isDark),
                  size: 28,
                  color: isDark ? AppColors.brightOrange : AppColors.black,
                  semanticLabel: isDark ? 'Light Mode' : 'Dark Mode',
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
