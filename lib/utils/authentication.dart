import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

/// Authenticatio Class
class Authentication {
  /// sign in with Google.
  static Future<User?> signInWithGoogle() async {
    FirebaseAuth _auth = FirebaseAuth.instance;
    try {
      UserCredential userCredential;

      final GoogleSignInAccount googleUser = (await GoogleSignIn().signIn())!;
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final googleAuthCredential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      userCredential = await _auth.signInWithCredential(googleAuthCredential);

      final user = userCredential.user;
      return user;
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
  }

  /// Sign out Functionlity
  static Future<void> signOut({required BuildContext context}) async {
    try {
      await FirebaseAuth.instance.signOut();
    } catch (e) {
      print(e);
    }
  }
}
