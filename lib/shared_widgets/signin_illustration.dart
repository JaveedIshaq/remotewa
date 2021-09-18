import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SigninIllustration extends StatelessWidget {
  const SigninIllustration({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 60.h),
      child: Image.asset(
        "assets/images/login-img.jpg",
        width: MediaQuery.of(context).size.width * 0.7,
      ),
    );
  }
}
