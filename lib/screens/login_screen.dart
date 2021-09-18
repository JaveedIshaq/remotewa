import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:remotewa/config/colors.dart';
import 'package:remotewa/screens/chat_screen.dart';
import 'package:remotewa/shared_widgets/google_signin_button.dart';
import 'package:remotewa/shared_widgets/login_background.dart';
import 'package:remotewa/shared_widgets/signin_illustration.dart';
import 'package:remotewa/shared_widgets/welcom_back_text.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _error = false;

  /// Defining an asunc funtion to initialize Firebsase FireStore Database

  void initFlutterFire() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        WidgetsBinding.instance!.addPostFrameCallback((_) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ChatScreen(user: user),
            ),
          );
        });
      }
    } catch (e) {
      /// if Error in initializing make the error true

      setState(() => _error = true);
    }
  }

  @override
  void initState() {
    initFlutterFire();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: kLoginViewBgColor,
        body: SizedBox(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              const WelcomBackText(),
              const SigninIllustration(),
              _error
                  ? const Text("Something went wrong")
                  : GoogleSigninButton(),
              const Spacer(),
            ],
          ),
        ));
  }
}
