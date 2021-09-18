import 'package:flutter/material.dart';
import 'package:remotewa/config/colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

var headingStyle = TextStyle(
  fontWeight: FontWeight.bold,
  fontSize: 26.sp,
  color: Colors.white,
  fontFamily: 'Asap',
);

var messageInputDecoration = InputDecoration(
  filled: true,
  fillColor: kBgColor,
  contentPadding: EdgeInsets.only(left: 10.w, top: 5.h),
  border: OutlineInputBorder(
    borderSide: const BorderSide(
      color: kBgColor,
    ),
    borderRadius: BorderRadius.only(
      topLeft: Radius.circular(20.r),
      bottomLeft: Radius.circular(20.r),
    ),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: const BorderSide(
      color: kBgColor,
    ),
    borderRadius: BorderRadius.only(
      topLeft: Radius.circular(20.r),
      bottomLeft: Radius.circular(20.r),
    ),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: const BorderSide(
      color: kBgColor,
    ),
    borderRadius: BorderRadius.only(
      topLeft: Radius.circular(20.r),
      bottomLeft: Radius.circular(20.r),
    ),
  ),
  hintText: "",
);

var postInputDecoration = InputDecoration(
  filled: true,
  fillColor: kBgColor,
  contentPadding: const EdgeInsets.all(20),
  border: OutlineInputBorder(
    borderSide: const BorderSide(
      color: kBgColor,
    ),
    borderRadius: BorderRadius.circular(15),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(
      color: kBgColor,
    ),
    borderRadius: BorderRadius.circular(15),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(
      color: kBgColor,
    ),
    borderRadius: BorderRadius.circular(15),
  ),
  hintText: "",
);
