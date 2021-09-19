import 'package:clay_containers/clay_containers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:remotewa/config/colors.dart';
import 'package:remotewa/utils/database.dart';

///
class GoogleSigninButton extends StatelessWidget {
  ///
  GoogleSigninButton({
    Key? key,
    required this.onTap,
  }) : super(key: key);

  ///
  final VoidCallback onTap;

  /// creating an instance of Database class to Store User
  ///
  final Database database = Database();

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        splashColor: kPrimaryColor,
        onTap: onTap,
        // onTap: () async {
        //   User? user = await Authentication.signInWithGoogle();

        //   if (user != null) {
        //     database.storeUserData(user: user);

        //     Navigator.push(
        //       context,
        //       MaterialPageRoute(
        //         builder: (context) => ChatScreen(user: user),
        //       ),
        //     );
        //   }
        // },
        child: ClayContainer(
          surfaceColor: Colors.white,
          parentColor: Colors.grey[600],
          emboss: true,
          curveType: CurveType.convex,
          depth: 10,
          spread: 1,
          borderRadius: 10,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 10.h),
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
      ),
    );
  }
}



// padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 10.h),
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(10),
//               color: Colors.white,
//               border: Border.all(
//                 color: kPrimaryColor.withOpacity(0.5),
//               ),