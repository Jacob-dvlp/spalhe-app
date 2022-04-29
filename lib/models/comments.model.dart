import 'package:spalhe/models/auth.dart';

class CommentsModel {
  int? id;
  String? text;
  int? postId;
  int? userId;
  String? createdAt;
  String? updatedAt;
  UserModel? user;

  CommentsModel(
      {this.id,
      this.text,
      this.postId,
      this.userId,
      this.createdAt,
      this.updatedAt,
      this.user});

  CommentsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    text = json['text'];
    postId = json['post_id'];
    userId = json['user_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    user = json['user'] != null ? new UserModel.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['text'] = this.text;
    data['post_id'] = this.postId;
    data['user_id'] = this.userId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    return data;
  }
}
