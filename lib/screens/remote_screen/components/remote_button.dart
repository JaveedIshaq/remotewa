import 'package:clay_containers/clay_containers.dart';
import 'package:flutter/material.dart';
import 'package:remotewa/config/colors.dart';

/// Logout Remote Button
class RemoteButton extends StatelessWidget {
  /// Constructor
  const RemoteButton({
    Key? key,
    required this.onTap,
    required this.bgColor,
    required this.title,
  }) : super(key: key);

  /// OnTap
  final VoidCallback onTap;

  /// Button Back ground Color
  final Color bgColor;

  /// Title Text
  final String title;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: Padding(
        padding: const EdgeInsets.only(top: 38.0, left: 20),
        child: InkWell(
          splashColor: kPrimaryColor,
          onTap: onTap,
          child: ClayContainer(
            borderRadius: 10,
            height: 50,
            width: 50,
            surfaceColor: bgColor,
            parentColor: Colors.grey,
            emboss: true,
            spread: 2,
            curveType: CurveType.concave,
            child: Center(
              child: ClayText(
                title,
                textColor: kPrimaryColor,
                parentColor: Colors.grey,
                spread: 2,
                style: const TextStyle(
                  fontFamily: 'Asap',
                  fontSize: 30,
                  color: kPrimaryDarkColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
