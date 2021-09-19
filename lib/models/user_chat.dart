/* 
************************** File Information *******************************

Date        : 2021/09/18

Author      : Javeed Ishaq (www.javeedishaq.com)

Description : UserChat Model Class

This File contains Style Objects of the App

**************************************************************************** 
*/

import 'package:cloud_firestore/cloud_firestore.dart';

/// Model Class for Chat User
class UserChat {
  /// UserChat constructor
  UserChat(
      {required this.id,
      required this.photoUrl,
      required this.nickname,
      required this.aboutMe});

  /// Id of user
  String id;

  /// Photo Url
  String photoUrl;

  /// Photo nickName
  String nickname;

  /// About the User
  String aboutMe;

  /// Factory Constructor
  // ignore: sort_constructors_first
  factory UserChat.fromDocument(DocumentSnapshot doc) {
    String aboutMe = '';
    String photoUrl = '';
    String nickname = '';
    try {
      aboutMe = doc.get('aboutMe') as String;
    } catch (e) {}
    try {
      photoUrl = doc.get('photoUrl') as String;
    } catch (e) {}
    try {
      nickname = doc.get('nickname') as String;
    } catch (e) {}
    return UserChat(
      id: doc.id,
      photoUrl: photoUrl,
      nickname: nickname,
      aboutMe: aboutMe,
    );
  }
}
