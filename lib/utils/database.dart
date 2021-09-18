import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:remotewa/models/aap_user.dart';
import 'package:remotewa/models/chat_message.dart';
import 'package:remotewa/models/feed_post.dart';

class Database {
  static final Database _singleton = Database._internal();

  factory Database() {
    return _singleton;
  }

  Database._internal();

  /// The main Firestore user collection
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('users');

  /// The main Firestore Messages collection
  final CollectionReference messageCollection =
      FirebaseFirestore.instance.collection('chatMessages');

  /// The main Firestore Posts collection
  final CollectionReference postsCollection =
      FirebaseFirestore.instance.collection('feedPosts');

  storeUserData({required User user}) async {
    AppUser appUser =
        AppUser(uid: user.uid, name: user.displayName, email: user.email);

    await userCollection
        .doc(user.uid)
        .set(appUser.toJson())
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }

  storeAMessage({required ChatMessage message, required User user}) async {
    await messageCollection
        .add(message.toJson())
        .then((value) => print("Message added int Database"))
        .catchError((error) => print("Failed to add user: $error"));
  }

  storePost({required FeedPost post, required User user}) async {
    await postsCollection
        .add(post.toJson())
        .then((value) => print("post added int Database"))
        .catchError((error) => print("Failed to add user: $error"));
  }

  updateJumpCount({required User user, required int likeCount}) async {
    await postsCollection
        .doc(user.uid)
        .update({'likes': likeCount})
        .then((value) => print("Like count Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }
}
