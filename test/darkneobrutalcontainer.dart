import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:portfolio/presentation/onhover.dart';
import 'package:portfolio/consts/style.dart';




class DarkNeoBrutalContainer extends StatelessWidget {
  final String text;
  final fontsize;
  final width;
  final height;
  final path;
  final color;

  const DarkNeoBrutalContainer({super.key, required this.text, required this.width, required this.height, required this.fontsize, required this.path, this.color});

  @override
  Widget build(BuildContext context) {
    return OnHover(
      builder: (bool isHovered) {
        return InkWell(
          onTap: () => Get.toNamed(path),
          child: Container(
            width: width,
            height:height,

          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(18),
            boxShadow: [
              BoxShadow(
                color: AppColors().primaryPurple, // Full opacity black shadow
                spreadRadius: 2.0,
                offset: Offset(3, 3), // Shadow position, top left
              ),
            ],
            border: Border.all(
              color: AppColors().primaryPurple, // Border color
              width: 3.0, // Border width
            ),
          ),
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                color: Colors.white70,
                  fontSize: fontsize,
                  fontWeight: FontWeight.bold),
            ),
          ),
      ),
        );
    }
    );
  }
}
