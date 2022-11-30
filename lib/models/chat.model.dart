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
  String? id;
  String? name;
  String? avatar;
  bool? isGroup;
  List<int>? exitUsersIds;
  UserModel? user;
  String? lastMessage;
  bool? viewed;
  int? countUnreadMessages;

  GetChats(
      {this.id,
      this.name,
      this.avatar,
      this.isGroup,
      this.exitUsersIds,
      this.user,
      this.lastMessage,
      this.viewed,
      this.countUnreadMessages});

  GetChats.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    avatar = json['avatar'];
    isGroup = json['is_group'];
    user = json['user'] != null ? new UserModel.fromJson(json['user']) : null;
    lastMessage = json['last_message'];
    viewed = json['viewed'];
    countUnreadMessages = json['count_unread_messages'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['avatar'] = this.avatar;
    data['is_group'] = this.isGroup;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    if (this.lastMessage != null) {
      data['last_message'] = this.lastMessage;
    }
    data['viewed'] = this.viewed;
    data['count_unread_messages'] = this.countUnreadMessages;
    return data;
  }
}
