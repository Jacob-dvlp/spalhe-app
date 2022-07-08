import 'package:spalhe/models/user.model.dart';

class ChatMessageModel {
  List<GetChatMessages>? getChatMessages;

  ChatMessageModel({this.getChatMessages});

  ChatMessageModel.fromJson(Map<String, dynamic> json) {
    if (json['getChatMessages'] != null) {
      getChatMessages = <GetChatMessages>[];
      json['getChatMessages'].forEach((v) {
        getChatMessages!.add(new GetChatMessages.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.getChatMessages != null) {
      data['getChatMessages'] =
          this.getChatMessages!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class GetChatMessages {
  String? text;
  String? createdAt;
  int? chatId;
  UserModel? user;

  GetChatMessages({this.text, this.createdAt, this.chatId, this.user});

  GetChatMessages.fromJson(Map<String, dynamic> json) {
    text = json['text'];
    createdAt = json['created_at'];
    chatId = json['chat_id'];
    user = json['user'] != null ? new UserModel.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['text'] = this.text;
    data['created_at'] = this.createdAt;
    data['chat_id'] = this.chatId;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    return data;
  }
}
