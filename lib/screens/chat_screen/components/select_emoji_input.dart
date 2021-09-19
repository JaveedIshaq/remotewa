import 'package:flutter/material.dart';
import 'package:remotewa/config/colors.dart';

/// SelectEmojiInput
class SelectEmojiInput extends StatelessWidget {
  /// SelectEmojiInput constructor
  const SelectEmojiInput({
    Key? key,
    required this.onTap,
    required this.onSubmitted,
    required this.ctrlr,
    required this.focusNode,
  }) : super(key: key);

  /// OnTap
  final VoidCallback onTap;

  /// onSubmitted
  final Function onSubmitted;

  /// TextEditingController
  final TextEditingController ctrlr;

  /// FocusNode
  final FocusNode focusNode;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: InkWell(
        onTap: onTap,
        child: TextField(
          enabled: false,
          onSubmitted: (value) => onSubmitted,
          onTap: onTap,
          style: TextStyle(color: primaryColor, fontSize: 15.0),
          controller: ctrlr,
          decoration: InputDecoration.collapsed(
            hintText: 'Select your Emojies...',
            hintStyle: TextStyle(color: greyColor),
          ),
          focusNode: focusNode,
        ),
      ),
    );
  }
}
