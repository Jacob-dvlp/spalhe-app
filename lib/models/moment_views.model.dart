import 'package:spalhe/models/user.model.dart';

class IMomentViews {
  final UserModel? user;

  IMomentViews({this.user});

  factory IMomentViews.fromJson(Map<String, dynamic> json) {
    return IMomentViews(
      user: UserModel.fromJson(json['user']),
    );
  }
}
