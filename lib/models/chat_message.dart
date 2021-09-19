// ignore_for_file: prefer_collection_literals

class ChatMessage {
  String? uid;
  DateTime? createAt;
  String? sendername;
  String? senderEmail;
  String? text;

  ChatMessage(
      {this.uid, this.createAt, this.sendername, this.senderEmail, this.text});

  ChatMessage.fromJson(Map<String, dynamic> json) {
    uid = json['uid'] as String;
    createAt = json['createAt'] as DateTime;
    sendername = json['sendername'] as String;
    senderEmail = json['senderEmail'] as String;
    text = json['text'] as String;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['uid'] = uid;
    data['createAt'] = createAt;
    data['sendername'] = sendername;
    data['senderEmail'] = senderEmail;
    data['text'] = text;
    return data;
  }
}
