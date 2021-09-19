import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:remotewa/config/colors.dart';

/// ChatMessageBubble
class ChatMessageBubble extends StatelessWidget {
  /// ChatMessageBubble
  const ChatMessageBubble({
    Key? key,
    required this.text,
    required this.name,
    required this.time,
  }) : super(key: key);

  /// text
  final String text;
  final String name;
  final DateTime time;
  @override
  Widget build(BuildContext context) {
    final f = DateFormat('dd, MMM, yyyy, hh:mm a');

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              color: kPrimaryColor.withOpacity(0.5),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.r),
                topRight: Radius.circular(20.r),
                bottomRight: Radius.circular(20.r),
              ),
            ),
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: Text(
              text,
              style: const TextStyle(
                color: kPrimaryDarkColor,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: kPrimaryColor,
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(5.r),
                    bottomLeft: Radius.circular(5.r),
                  ),
                ),
                padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 6),
                child: Text(
                  name,
                  style: const TextStyle(color: Colors.white, fontSize: 10),
                ),
              ),
              const SizedBox(width: 5),
              Text(f.format(DateTime.parse('$time')),
                  style: const TextStyle(
                    fontSize: 10,
                    color: Colors.grey,
                  ))
            ],
          ),
        ],
      ),
    );
  }
}
