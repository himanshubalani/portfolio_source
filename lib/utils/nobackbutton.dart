import 'package:flutter/widgets.dart';

class NoBack extends StatelessWidget {
  final Widget child;

  const NoBack({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: child,
      onWillPop: () async => false,
    );
  }
}