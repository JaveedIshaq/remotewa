import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:remotewa/config/colors.dart';
import 'package:remotewa/config/helper_functions.dart';
import 'package:remotewa/screens/new_post.dart';
import 'package:remotewa/shared_widgets/logout_button.dart';
import 'package:remotewa/shared_widgets/text_button.dart';
import 'package:share/share.dart';

final _firestore = FirebaseFirestore.instance;

class PostFeedScreen extends StatefulWidget {
  const PostFeedScreen({Key? key, required this.user}) : super(key: key);

  final User? user;

  @override
  _PostFeedScreenState createState() => _PostFeedScreenState();
}

class _PostFeedScreenState extends State<PostFeedScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: kBgColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Padding(
          padding: EdgeInsets.only(top: 20.w, left: 0),
          child: ChatTextButton(
              title: 'Back',
              textColor: kPrimaryDarkColor,
              onTap: () {
                Navigator.of(context).pop();
              }),
        ),
        actions: [
          LogoutButton(
            iconColor: kPrimaryDarkColor,
            icon: Icons.logout,
            onTap: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CreateNewPost(user: widget.user),
                  ),
                );
              },
              child: const Text(
                'Create a New Post',
                style: TextStyle(fontSize: 14),
              ),
            ),
            FeedStream(user: widget.user),
          ],
        ),
      ),
    );
  }
}

class FeedStream extends StatelessWidget {
  const FeedStream({Key? key, required this.user}) : super(key: key);

  final User? user;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream:
            _firestore.collection('feedPosts').orderBy('createAt').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          return ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              reverse: true,
              shrinkWrap: true,
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                var time = snapshot.data!.docs[index].get('createAt').toDate();
                var name = snapshot.data!.docs[index].get('userName');
                var email = snapshot.data!.docs[index].get('userEmail');
                var text = snapshot.data!.docs[index].get('text');

                var likes = snapshot.data!.docs[index].get('likes');

                print('$name $time $text');

                return PostWidget(
                  time: time,
                  name: name,
                  text: text,
                  likes: likes,
                  email: email,
                );
              });
        });
  }
}

class PostWidget extends StatelessWidget {
  const PostWidget({
    Key? key,
    required this.text,
    required this.name,
    required this.time,
    required this.likes,
    required this.email,
  }) : super(key: key);

  final String text;
  final String name;
  final DateTime time;
  final String email;
  final int likes;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    var shortName = getInitials(name);
    return Column(
      children: [
        ListTile(
          leading: CircleAvatar(
            backgroundColor: kPrimaryColor.withOpacity(0.6),
            child: Text(
              shortName,
              style: const TextStyle(
                color: kPrimaryDarkColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          title: Text(
            name,
            style: const TextStyle(
              color: kPrimaryDarkColor,
              fontWeight: FontWeight.w500,
            ),
          ),
          subtitle: Text(
            email,
            style: TextStyle(
                color: Colors.grey[500],
                fontWeight: FontWeight.w400,
                fontSize: 12.sp),
          ),
        ),
        Container(
          width: size.width * 0.8,
          height: 200.w,
          decoration: BoxDecoration(
            color: kPrimaryColor.withOpacity(0.9),
            borderRadius: BorderRadius.circular(20),
          ),
          padding: const EdgeInsets.all(10),
          child: Center(
              child: Text(
            text,
            style: const TextStyle(
              color: kBgColor,
              fontSize: 18,
            ),
          )),
        ),
        SizedBox(
          width: size.width * 0.8,
          child: Row(
            children: [
              //buildLikeIconButton(),
              buildShareIconButton(postText: text, userName: name),
            ],
          ),
        ),
      ],
    );
  }

  InkWell buildLikeIconButton() {
    return InkWell(
      onTap: () {},
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset(
              "assets/images/heart-icon.png",
              color: (likes > 0) ? kPrimaryColor : Colors.black,
            ),
          ),
          (likes > 0) ? Text('$likes') : Container(),
        ],
      ),
    );
  }

  InkWell buildShareIconButton({required String postText, required userName}) {
    return InkWell(
      onTap: () async {
        await Share.share(
          'a Post by $userName:\n\n$postText',
          subject: "a Post by: $userName",
        );
      },
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset(
              "assets/images/share_icon.png",
              color: kPrimaryDarkColor,
            ),
          ),
          const Text('Share')
        ],
      ),
    );
  }
}
