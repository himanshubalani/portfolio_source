import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:portfolio/widgets/neobrutalbox.dart';
import '../consts/style.dart'; // adjust import as per your project

class ShortcutsMenuButton extends StatefulWidget {
  const ShortcutsMenuButton({Key? key}) : super(key: key);

  @override
  State<ShortcutsMenuButton> createState() => _ShortcutsMenuButtonState();
}

class _ShortcutsMenuButtonState extends State<ShortcutsMenuButton> {
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    // Ensure it captures keyboard input
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _focusNode.requestFocus();
    });
  }

  void _showShortcutsMenu(BuildContext context) {
    final renderBox = context.findRenderObject() as RenderBox;
    final size = renderBox.size;
    final position = renderBox.localToGlobal(Offset.zero);

    showMenu(
      color: Colors.white,
      elevation: 0.0,
      context: context,
      position: RelativeRect.fromLTRB(
        position.dx,
        position.dy,
        position.dx + size.width,
        position.dy + size.height,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18.0),
        side: const BorderSide(width: 2),
      ),
      items: [
        _menuItem('D: View Design Portfolio'),
        _menuItem('C: View GitHub Profile'),
        _menuItem('Enter: View About Page'),
      ],
    );
  }

  PopupMenuItem<String> _menuItem(String text) {
    return PopupMenuItem(
      enabled: true,
      height: 15.h,
      child: Text(
        text,
        style: TextStyle(
          fontFamily: GoogleFonts.outfit().fontFamily,
          fontWeight: FontWeight.bold,
          fontSize: 5.sp,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return RawKeyboardListener(
      focusNode: _focusNode,
      onKey: (event) {
        if (event is RawKeyDownEvent &&
            event.logicalKey == LogicalKeyboardKey.slash) {
          _showShortcutsMenu(context);
        }
      },
      child: GestureDetector(
        onTap: () => _showShortcutsMenu(context),
        child: Container(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height <= 900
                ? 100.h
                : MediaQuery.of(context).size.height / 4.5,
            maxWidth: MediaQuery.of(context).size.width <= 900
                ? 300.w
                : MediaQuery.of(context).size.width / 2.6,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: const Color(0xFF000000), width: 2.0),
            borderRadius: const BorderRadius.all(Radius.circular(18.0)),
          ),
          padding: const EdgeInsets.all(12.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "view shortcuts ( / )",
                style: TextStyle(
                  color: const Color(0xFF000000),
                  fontSize: 3.w,
                  fontFamily: GoogleFonts.outfit().fontFamily,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(width: 12.0),
              const BoxCircles(hoverEnabled: false,),
            ],
          ),
        ),
      ),
    );
  }
}
