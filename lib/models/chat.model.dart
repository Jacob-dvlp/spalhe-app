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
  LastMessage? lastMessage;
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
    exitUsersIds = json['exit_users_ids'].cast<int>();
    user = json['user'] != null ? new UserModel.fromJson(json['user']) : null;
    lastMessage = json['last_message'] != null
        ? new LastMessage.fromJson(json['last_message'])
        : null;
    viewed = json['viewed'];
    countUnreadMessages = json['count_unread_messages'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['avatar'] = this.avatar;
    data['is_group'] = this.isGroup;
    data['exit_users_ids'] = this.exitUsersIds;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    if (this.lastMessage != null) {
      data['last_message'] = this.lastMessage!.toJson();
    }
    data['viewed'] = this.viewed;
    data['count_unread_messages'] = this.countUnreadMessages;
    return data;
  }
}

class LastMessage {
  String? message;
  String? createdAt;
  Files? files;

  LastMessage({this.message, this.createdAt, this.files});

  LastMessage.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    createdAt = json['created_at'];
    files = json['files'] != null ? new Files.fromJson(json['files']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['created_at'] = this.createdAt;
    if (this.files != null) {
      data['files'] = this.files!.toJson();
    }
    return data;
  }
}

class Files {
  String? id;
  String? url;

  Files({this.id, this.url});

  Files.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['url'] = this.url;
    return data;
  }
}
