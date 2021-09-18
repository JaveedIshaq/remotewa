import 'package:flutter/material.dart';
import 'package:remotewa/config/colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginBackground extends StatelessWidget {
  const LoginBackground({Key? key, required this.child}) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height,
      width: double.infinity,
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Positioned(
            top: -40,
            left: -20,
            child: Container(
              width: 140.w,
              height: 140.h,
              decoration:
                  BoxDecoration(shape: BoxShape.circle, color: kPrimaryColor),
            ),
          ),
          Positioned(
            top: 60,
            right: -30,
            child: Container(
              width: 70.w,
              height: 70.h,
              decoration:
                  BoxDecoration(shape: BoxShape.circle, color: kPrimaryColor),
            ),
          ),
          Positioned(
            bottom: -60,
            right: -30,
            child: Container(
              width: 140.w,
              height: 140.h,
              decoration:
                  BoxDecoration(shape: BoxShape.circle, color: kPrimaryColor),
            ),
          ),
          Positioned(
            bottom: 30,
            left: -30,
            child: Container(
              width: 70.w,
              height: 70.h,
              decoration:
                  BoxDecoration(shape: BoxShape.circle, color: kPrimaryColor),
            ),
          ),
          // Positioned.fill(
          //   child: Align(
          //       alignment: Alignment.bottomCenter,
          //       child: Container(
          //         width: MediaQuery.of(context).size.width * 0.7,
          //         height: 40.h,
          //         decoration: BoxDecoration(
          //           color: kBgColor,
          //           borderRadius: BorderRadius.only(
          //             topRight: Radius.circular(20),
          //             topLeft: Radius.circular(20),
          //           ),
          //         ),
          //       )),
          // ),
          child,
        ],
      ),
    );
  }
}
