class NotificationModel {
  GetNotifications? getNotifications;

  NotificationModel({this.getNotifications});

  NotificationModel.fromJson(Map<String, dynamic> json) {
    getNotifications = json['getNotifications'] != null
        ? new GetNotifications.fromJson(json['getNotifications'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.getNotifications != null) {
      data['getNotifications'] = this.getNotifications!.toJson();
    }
    return data;
  }
}

class GetNotifications {
  Meta? meta;
  List<INotification>? data;

  GetNotifications({this.meta, this.data});

  GetNotifications.fromJson(Map<String, dynamic> json) {
    meta = json['meta'] != null ? new Meta.fromJson(json['meta']) : null;
    if (json['data'] != null) {
      data = <INotification>[];
      json['data'].forEach((v) {
        data!.add(new INotification.fromJson(v));
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
  int? page;
  bool? nextPage;
  bool? previusPage;

  Meta({this.page, this.nextPage, this.previusPage});

  Meta.fromJson(Map<String, dynamic> json) {
    page = json['page'];
    nextPage = json['next_page'];
    previusPage = json['previus_page'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['page'] = this.page;
    data['next_page'] = this.nextPage;
    data['previus_page'] = this.previusPage;
    return data;
  }
}

class INotification {
  int? id;
  String? title;
  String? body;
  String? type;
  int? typeId;
  int? postId;
  int? commentId;
  int? momentId;
  bool? viewed;
  int? myUserId;
  String? createdAt;
  User? user;

  INotification({
    this.id,
    this.title,
    this.body,
    this.type,
    this.typeId,
    this.postId,
    this.commentId,
    this.momentId,
    this.viewed,
    this.myUserId,
    this.createdAt,
    this.user,
  });

  INotification.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    body = json['body'];
    type = json['type'];
    typeId = json['type_id'];
    postId = json['post_id'];
    commentId = json['comment_id'];
    momentId = json['moment_id'];
    viewed = json['viewed'];
    myUserId = json['my_user_id'];
    createdAt = json['created_at'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['body'] = this.body;
    data['type'] = this.type;
    data['type_id'] = this.typeId;
    data['post_id'] = this.postId;
    data['comment_id'] = this.commentId;
    data['moment_id'] = this.momentId;
    data['viewed'] = this.viewed;
    data['my_user_id'] = this.myUserId;
    data['created_at'] = this.createdAt;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    return data;
  }
}

class User {
  String? name;
  int? id;
  String? username;
  String? avatar;

  User({this.name, this.id, this.username, this.avatar});

  User.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    id = json['id'];
    username = json['username'];
    avatar = json['avatar'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['id'] = this.id;
    data['username'] = this.username;
    data['avatar'] = this.avatar;
    return data;
  }
}
