import 'package:flutter/material.dart';
import 'package:remotewa/config/colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChatTextButton extends StatelessWidget {
  const ChatTextButton({
    Key? key,
    required this.title,
    required this.onTap,
    required this.textColor,
  }) : super(key: key);

  final String title;
  final VoidCallback onTap;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        splashColor: kPrimaryColor,
        onTap: onTap,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
          child: Text(
            title,
            style: TextStyle(color: textColor),
          ),
        ),
      ),
    );
  }
}
