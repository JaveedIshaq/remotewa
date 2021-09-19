/* 
************************** File Information *******************************

Date        : 2021/09/18

Author      : Javeed Ishaq (www.javeedishaq.com)

Description : Helper Functions

This File contains Style Objects of the App

**************************************************************************** 
*/

/// Model Class for App User
class AppUser {
  String? uid;
  String? name;
  String? email;

  AppUser({this.uid, this.name, this.email});

  AppUser.fromJson(Map<String, dynamic> json) {
    uid = json['uid'] as String;
    name = json['name'] as String;
    email = json['email'] as String;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['uid'] = uid;
    data['name'] = name;
    data['email'] = email;
    return data;
  }
}
