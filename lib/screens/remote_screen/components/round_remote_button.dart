import 'package:clay_containers/clay_containers.dart';
import 'package:flutter/material.dart';
import 'package:remotewa/config/colors.dart';

/// Logout Remote Button
class RoundRemoteButton extends StatelessWidget {
  /// Constructor
  const RoundRemoteButton({
    Key? key,
    required this.onTap,
  }) : super(key: key);

  /// OnTap
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Padding(
        padding: const EdgeInsets.only(top: 20.0),
        child: InkWell(
          splashColor: kPrimaryColor,
          onTap: onTap,
          child: ClayContainer(
            borderRadius: 100,
            height: 150,
            width: 150,
            surfaceColor: const Color(0xFF7d82b5),
            parentColor: Colors.grey[500],
            emboss: true,
            spread: 2,
            curveType: CurveType.concave,
            child: Center(
              child: ClayContainer(
                borderRadius: 100,
                height: 100,
                width: 100,
                surfaceColor: kBgColor,
                parentColor: Colors.grey[600],
                emboss: true,
                spread: 2,
                curveType: CurveType.concave,
                child: Center(
                  child: SizedBox(
                      width: 70,
                      child: Image.asset(
                        'assets/images/chat.png',
                      )),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
