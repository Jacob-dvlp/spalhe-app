import 'package:spalhe/models/user.model.dart';

class AuthModel {
  String? token;
  UserModel? user;

  AuthModel({this.token, this.user});

  AuthModel.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    user = json['user'] != null ? new UserModel.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['token'] = this.token;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    return data;
  }
}
