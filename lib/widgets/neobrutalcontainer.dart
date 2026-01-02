import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:portfolio/consts/style.dart';

import '../presentation/onhover.dart';

class NeoBrutalContainer extends StatelessWidget {
  final String text;
  final fontsize;
  final width;
  final height;
  final path;
  final color;

  const NeoBrutalContainer(
      {super.key,
      required this.text,
      required this.width,
      required this.height,
      required this.fontsize,
      this.path,
      this.color,
      });

  @override
  Widget build(BuildContext context) {
    return OnHover(builder: (bool isHovered) {
      return InkWell(
        onTap: () => Get.toNamed(path),
        child: Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(18),
            boxShadow: [
              BoxShadow(
                color: AppColors().black,
                spreadRadius: 2.0,
                offset: const Offset(3, 3), // Shadow position, top left
              ),
            ],
            border: Border.all(
              color: AppColors().black, // Border color
              width: 3.0, // Border width
            ),
          ),
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                // fontFamily: GoogleFonts.outfit(fontWeight: FontWeight.bold).fontFamily,
                color: AppColors().black,
                fontSize: fontsize,
                fontWeight: FontWeight.bold),
            ),
          ),
        ),
      );
    });
  }
}
