import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:remotewa/config/colors.dart';
import 'package:remotewa/config/ui_helpers.dart';
import 'package:remotewa/models/feed_post.dart';
import 'package:remotewa/shared_widgets/text_button.dart';
import 'package:remotewa/utils/database.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CreateNewPost extends StatefulWidget {
  const CreateNewPost({Key? key, required this.user}) : super(key: key);

  final User? user;

  @override
  _CreateNewPostState createState() => _CreateNewPostState();
}

class _CreateNewPostState extends State<CreateNewPost> {
  late String textMessage = "";
  final Database database = Database();
  final _postFormKey = GlobalKey<FormState>();
  TextEditingController _postEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: kPrimaryDarkColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Padding(
          padding: EdgeInsets.only(top: 20.w, left: 0),
          child: ChatTextButton(
              title: 'Back',
              textColor: kBgColor,
              onTap: () {
                Navigator.of(context).pop();
              }),
        ),
      ),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.edit, color: kBgColor),
                    Text(
                      "Add a New Post",
                      style: headingStyle.copyWith(color: kBgColor),
                    ),
                  ],
                ),
                SizedBox(height: 30.h),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  padding: EdgeInsets.only(top: 30.h),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(40.r),
                      topLeft: Radius.circular(40.r),
                    ),
                  ),
                  child: new Column(
                    children: <Widget>[
                      Form(
                        key: _postFormKey,
                        child: Column(
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width * 0.7,
                              child: TextFormField(
                                maxLines: 5,
                                controller: _postEditingController,
                                decoration: postInputDecoration,
                                onChanged: (value) {
                                  setState(() {
                                    textMessage = value;
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 10.h),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(30.0),
                          ),
                        ),
                        onPressed: () {
                          if (textMessage != "") {
                            // clear the message input field
                            _postEditingController.clear();

                            /// submit message to store into DB
                            database.storePost(
                              post: FeedPost(
                                uid: widget.user!.uid,
                                createAt: DateTime.now(),
                                userName: widget.user!.displayName,
                                userEmail: widget.user!.email,
                                text: textMessage,
                                likes: 0,
                              ),
                              user: widget.user!,
                            );

                            Navigator.of(context).pop();
                          }
                        },
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 30, vertical: 10),
                          child: Text(
                            'Create'.toUpperCase(),
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 60.h),
                        child: SvgPicture.asset(
                            "assets/svgs/undraw_Login_re_4vu2.svg",
                            width: MediaQuery.of(context).size.width * 0.4,
                            semanticsLabel: 'Acme Logo'),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
