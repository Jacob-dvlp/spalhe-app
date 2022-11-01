class LikesInPostModel {
  List<GetPostLikes>? getPostLikes;

  LikesInPostModel({this.getPostLikes});

  LikesInPostModel.fromJson(Map<String, dynamic> json) {
    if (json['getPostLikes'] != null) {
      getPostLikes = <GetPostLikes>[];
      json['getPostLikes'].forEach((v) {
        getPostLikes!.add(new GetPostLikes.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.getPostLikes != null) {
      data['getPostLikes'] = this.getPostLikes!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class GetPostLikes {
  int? id;
  User? user;

  GetPostLikes({this.id, this.user});

  GetPostLikes.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    return data;
  }
}

class User {
  int? id;
  String? name;
  String? username;
  String? avatar;

  User({this.id, this.name, this.username, this.avatar});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    username = json['username'];
    avatar = json['avatar'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['username'] = this.username;
    data['avatar'] = this.avatar;
    return data;
  }
}
