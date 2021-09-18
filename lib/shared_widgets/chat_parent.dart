import 'package:flutter/material.dart';
import 'package:remotewa/config/colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChatParent extends StatelessWidget {
  const ChatParent({Key? key, required this.child}) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 30.h),
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(color: kPrimaryDarkColor),
      child: child,
    );
  }
}
