import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppStyles {
  late Color bgcolor;

  ButtonStyle socialIconStyle = ButtonStyle(
    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
    ),
    padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
      const EdgeInsets.all(12.0),
    ),
    side: MaterialStateProperty.all<BorderSide>(
      const BorderSide(
        color: Colors.black,
        width: 3.0,
      ),
    ),
  );

  TextStyle outfitTextStyle = TextStyle(
    fontFamily: GoogleFonts.outfit().fontFamily,
    fontSize: 30,
  );

  BoxDecoration neoContainerDecorationOne() {
    return BoxDecoration(
      color: Colors.black,
      borderRadius: BorderRadius.circular(20),
      border: Border.all(
        width: 2,
      ),
      boxShadow: const [
        BoxShadow(color: Colors.black, spreadRadius: 1.0, offset: Offset(4, 6)),
      ],
    );
  }

  BoxDecoration neoContainerDecorationTwo() {
    return const BoxDecoration(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(20),
        topRight: Radius.circular(20),
      ),
      border: Border(
        bottom: BorderSide(
          color: Colors.black,
          width: 2,
        ),
        top: BorderSide(
          color: Colors.black,
          width: 0,
        ),
        left: BorderSide(
          color: Colors.black,
          width: 0,
        ),
        right: BorderSide(
          color: Colors.black,
          width: 0,
        ),
      ),
    );
  }
}

class TooltipStyles {
  static BoxDecoration decoration({required bool isDark}) {
    return BoxDecoration(
      color: isDark ? AppColors.black : Colors.white,
      border: Border.all(
        color: isDark ? AppColors.brightOrange : AppColors.black,
        width: 2,
      ),
      borderRadius: BorderRadius.circular(8),
    );
  }

  static TextStyle textStyle({required bool isDark}) {
    return TextStyle(
      color: isDark ? AppColors.brightOrange : AppColors.black,
      fontSize: 12,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.8,
    );
  }

  static const EdgeInsets padding =
      EdgeInsets.symmetric(horizontal: 8, vertical: 6);

  static const EdgeInsets margin = EdgeInsets.only(top: 8);

  static const double verticalOffset = 12;
}

class AppColors {

  AppColors._(); // Private constructor to prevent instantiation

  //Primary
  static const Color primaryPurple = Color(0xFF90a8ed);

  // Social media colors
  static const Color email = Color(0xFFEA4335);
  static const Color linkedin = Color(0xff0077b5);
  static const Color github = Color(0xff24292e);
  static const Color xtwitter = Color(0xff141417);
  static const Color instagram = Color(0xffd62976);
  static const Color discord = Color(0xFF7289DA);
  static const Color peerlist = Color(0xFF00ab46);
  static const Color sessionize = Color(0xFF1AB394);
  static const Color youtube = Color(0xFFFF0000);
  static const Color orchid = Color(0xFFA1C837);

  // Background color
  static const Color lightTeal = Color(0xFFDAF5F0);
  static const Color paleGreen = Color(0xFFB5D2AD);
  static const Color paleYellow = Color(0xFFFDFD96);
  static const Color lightPeach = Color(0xFFF8D6B3);
  static const Color lightPink = Color(0xFFFCDFFF);
  static const Color lightLavender = Color(0xFFE3DFF2);

  // Second row of colors
  static const Color lightBlue = Color(0xFFB4D6F8);
  static const Color mediumTeal = Color(0xFFA7DBD8);
  static const Color lightLimeGreen = Color(0xFFBAFCA2);
  static const Color mangoYellow = Color(0xFFFBFF2F);
  static const Color brightOrange = Color(0xFFFFDB58);
  static const Color coralRed = Color(0xFFFFA07A);
  static const Color softPink = Color(0xFFFFC0CB);
  static const Color palePurple = Color(0xFFC4A1FF);

  // Third row of colors
  static const Color skyBlue = Color(0xFF93D6F1);
  static const Color toolJetBlue = Color.fromARGB(255, 64, 117, 239);
  static const Color lightGreen = Color(0xFF90EE90);
  static const Color mustardYellow = Color(0xFFF4D738);
  static const Color tomatoRed = Color(0xFFFF7A5C);
  static const Color lavenderPink = Color(0xFFFFB2EF);
  static const Color darkPurple = Color(0xFFA388EE);

  // Fourth row of colors
  static const Color royalBlue = Color(0xFF8DA6F5);
  static const Color lightSeafoamGreen = Color(0xFF8ADEEF);
  static const Color oliveGreen = Color(0xFF7FBC8C);
  static const Color rustyOrange = Color(0xFFE3A018);
  static const Color darkRed = Color(0xFFFF6B6B);
  static const Color hotPink = Color(0xFFFF69B4);
  static const Color darkViolet = Color(0xFF9723C9);
  static const Color deepSaffron = Color(0xFFFFA500);

  //standard colors
  static const Color transparent = Color(0x00ffffff);
  static const Color white = Color(0xFFF0F0F0);
  static const Color black = Color(0xFF121212);
  static const Color offwhite = Color(0xFFF0F4F7);
}

class TextStyles {
  TextStyle outfitTextStyle = TextStyle(
    fontFamily: GoogleFonts.outfit().fontFamily,
  );
}

class FormStyles {
  InputDecoration contactFormDeco = InputDecoration(
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(18),
    ),
  );
}
