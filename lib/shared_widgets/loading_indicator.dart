/* 
************************** File Information *******************************

Date        : 2021/09/18

Author      : Javeed Ishaq (www.javeedishaq.com)

Description : LoginScreen

It is the LoginScreen of the App

**************************************************************************** 
*/

import 'package:flutter/material.dart';

/// Loading Indicator
class LoadingIndicator extends StatelessWidget {
  /// Constructor
  const LoadingIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: const Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
        ),
      ),
      color: Colors.white.withOpacity(0.15),
    );
  }
}
