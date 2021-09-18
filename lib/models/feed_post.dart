class FeedPost {
  String? uid;
  DateTime? createAt;
  String? userName;
  String? userEmail;
  String? text;
  int? likes;

  FeedPost(
      {this.uid,
      this.createAt,
      this.userEmail,
      this.userName,
      this.text,
      this.likes});

  FeedPost.fromJson(Map<String, dynamic> json) {
    uid = json['uid'];
    createAt = json['createAt'];
    userName = json['userName'];
    userEmail = json['userEmail'];
    text = json['text'];
    likes = json['likes'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['uid'] = this.uid;
    data['createAt'] = this.createAt;
    data['userName'] = this.userName;
    data['userEmail'] = this.userEmail;
    data['text'] = this.text;
    data['likes'] = this.likes;
    return data;
  }
}
