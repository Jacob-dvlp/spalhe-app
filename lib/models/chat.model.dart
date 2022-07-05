import 'package:spalhe/models/user.model.dart';

class ChatModel {
  List<GetChats>? getChats;

  ChatModel({this.getChats});

  ChatModel.fromJson(Map<String, dynamic> json) {
    if (json['getChats'] != null) {
      getChats = <GetChats>[];
      json['getChats'].forEach((v) {
        getChats!.add(new GetChats.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.getChats != null) {
      data['getChats'] = this.getChats!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class GetChats {
  int? id;
  List<Messages>? messages;
  UserModel? user;

  GetChats({this.id, this.messages, this.user});

  GetChats.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    if (json['messages'] != null) {
      messages = <Messages>[];
      json['messages'].forEach((v) {
        messages!.add(new Messages.fromJson(v));
      });
    }
    user = json['user'] != null ? new UserModel.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.messages != null) {
      data['messages'] = this.messages!.map((v) => v.toJson()).toList();
    }
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    return data;
  }
}

class Messages {
  String? text;
  int? id;
  List<String>? medias;
  int? userId;
  String? createdAt;

  Messages({this.text, this.id, this.medias, this.userId, this.createdAt});

  Messages.fromJson(Map<String, dynamic> json) {
    text = json['text'];
    id = json['id'];
    medias = json['medias'].cast<String>();
    userId = json['user_id'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['text'] = this.text;
    data['id'] = this.id;
    data['medias'] = this.medias;
    data['user_id'] = this.userId;
    data['created_at'] = this.createdAt;
    return data;
  }
}
