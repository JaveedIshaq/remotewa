import 'package:clay_containers/clay_containers.dart';
import 'package:flutter/material.dart';
import 'package:remotewa/config/colors.dart';

/// Logout Remote Button
class LogoutRemoteButton extends StatelessWidget {
  /// Constructor
  const LogoutRemoteButton({
    Key? key,
    required this.onTap,
  }) : super(key: key);

  /// OnTap
  final VoidCallback onTap;

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
            height: 40,
            width: 40,
            surfaceColor: const Color(0xFFe58dbb),
            parentColor: Colors.grey[600],
            emboss: true,
            spread: 2,
            curveType: CurveType.concave,
            child: const Center(
              child: Icon(
                Icons.logout,
                color: Colors.white,
                size: 20,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
