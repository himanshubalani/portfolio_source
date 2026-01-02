import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileImage extends StatelessWidget {
  const ProfileImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double frameWidth = (screenWidth * 0.15).clamp(200.0, 280.0);
    double frameHeight = frameWidth * 1.2;

    return Center(
      child: Transform.rotate(
        angle: -0.06,
        child: Container(
          width: frameWidth,
          height: frameHeight,
          decoration: BoxDecoration(
            color: const Color(0xFFFBFBFB), 
            border: Border.all(color: Colors.black, width: 3),
            borderRadius: BorderRadius.circular(5.r),
          ),
          padding: EdgeInsets.only(
            top: 5.h,
            left: 5.h,
            right: 5.h,
            bottom: 50.h.clamp(0, 40),
          ),
          child: ClipRRect(
            clipBehavior: Clip.antiAlias,
            borderRadius: BorderRadius.all(Radius.circular(2.r)),
            child: Container(
              decoration: BoxDecoration(border: Border.all(width: 2)),
      
            child: Image.asset(
              'assets/images/profileimage2.webp',
              fit: BoxFit.cover,
              width: double.infinity,
            ),
          ),
        ),
          ),
      ),
    );
  }
}
