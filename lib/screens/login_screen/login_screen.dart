/* 
************************** File Information *******************************

Date        : 2021/09/18

Author      : Javeed Ishaq (www.javeedishaq.com)

Description : LoginScreen

It is the LoginScreen of the App

**************************************************************************** 
*/

import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:remotewa/config/colors.dart';
import 'package:remotewa/models/user_chat.dart';
import 'package:remotewa/screens/remote_screen/remote_screen.dart';
import 'package:remotewa/shared_widgets/big_heading_text.dart';
import 'package:remotewa/shared_widgets/google_signin_button.dart';
import 'package:remotewa/shared_widgets/loading_indicator.dart';
import 'package:remotewa/shared_widgets/signin_illustration.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Login Screen
class LoginScreen extends StatefulWidget {
  /// Constructor
  const LoginScreen({Key? key}) : super(key: key);

  @override
  LoginScreenState createState() => LoginScreenState();
}

/// state class for the LoginScreen
class LoginScreenState extends State<LoginScreen> {
  /// GoogleSignIn
  final GoogleSignIn googleSignIn = GoogleSignIn();

  /// FirebaseAuth
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  /// SharedPreferences
  SharedPreferences? prefs;

  /// isLoading
  bool isLoading = false;

  /// isLoggedIn
  bool isLoggedIn = false;

  /// currentUser
  User? currentUser;

  @override
  void initState() {
    super.initState();

    /// Call Function Check If User already Signed In
    isSignedIn();
  }

  /// Check If User Already Logged In
  void isSignedIn() async {
    setState(() {
      isLoading = true;
    });

    prefs = await SharedPreferences.getInstance();

    isLoggedIn = await googleSignIn.isSignedIn();
    if (isLoggedIn && prefs?.getString('id') != null) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => RemoteScreen(
            currentUserId: prefs!.getString('id') ?? '',
            currentUserName: prefs!.getString('nickname') ?? '',
            currentUserPhotoUrl: prefs!.getString('photoUrl') ?? '',
          ),
        ),
      );
    }

    setState(() {
      isLoading = false;
    });
  }

  /// Handle Google Sign In
  Future<void> handleSignIn() async {
    prefs = await SharedPreferences.getInstance();

    setState(() {
      isLoading = true;
    });

    var googleUser = await googleSignIn.signIn();
    if (googleUser != null) {
      GoogleSignInAuthentication? googleAuth = await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      var firebaseUser =
          (await firebaseAuth.signInWithCredential(credential)).user;

      if (firebaseUser != null) {
        // Check is already sign up
        final QuerySnapshot result = await FirebaseFirestore.instance
            .collection('users')
            .where('id', isEqualTo: firebaseUser.uid)
            .get();
        final List<DocumentSnapshot> documents = result.docs;
        if (documents.isEmpty) {
          // Update data to server if new user
          FirebaseFirestore.instance
              .collection('users')
              .doc(firebaseUser.uid)
              .set({
            'nickname': firebaseUser.displayName,
            'photoUrl': firebaseUser.photoURL,
            'id': firebaseUser.uid,
            'createdAt': DateTime.now().millisecondsSinceEpoch.toString(),
            'chattingWith': null
          });

          // Write data to local
          currentUser = firebaseUser;
          await prefs?.setString('id', currentUser!.uid);
          await prefs?.setString('nickname', currentUser!.displayName ?? '');
          await prefs?.setString('photoUrl', currentUser!.photoURL ?? '');
        } else {
          var documentSnapshot = documents[0];
          var userChat = UserChat.fromDocument(documentSnapshot);
          // Write data to local
          await prefs?.setString('id', userChat.id);
          await prefs?.setString('nickname', userChat.nickname);
          await prefs?.setString('photoUrl', userChat.photoUrl);
          await prefs?.setString('aboutMe', userChat.aboutMe);
        }
        Fluttertoast.showToast(msg: 'Sign in success');
        setState(() {
          isLoading = false;
        });

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => RemoteScreen(
              currentUserId: firebaseUser.uid,
              currentUserName: firebaseUser.displayName!,
              currentUserPhotoUrl: firebaseUser.photoURL!,
            ),
          ),
        );
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //     builder: (context) => HomeScreen(
        //       currentUserId: firebaseUser.uid,
        //       currentUserName: firebaseUser.displayName!,
        //       currentUserPhotoUrl: firebaseUser.photoURL!,
        //     ),
        //   ),
        // );
      } else {
        Fluttertoast.showToast(msg: 'Sign in fail');
        setState(() {
          isLoading = false;
        });
      }
    } else {
      Fluttertoast.showToast(msg: 'Can not init google sign in');
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kLoginViewBgColor,
      body: Stack(
        children: [
          Center(
            child: SizedBox(
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Spacer(),
                  const BigHeadingText(text: 'Welcome Back to', size: 22),
                  SizedBox(height: 20.h),
                  const BigHeadingText(text: 'Remotewa', size: 40),
                  const SigninIllustration(),
                  GoogleSigninButton(
                    onTap: () => handleSignIn().catchError((err) {
                      Fluttertoast.showToast(msg: err.toString());
                      setState(() {
                        isLoading = false;
                      });
                    }),
                  ),
                  const Spacer(),
                ],
              ),
            ),
          ),
          // Loading
          Positioned(
            child: isLoading ? const LoadingIndicator() : Container(),
          ),
        ],
      ),
    );
  }
}
