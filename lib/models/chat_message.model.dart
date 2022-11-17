import 'package:modal_gif_picker/modal_gif_picker.dart';
import 'package:spalhe/models/user.model.dart';

class Messages {
  String? id;
  String? message;
  String? createdAt;
  int? userId;
  Files? files;
  UserModel? user;
  GiphyGif? gif;

  Messages({
    this.id,
    this.message,
    this.createdAt,
    this.userId,
    this.files,
    this.user,
    this.gif,
  });

  Messages.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    message = json['message'];
    createdAt = json['created_at'];
    userId = json['user_id'];
    files = json['files'] != null ? new Files.fromJson(json['files']) : null;
    user = json['user'] != null ? new UserModel.fromJson(json['user']) : null;
    gif = json['gif'] != null ? new GiphyGif.fromJson(json['gif']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['message'] = this.message;
    data['created_at'] = this.createdAt;
    data['user_id'] = this.userId;
    if (this.files != null) {
      data['files'] = this.files?.toJson();
    }
    if (this.user != null) {
      data['user'] = this.user?.toJson();
    }
    if (this.gif != null) {
      data['gif'] = this.gif?.toJson();
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
