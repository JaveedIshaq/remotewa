import 'package:flutter/material.dart';
import 'package:remotewa/config/ui_helpers.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChatScreenHeading extends StatelessWidget {
  const ChatScreenHeading({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 15.h, bottom: 20.h),
      child: Text(
        "Chat with\nyour Frinds",
        style: headingStyle.copyWith(color: Colors.white),
      ),
    );
  }
}
