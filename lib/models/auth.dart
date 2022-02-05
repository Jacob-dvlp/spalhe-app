class AuthModel {
  User? user;
  String? token;

  AuthModel({this.user, this.token});

  AuthModel.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (user != null) {
      data['user'] = user!.toJson();
    }
    data['token'] = token;
    return data;
  }
}

class User {
  int? id;
  String? name;
  String? email;
  String? username;
  String? avatar;
  String? biography;
  bool? private;
  bool? active;

  User({
    this.id,
    this.name,
    this.email,
    this.username,
    this.biography,
    this.private,
    this.active,
    this.avatar,
  });

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    avatar = json['avatar'];
    username = json['username'];
    biography = json['biography'];
    private = json['private'];
    active = json['active'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['email'] = email;
    data['username'] = username;
    data['biography'] = biography;
    data['private'] = private;
    data['active'] = active;
    return data;
  }
}
