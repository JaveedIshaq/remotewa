import 'package:clay_containers/clay_containers.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:remotewa/config/colors.dart';
import 'package:remotewa/screens/home_screen/home_screen.dart';
import 'package:remotewa/shared_widgets/big_heading_text.dart';
import 'package:remotewa/shared_widgets/loading_indicator.dart';

import '../../main.dart';
import 'components/charachter_action_widget.dart';
import 'components/logout_remote_button.dart';
import 'components/remote_button.dart';
import 'components/round_remote_button.dart';

/// Remote Screen
class RemoteScreen extends StatefulWidget {
  /// Remote Screen Constructor
  RemoteScreen({
    Key? key,
    required this.currentUserId,
    required this.currentUserName,
    required this.currentUserPhotoUrl,
  }) : super(key: key);

  /// Logged User Id
  final String currentUserId;

  /// Logged User Display Name
  final String currentUserName;

  /// Logged User Phoro URL
  final String currentUserPhotoUrl;

  @override
  State<RemoteScreen> createState() => _RemoteScreenState();
}

class _RemoteScreenState extends State<RemoteScreen> {
  /// is  Loading
  bool isLoading = false;

  /// Google Sign In
  final GoogleSignIn googleSignIn = GoogleSignIn();

  /// navigateToHomeScreen
  void navigateToHomeScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => HomeScreen(
          currentUserId: widget.currentUserId,
          currentUserName: widget.currentUserName,
          currentUserPhotoUrl: widget.currentUserPhotoUrl,
        ),
      ),
    );
  }

  /// Logout Function
  Future<void> handleSignOut() async {
    setState(() => isLoading = true);

    await FirebaseAuth.instance.signOut();
    await googleSignIn.disconnect();
    await googleSignIn.signOut();

    setState(() => isLoading = false);

    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => const MyApp()),
        (Route<dynamic> route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBgColor,
      body: Stack(
        children: [
          Center(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 38.0, horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ClayContainer(
                    borderRadius: 50,
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width * .70,
                    surfaceColor: const Color(0xFF7482d6),
                    parentColor: Colors.grey,
                    emboss: true,
                    spread: 2,
                    curveType: CurveType.concave,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 18.0),
                      child: Column(
                        children: [
                          LogoutRemoteButton(
                            onTap: handleSignOut,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              RemoteButton(
                                bgColor: const Color(0xFF81d0e3),
                                title: '1',
                                onTap: () {},
                              ),
                              RemoteButton(
                                bgColor: const Color(0xFFbe7bd2),
                                title: '2',
                                onTap: () {},
                              ),
                              RemoteButton(
                                bgColor: const Color(0xFF60a5d6),
                                title: '3',
                                onTap: () {},
                              )
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              RemoteButton(
                                bgColor: const Color(0xFFbe7bd2),
                                title: '5',
                                onTap: () {},
                              ),
                              RemoteButton(
                                bgColor: const Color(0xFF81d0e3),
                                title: '4',
                                onTap: () {},
                              ),
                              RemoteButton(
                                bgColor: const Color(0xFF60a5d6),
                                title: '6',
                                onTap: () {},
                              )
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              RemoteButton(
                                bgColor: const Color(0xFF81d0e3),
                                title: '7',
                                onTap: () {},
                              ),
                              RemoteButton(
                                bgColor: const Color(0xFF60a5d6),
                                title: '9',
                                onTap: () {},
                              ),
                              RemoteButton(
                                bgColor: const Color(0xFFbe7bd2),
                                title: '8',
                                onTap: () {},
                              ),
                            ],
                          ),
                          RoundRemoteButton(onTap: () {
                            navigateToHomeScreen(context);
                          }),
                          const Align(
                            alignment: Alignment.center,
                            child: Padding(
                              padding: EdgeInsets.only(top: 8.0),
                              child: BigHeadingText(
                                text: 'Remotewa',
                                size: 25,
                                textColor: kPrimaryDarkColor,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Column(
                    children: [
                      CharachterActionWidget(
                        title: 'Logout',
                        charImgName: 'logout',
                        onTap: handleSignOut,
                      ),
                      CharachterActionWidget(
                        title: 'Save',
                        charImgName: 'save-message',
                        onTap: () {
                          Fluttertoast.showToast(
                            msg: 'Functionality Coming Soon',
                            backgroundColor: kPrimaryDarkColor,
                          );
                        },
                      ),
                      CharachterActionWidget(
                        title: 'Chat',
                        charImgName: 'send-message',
                        onTap: () {
                          navigateToHomeScreen(context);
                        },
                      )
                    ],
                  )
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
