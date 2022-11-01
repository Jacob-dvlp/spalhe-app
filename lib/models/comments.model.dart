import 'package:spalhe/models/user.model.dart';

class CommentsModel {
  GetCommentsPost? getCommentsPost;

  CommentsModel({this.getCommentsPost});

  CommentsModel.fromJson(Map<String, dynamic> json) {
    getCommentsPost = json['getCommentsPost'] != null
        ? new GetCommentsPost.fromJson(json['getCommentsPost'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.getCommentsPost != null) {
      data['getCommentsPost'] = this.getCommentsPost!.toJson();
    }
    return data;
  }
}

class GetCommentsPost {
  Meta? meta;
  List<IComment>? data;

  GetCommentsPost({this.meta, this.data});

  GetCommentsPost.fromJson(Map<String, dynamic> json) {
    meta = json['meta'] != null ? new Meta.fromJson(json['meta']) : null;
    if (json['data'] != null) {
      data = <IComment>[];
      json['data'].forEach((v) {
        data!.add(new IComment.fromJson(v));
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
  int? total;
  int? page;

  Meta({this.nextPage, this.previusPage, this.total, this.page});

  Meta.fromJson(Map<String, dynamic> json) {
    nextPage = json['next_page'];
    previusPage = json['previus_page'];
    total = json['total'];
    page = json['page'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['next_page'] = this.nextPage;
    data['previus_page'] = this.previusPage;
    data['total'] = this.total;
    data['page'] = this.page;
    return data;
  }
}

class IComment {
  int? id;
  String? text;
  String? createdAt;
  Count? cCount;
  UserModel? user;
  List<Replies>? replies;

  IComment(
      {this.id,
      this.text,
      this.createdAt,
      this.cCount,
      this.user,
      this.replies});

  IComment.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    text = json['text'];
    createdAt = json['created_at'];
    cCount = json['_count'] != null ? new Count.fromJson(json['_count']) : null;
    user = json['user'] != null ? new UserModel.fromJson(json['user']) : null;
    if (json['replies'] != null) {
      replies = <Replies>[];
      json['replies'].forEach((v) {
        replies!.add(new Replies.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['text'] = this.text;
    data['created_at'] = this.createdAt;
    if (this.cCount != null) {
      data['_count'] = this.cCount!.toJson();
    }
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    if (this.replies != null) {
      data['replies'] = this.replies!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Count {
  int? likes;
  int? replies;

  Count({this.likes, this.replies});

  Count.fromJson(Map<String, dynamic> json) {
    likes = json['likes'];
    replies = json['replies'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['likes'] = this.likes;
    data['replies'] = this.replies;
    return data;
  }
}

class Replies {
  int? id;
  String? text;
  String? createdAt;
  UserModel? user;

  Replies({this.id, this.text, this.createdAt, this.user});

  Replies.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    text = json['text'];
    createdAt = json['created_at'];
    user = json['user'] != null ? new UserModel.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['text'] = this.text;
    data['created_at'] = this.createdAt;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    return data;
  }
}
