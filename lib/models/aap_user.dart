// ignore_for_file: prefer_collection_literals

class AppUser {
  String? uid;
  String? name;
  String? email;

  AppUser({this.uid, this.name, this.email});

  AppUser.fromJson(Map<String, dynamic> json) {
    uid = json['uid'];
    name = json['name'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['uid'] = uid;
    data['name'] = name;
    data['email'] = email;
    return data;
  }
}
