import 'package:flutter/material.dart';

class NavigationUtils {
  static void navigateToPage(BuildContext context, Widget page) {
    Navigator.push(
      context,
      NoAnimationPageRoute(builder: (context) => page),
    );
  }
}

class NoAnimationPageRoute<T> extends MaterialPageRoute<T> {
  NoAnimationPageRoute({required WidgetBuilder builder, RouteSettings? settings})
      : super(builder: builder, settings: settings);

  @override
  Duration get transitionDuration => Duration.zero;
}
