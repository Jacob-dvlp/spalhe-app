class AuthModel {
  UserModel? user;
  String? token;

  AuthModel({this.user, this.token});

  AuthModel.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ? UserModel.fromJson(json['user']) : null;
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

class UserModel {
  bool? active;
  String? biography;
  String? email;
  int? id;
  String? name;
  String? username;
  bool? verified;
  String? avatar;
  Count? cCount;

  UserModel(
      {this.active,
      this.biography,
      this.email,
      this.id,
      this.name,
      this.verified,
      this.avatar,
      this.username,
      this.cCount});

  UserModel.fromJson(Map<String, dynamic> json) {
    active = json['active'];
    biography = json['biography'];
    email = json['email'];
    id = json['id'];
    name = json['name'];
    username = json['username'];
    verified = json['verified'];
    avatar = json['avatar'];
    cCount = json['_count'] != null ? Count.fromJson(json['_count']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['active'] = active;
    data['biography'] = biography;
    data['email'] = email;
    data['id'] = id;
    data['name'] = name;
    data['username'] = username;
    data['verified'] = verified;
    data['avatar'] = avatar;
    if (cCount != null) {
      data['_count'] = cCount!.toJson();
    }
    return data;
  }
}

class Count {
  int? followed;
  int? followers;
  int? posts;

  Count({this.followed, this.followers, this.posts});

  Count.fromJson(Map<String, dynamic> json) {
    followed = json['followed'];
    followers = json['followers'];
    posts = json['posts'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['followed'] = followed;
    data['followers'] = followers;
    data['posts'] = posts;
    return data;
  }
}
