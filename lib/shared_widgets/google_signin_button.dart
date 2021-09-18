import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:remotewa/config/colors.dart';
import 'package:remotewa/screens/chat_screen.dart';
import 'package:remotewa/utils/authentication.dart';
import 'package:remotewa/utils/database.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GoogleSigninButton extends StatelessWidget {
  GoogleSigninButton({
    Key? key,
  }) : super(key: key);

  /// creating an instance of Database class to Store User
  ///
  final Database database = Database();

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        splashColor: kPrimaryColor,
        onTap: () async {
          User? user = await Authentication.signInWithGoogle();

          if (user != null) {
            database.storeUserData(user: user);

            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ChatScreen(user: user),
              ),
            );
          }
        },
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 10.h),
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: kPrimaryColor.withOpacity(0.5))),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                'assets/images/google-logo.png',
                width: 15.w,
              ),
              SizedBox(width: 7.w),
              const Text(
                'Sign in with Google',
                style: TextStyle(fontWeight: FontWeight.w500),
              )
            ],
          ),
        ),
      ),
    );
  }
}
