import 'package:spalhe/models/user.model.dart';

class CommentReplyModel {
  List<AllRepliesByCommentId>? allRepliesByCommentId;

  CommentReplyModel({this.allRepliesByCommentId});

  CommentReplyModel.fromJson(Map<String, dynamic> json) {
    if (json['allRepliesByCommentId'] != null) {
      allRepliesByCommentId = <AllRepliesByCommentId>[];
      json['allRepliesByCommentId'].forEach((v) {
        allRepliesByCommentId!.add(new AllRepliesByCommentId.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.allRepliesByCommentId != null) {
      data['allRepliesByCommentId'] =
          this.allRepliesByCommentId!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AllRepliesByCommentId {
  int? id;
  String? text;
  String? createdAt;
  UserModel? user;

  AllRepliesByCommentId({this.id, this.text, this.createdAt, this.user});

  AllRepliesByCommentId.fromJson(Map<String, dynamic> json) {
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
