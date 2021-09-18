import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:remotewa/config/colors.dart';

class LogoutButton extends StatelessWidget {
  const LogoutButton({
    Key? key,
    required this.icon,
    required this.onTap,
    required this.iconColor,
  }) : super(key: key);

  final IconData icon;
  final VoidCallback onTap;
  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        splashColor: kPrimaryColor,
        onTap: onTap,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
          child: Icon(
            icon,
            color: iconColor,
          ),
        ),
      ),
    );
  }
}
