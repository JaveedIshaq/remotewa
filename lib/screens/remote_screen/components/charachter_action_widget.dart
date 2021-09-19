import 'package:flutter/material.dart';
import 'package:remotewa/config/colors.dart';

/// Character Action Widget
class CharachterActionWidget extends StatelessWidget {
  ///constructor
  const CharachterActionWidget({
    Key? key,
    required this.onTap,
    required this.charImgName,
    required this.title,
  }) : super(key: key);

  /// On Tap
  final VoidCallback onTap;

  /// Character Image Name
  final String charImgName;

  /// Title Text
  final String title;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: kPrimaryDarkColor,
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 2),
        child: Column(
          children: [
            Image.asset(
              'assets/images/$charImgName-character.png',
              width: 40,
            ),
            Text(
              title,
              style: const TextStyle(
                color: kPrimaryDarkColor,
              ),
            )
          ],
        ),
      ),
    );
  }
}
