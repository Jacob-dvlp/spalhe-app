class ChatMessageModel {
  GetChatMessages? getChatMessages;

  ChatMessageModel({this.getChatMessages});

  ChatMessageModel.fromJson(Map<String, dynamic> json) {
    getChatMessages = json['getChatMessages'] != null
        ? new GetChatMessages.fromJson(json['getChatMessages'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.getChatMessages != null) {
      data['getChatMessages'] = this.getChatMessages!.toJson();
    }
    return data;
  }
}

class GetChatMessages {
  Meta? meta;
  List<Messages>? data;

  GetChatMessages({this.meta, this.data});

  GetChatMessages.fromJson(Map<String, dynamic> json) {
    meta = json['meta'] != null ? new Meta.fromJson(json['meta']) : null;
    if (json['data'] != null) {
      data = <Messages>[];
      json['data'].forEach((v) {
        data!.add(new Messages.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.meta != null) {
      data['meta'] = this.meta!.toJson();
    }
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Meta {
  bool? nextPage;
  bool? previusPage;

  Meta({this.nextPage, this.previusPage});

  Meta.fromJson(Map<String, dynamic> json) {
    nextPage = json['next_page'];
    previusPage = json['previus_page'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['next_page'] = this.nextPage;
    data['previus_page'] = this.previusPage;
    return data;
  }
}

class Messages {
  String? id;
  String? message;
  String? createdAt;
  int? userId;
  Files? files;
  User? user;

  Messages(
      {this.id,
      this.message,
      this.createdAt,
      this.userId,
      this.files,
      this.user});

  Messages.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    message = json['message'];
    createdAt = json['created_at'];
    userId = json['user_id'];
    files = json['files'] != null ? new Files.fromJson(json['files']) : null;
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['message'] = this.message;
    data['created_at'] = this.createdAt;
    data['user_id'] = this.userId;
    if (this.files != null) {
      data['files'] = this.files!.toJson();
    }
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    return data;
  }
}

class Files {
  String? id;
  String? type;
  String? url;

  Files({this.id, this.type, this.url});

  Files.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['type'] = this.type;
    data['url'] = this.url;
    return data;
  }
}

class User {
  int? id;
  String? name;
  String? status;
  String? username;

  User({this.id, this.name, this.status, this.username});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    status = json['status'];
    username = json['username'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['status'] = this.status;
    data['username'] = this.username;
    return data;
  }
}
