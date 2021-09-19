/* 
************************** File Information *******************************

Date        : 2021/09/18

Author      : Javeed Ishaq (www.javeedishaq.com)

Description : ChatIconButton

A component to show the Icon Button

**************************************************************************** 
*/

import 'package:flutter/material.dart';
import 'package:remotewa/config/colors.dart';

/// ChatIconButton Widget
class ChatIconButton extends StatelessWidget {
  /// ChatIconButton Constructure
  const ChatIconButton({
    Key? key,
    required this.icon,
    required this.onTap,
  }) : super(key: key);

  /// Icon
  final IconData icon;

  /// Function to call on Tap
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8.0),
        child: IconButton(
          icon: Icon(icon),
          onPressed: onTap,
          color: kPrimaryColor,
        ),
      ),
      color: Colors.white,
    );
  }
}
