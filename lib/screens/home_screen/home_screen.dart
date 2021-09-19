/* 
************************** File Information *******************************

Date        : 2021/09/18

Author      : Javeed Ishaq (www.javeedishaq.com)

Description : Home Screen

Home View in the App

**************************************************************************** 
*/

import 'dart:async';
import 'dart:io';
import 'package:clay_containers/clay_containers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:remotewa/config/colors.dart';
import 'package:remotewa/config/helper_functions.dart';
import 'package:remotewa/models/user_chat.dart';
import 'package:remotewa/screens/chat_screen/chat_screen.dart';
import 'package:remotewa/screens/settings_screen/settings_screen.dart';
import 'package:remotewa/shared_widgets/loading_indicator.dart';

import '../../main.dart';

/// Home Screen
class HomeScreen extends StatefulWidget {
  /// Constructor
  const HomeScreen({
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
  State createState() => HomeScreenState();
}

/// Home State Class
class HomeScreenState extends State<HomeScreen> {
  /// firebase push Notification Service
  final FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;

  /// Flutter Local Notification
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  /// Google Sign In
  final GoogleSignIn googleSignIn = GoogleSignIn();

  /// Scoll Contoller
  final ScrollController listScrollController = ScrollController();

  /// Limit of messages
  int _limit = 20;
  final int _limitIncrement = 20;

  /// is  Loading
  bool isLoading = false;

  /// Chouices
  List<Choice> choices = const <Choice>[
    Choice(title: 'Settings', icon: Icons.settings),
    Choice(title: 'Log out', icon: Icons.exit_to_app),
  ];

  @override
  void initState() {
    super.initState();

    listScrollController.addListener(scrollListener);
  }

  /// Scroll
  void scrollListener() {
    if (listScrollController.offset >=
            listScrollController.position.maxScrollExtent &&
        !listScrollController.position.outOfRange) {
      setState(() {
        _limit += _limitIncrement;
      });
    }
  }

  ///
  void onItemMenuPress(Choice choice) {
    if (choice.title == 'Log out') {
      handleSignOut();
    } else {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => ChatSettings()));
    }
  }

  /// On Back Press
  Future<bool> onBackPress() {
    openLogoutDialog(context);
    return Future.value(false);
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

//*************** HomeScreen Scaffold ******************* */
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBgColor,
      appBar: buildHomeScreenAppBar(context),
      body: buildHomeScreenBody(),
    );
  }
//********************************** */

  ///
  WillPopScope buildHomeScreenBody() {
    return WillPopScope(
      onWillPop: onBackPress,
      child: Stack(
        children: <Widget>[
          // List
          StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('users')
                .limit(_limit)
                .snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                  padding: const EdgeInsets.all(10.0),
                  itemBuilder: (context, index) {
                    if (snapshot.data?.docs[index].id != widget.currentUserId) {
                      return buildItem(context, snapshot.data?.docs[index]);
                    }

                    return Container();
                  },
                  itemCount: snapshot.data?.docs.length,
                  controller: listScrollController,
                );
              } else {
                return Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
                  ),
                );
              }
            },
          ),

          // Loading
          Positioned(
            child: isLoading ? const LoadingIndicator() : Container(),
          )
        ],
      ),
    );
  }

  /// buildHomeScreenAppBar
  AppBar buildHomeScreenAppBar(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
      title: const Text(
        'Chat Home',
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
      centerTitle: true,
      actions: <Widget>[
        buildLogoutPopUp(),
      ],
    );
  }

  ///buildLogoutPopUp
  PopupMenuButton<Choice> buildLogoutPopUp() {
    return PopupMenuButton<Choice>(
      onSelected: onItemMenuPress,
      itemBuilder: (BuildContext context) {
        return choices.map((Choice choice) {
          return PopupMenuItem<Choice>(
              value: choice,
              child: Row(
                children: <Widget>[
                  Icon(
                    choice.icon,
                    color: primaryColor,
                  ),
                  Container(
                    width: 10.0,
                  ),
                  Text(
                    choice.title,
                    style: TextStyle(color: primaryColor),
                  ),
                ],
              ));
        }).toList();
      },
    );
  }

  /// build Avialable User Item
  Widget buildItem(BuildContext context, DocumentSnapshot? document) {
    if (document != null) {
      var userChat = UserChat.fromDocument(document);
      return Container(
        margin: const EdgeInsets.only(bottom: 10.0, left: 5.0, right: 5.0),
        child: ClayContainer(
          color: Colors.grey[400],
          spread: 3,
          curveType: CurveType.concave,
          borderRadius: 10,
          child: TextButton(
            child: Row(
              children: <Widget>[
                Material(
                  child: userChat.photoUrl != ''
                      ? ClayContainer(
                          color: Colors.grey[800],
                          child: Image.network(
                            userChat.photoUrl,
                            fit: BoxFit.cover,
                            width: 50.0,
                            height: 50.0,
                            loadingBuilder: (BuildContext context, Widget child,
                                ImageChunkEvent? loadingProgress) {
                              if (loadingProgress == null) return child;
                              return SizedBox(
                                width: 50,
                                height: 50,
                                child: Center(
                                  child: CircularProgressIndicator(
                                    color: primaryColor,
                                    value: loadingProgress.expectedTotalBytes !=
                                                null &&
                                            loadingProgress
                                                    .expectedTotalBytes !=
                                                null
                                        ? loadingProgress
                                                .cumulativeBytesLoaded /
                                            loadingProgress.expectedTotalBytes!
                                        : null,
                                  ),
                                ),
                              );
                            },
                            errorBuilder: (context, object, stackTrace) {
                              return Icon(
                                Icons.account_circle,
                                size: 50.0,
                                color: greyColor,
                              );
                            },
                          ),
                        )
                      : Icon(
                          Icons.account_circle,
                          size: 50.0,
                          color: greyColor,
                        ),
                  borderRadius: const BorderRadius.all(Radius.circular(25.0)),
                  clipBehavior: Clip.hardEdge,
                ),
                Flexible(
                  child: Container(
                    child: Column(
                      children: <Widget>[
                        Container(
                          child: Text(
                            userChat.nickname,
                            maxLines: 1,
                            style: TextStyle(
                              color: primaryColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          alignment: Alignment.centerLeft,
                          margin:
                              const EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 5.0),
                        ),
                        Container(
                          child: Text(
                            userChat.aboutMe,
                            maxLines: 1,
                            style: const TextStyle(color: Colors.grey),
                          ),
                          alignment: Alignment.centerLeft,
                          margin:
                              const EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 0.0),
                        )
                      ],
                    ),
                    margin: const EdgeInsets.only(left: 20.0),
                  ),
                ),
              ],
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Chat(
                    peerId: userChat.id,
                    peerAvatar: userChat.photoUrl,
                    peerName: userChat.nickname,
                  ),
                ),
              );
            },
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(greyColor2),
              shape: MaterialStateProperty.all<OutlinedBorder>(
                const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
              ),
            ),
          ),
        ),
      );
    } else {
      return const SizedBox.shrink();
    }
  }
}

///
class Choice {
  ///
  const Choice({required this.title, required this.icon});

  ///
  final String title;

  ///
  final IconData icon;
}
