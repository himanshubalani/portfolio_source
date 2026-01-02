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

  BoxDecoration tooltipDecoration() {
    return BoxDecoration(
      color: AppColors().offwhite,
      borderRadius: BorderRadius.circular(10),
      shape: BoxShape.rectangle,
      border: Border.all(
        color: Colors.black,
        width: 2,
      ),
      boxShadow: const [
        BoxShadow(
          color: Colors.black,
          spreadRadius: 1.0,
          offset: Offset(1, 2),
        ),
      ],
    );
  }
}

class AppColors {
  //Primary
  Color primaryPurple = const Color(0xFF90a8ed);

  // Social media colors
  Color email = const Color(0xFFEA4335);
  Color linkedin = const Color(0xff0077b5);
  Color github = const Color(0xff24292e);
  Color xtwitter = const Color(0xff141417);
  Color instagram = const Color(0xffd62976);
  Color discord = const Color(0xFF7289DA);
  Color peerlist = const Color(0xFF00ab46);
  Color sessionize = const Color(0xFF1AB394);
  Color youtube = const Color(0xFFFF0000);
  Color orchid = const Color(0xFFA1C837);

  // Background color
  Color lightTeal = const Color(0xFFDAF5F0);
  Color paleGreen = const Color(0xFFB5D2AD);
  Color paleYellow = const Color(0xFFFDFD96);
  Color lightPeach = const Color(0xFFF8D6B3);
  Color lightPink = const Color(0xFFFCDFFF);
  Color lightLavender = const Color(0xFFE3DFF2);

  // Second row of colors
  Color lightBlue = const Color(0xFFB4D6F8);
  Color mediumTeal = const Color(0xFFA7DBD8);
  Color lightLimeGreen = const Color(0xFFBAFCA2);
  Color brightOrange = const Color(0xFFFFDB58);
  Color coralRed = const Color(0xFFFFA07A);
  Color softPink = const Color(0xFFFFC0CB);
  Color palePurple = const Color(0xFFC4A1FF);

  // Third row of colors
  Color skyBlue = const Color(0xFF93D6F1);
  Color toolJetBlue = const Color.fromARGB(255, 64, 117, 239);
  Color lightGreen = const Color(0xFF90EE90);
  Color mustardYellow = const Color(0xFFF4D738);
  Color tomatoRed = const Color(0xFFFF7A5C);
  Color lavenderPink = const Color(0xFFFFB2EF);
  Color darkPurple = const Color(0xFFA388EE);

  // Fourth row of colors
  Color royalBlue = const Color(0xFF8DA6F5);
  Color lightSeafoamGreen = const Color(0xFF8ADEEF);
  Color oliveGreen = const Color(0xFF7FBC8C);
  Color rustyOrange = const Color(0xFFE3A018);
  Color darkRed = const Color(0xFFFF6B6B);
  Color hotPink = const Color(0xFFFF69B4);
  Color darkViolet = const Color(0xFF9723C9);
  Color deepSaffron = const Color(0xFFFFA500);

  //standard colors
  Color transparent = const Color(0x00ffffff);
  Color white = const Color(0xFFF0F0F0);
  Color black = const Color(0xFF121212);
  Color offwhite = const Color(0xFFF0F4F7);
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
