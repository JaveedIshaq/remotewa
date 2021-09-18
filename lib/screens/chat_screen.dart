import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:remotewa/config/colors.dart';
import 'package:remotewa/config/helper_functions.dart';

import 'package:remotewa/config/ui_helpers.dart';
import 'package:remotewa/models/chat_message.dart';
import 'package:remotewa/screens/login_screen.dart';
import 'package:remotewa/screens/post_feed_creen.dart';
import 'package:remotewa/shared_widgets/chat_message_bubble.dart';
import 'package:remotewa/shared_widgets/chat_messages_parent.dart';
import 'package:remotewa/shared_widgets/chat_parent.dart';
import 'package:remotewa/shared_widgets/chat_screen_heading.dart';
import 'package:remotewa/shared_widgets/logout_button.dart';
import 'package:remotewa/shared_widgets/message_send_button.dart';
import 'package:remotewa/shared_widgets/text_button.dart';
import 'package:remotewa/utils/authentication.dart';
import 'package:remotewa/utils/database.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

final _firestore = FirebaseFirestore.instance;

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key, required this.user}) : super(key: key);

  final User? user;

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  late String textMessage = "";
  final Database database = Database();

  TextEditingController _messageEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            ChatParent(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 28.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('${widget.user!.displayName!}'),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                ChatTextButton(
                                    title: 'Posts Feed',
                                    textColor: kBgColor,
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => PostFeedScreen(
                                            user: widget.user,
                                          ),
                                        ),
                                      );
                                    }),
                                LogoutButton(
                                  iconColor: kBgColor,
                                  icon: Icons.logout,
                                  onTap: () async {
                                    await Authentication.signOut(
                                        context: context);

                                    Navigator.of(context).pushAndRemoveUntil(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                LoginScreen()),
                                        (Route<dynamic> route) => false);
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                        ChatScreenHeading(),
                      ],
                    ),
                  ),
                  ChatUsersList(),
                  ChatMessagesParent(
                      child: Column(
                    children: [
                      MesageStream(user: widget.user!),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: size.width * 0.7,
                              child: TextFormField(
                                controller: _messageEditingController,
                                decoration: messageInputDecoration,
                                onChanged: (value) {
                                  setState(() {
                                    textMessage = value;
                                  });
                                },
                              ),
                            ),
                            MessageSendButton(
                              onTap: () {
                                if (textMessage != "") {
                                  // clear the message input field
                                  _messageEditingController.clear();

                                  /// submit message to store into DB
                                  database.storeAMessage(
                                    message: ChatMessage(
                                      uid: widget.user!.uid,
                                      createAt: DateTime.now(),
                                      sendername: widget.user!.displayName,
                                      senderEmail: widget.user!.email,
                                      text: textMessage,
                                    ),
                                    user: widget.user!,
                                  );
                                }
                              },
                            )
                          ],
                        ),
                      ),
                    ],
                  ))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MesageStream extends StatelessWidget {
  MesageStream({Key? key, required this.user}) : super(key: key);

  final User user;

  Widget build(BuildContext context) {
    print('height: ${MediaQuery.of(context).size.height}');
    print('width: ${MediaQuery.of(context).size.width}');

    return StreamBuilder<QuerySnapshot>(
        stream: _firestore
            .collection('chatMessages')
            .orderBy('createAt')
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }

          return Expanded(
            child: ListView.builder(
                reverse: false,
                shrinkWrap: true,
                physics: AlwaysScrollableScrollPhysics(),
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  var time =
                      snapshot.data!.docs[index].get('createAt').toDate();
                  var name = snapshot.data!.docs[index].get('sendername');

                  var text = snapshot.data!.docs[index].get('text');

                  print('$name $time $text');

                  return ChatMessageBubble(time: time, name: name, text: text);
                }),
          );
        });
  }
}

/// user list
class ChatUsersList extends StatelessWidget {
  const ChatUsersList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _firestore.collection('users').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(child: CircularProgressIndicator());
        }

        return Container(
          padding: EdgeInsets.only(left: 30.w),
          height: 45,
          child: ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                var name = getInitials(snapshot.data!.docs[index].get('name'));
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5.w),
                  child: CircleAvatar(child: Text('$name'.toUpperCase())),
                );
              }),
        );
      },
    );
  }
}
