import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// BigHeadingText
class BigHeadingText extends StatelessWidget {
  /// Constructor
  const BigHeadingText({
    Key? key,
    required this.text,
    required this.size,
    this.textColor = Colors.white,
  }) : super(key: key);

  ///text
  final String text;

  /// Size of Text
  final double size;

  /// Text Color
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: size.sp,
        color: textColor,
        fontFamily: 'Asap',
      ),
    );
  }
}
