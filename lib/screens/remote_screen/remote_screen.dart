import 'package:clay_containers/clay_containers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:remotewa/config/colors.dart';
import 'package:remotewa/screens/home_screen/home_screen.dart';
import 'package:remotewa/shared_widgets/big_heading_text.dart';
import 'package:remotewa/shared_widgets/loading_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../main.dart';
import 'components/charachter_action_widget.dart';
import 'components/logout_remote_button.dart';
import 'components/remote_button.dart';
import 'components/round_remote_button.dart';

/// temproray Saved Messages
///  It will be fetched from FireStore Database later
/// After impelmenting message Save Functionality
List<String> savedMessages = [
  'Hi Hamza Good Morning',
  'How are you?',
  'Are you winnig dude!!',
  'Lets catche up for Huddle in about 30 minutes',
  'Its a reminder for Deadline today',
  'Are you up and Working',
  'Zara Bahir tou aa laaley',
  'oo Zaalmaa! chal aa Lunch krney chalain',
  'Hurry up Yaar, I am waiting for your responce'
];

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

  /// groupChatId
  String groupChatId = '';

  ///peerId
  late String peerId = 'EaqfSJLumRb5ysigmnj6VRHCfpr1';

  ///peerId
  late String peerName = 'Hamza khalid';

  ///peerAvatar
  late String peerAvatar;

  /// id
  String? id;

  /// SharedPreferences
  SharedPreferences? prefs;

  @override
  void initState() {
    super.initState();

    /// buildFireStorChat
    /// to send the presaved message
    buildFireStorChat();
  }

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

  void buildFireStorChat() async {
    prefs = await SharedPreferences.getInstance();
    id = prefs?.getString('id') ?? '';
    if (id.hashCode <= peerId.hashCode) {
      groupChatId = '$id-$peerId';
    } else {
      groupChatId = '$peerId-$id';
    }

    FirebaseFirestore.instance
        .collection('users')
        .doc(id)
        .update({'chattingWith': peerId});

    setState(() {});
  }

  //************************************
  /// onSendMessage
  void onSendMessage(String content, int type) {
    setState(() => isLoading = true);

    // type: 0 = text, 1 = image, 2 = sticker
    if (content.trim() != '') {
      var documentReference = FirebaseFirestore.instance
          .collection('messages')
          .doc(groupChatId)
          .collection(groupChatId)
          .doc(DateTime.now().millisecondsSinceEpoch.toString());

      FirebaseFirestore.instance.runTransaction((transaction) async {
        transaction.set(
          documentReference,
          {
            'idFrom': id,
            'idTo': peerId,
            'timestamp': DateTime.now().millisecondsSinceEpoch.toString(),
            'content': content,
            'type': type
          },
        );
      }).then(
        (value) async {
          setState(() => isLoading = false);

          return await Fluttertoast.showToast(
              msg: 'Message Sent to $peerName',
              backgroundColor: kPrimaryDarkColor,
              textColor: Colors.white);
        },
      ).catchError(
        (error) async {
          setState(() => isLoading = false);
          return await Fluttertoast.showToast(
            msg: error.toString(),
            backgroundColor: Colors.red,
            textColor: Colors.white,
          );
        },
      );
    } else {
      setState(() => isLoading = false);
      Fluttertoast.showToast(
        msg: 'Nothing to send',
        backgroundColor: Colors.black,
        textColor: Colors.red,
      );
    }
  }
  // **************************************/

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
                                onLongPress: () => _showToast(
                                    context, savedMessages[0], peerName),
                                onTap: () {
                                  onSendMessage(savedMessages[0], 0);
                                },
                              ),
                              RemoteButton(
                                bgColor: const Color(0xFFbe7bd2),
                                title: '2',
                                onLongPress: () => _showToast(
                                    context, savedMessages[1], peerName),
                                onTap: () {
                                  onSendMessage(savedMessages[1], 0);
                                },
                              ),
                              RemoteButton(
                                bgColor: const Color(0xFF60a5d6),
                                title: '3',
                                onLongPress: () => _showToast(
                                    context, savedMessages[2], peerName),
                                onTap: () {
                                  onSendMessage(savedMessages[2], 0);
                                },
                              )
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              RemoteButton(
                                bgColor: const Color(0xFFbe7bd2),
                                title: '4',
                                onLongPress: () => _showToast(
                                    context, savedMessages[3], peerName),
                                onTap: () {
                                  onSendMessage(savedMessages[3], 0);
                                },
                              ),
                              RemoteButton(
                                bgColor: const Color(0xFF81d0e3),
                                title: '5',
                                onLongPress: () => _showToast(
                                    context, savedMessages[4], peerName),
                                onTap: () {
                                  onSendMessage(savedMessages[4], 0);
                                },
                              ),
                              RemoteButton(
                                bgColor: const Color(0xFF60a5d6),
                                title: '6',
                                onLongPress: () => _showToast(
                                    context, savedMessages[5], peerName),
                                onTap: () {
                                  onSendMessage(savedMessages[5], 0);
                                },
                              )
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              RemoteButton(
                                bgColor: const Color(0xFF81d0e3),
                                title: '7',
                                onLongPress: () => _showToast(
                                    context, savedMessages[6], peerName),
                                onTap: () {
                                  onSendMessage(savedMessages[6], 0);
                                },
                              ),
                              RemoteButton(
                                bgColor: const Color(0xFF60a5d6),
                                title: '8',
                                onLongPress: () => _showToast(
                                    context, savedMessages[7], peerName),
                                onTap: () {
                                  onSendMessage(savedMessages[7], 0);
                                },
                              ),
                              RemoteButton(
                                bgColor: const Color(0xFFbe7bd2),
                                title: '9',
                                onLongPress: () => _showToast(
                                    context, savedMessages[8], peerName),
                                onTap: () {
                                  onSendMessage(savedMessages[8], 0);
                                },
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

  void _showToast(BuildContext context, String message, String peerName) {
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(
      SnackBar(
        backgroundColor: kPrimaryColor,
        content: Text('to $peerName: $message'),
        action: SnackBarAction(
            textColor: kPrimaryDarkColor,
            label: 'Change',
            onPressed: scaffold.hideCurrentSnackBar),
      ),
    );
  }
}
