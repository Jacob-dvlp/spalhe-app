class UsersModel {
  Meta? meta;
  List<Data>? data;

  UsersModel({this.meta, this.data});

  UsersModel.fromJson(Map<String, dynamic> json) {
    meta = json['meta'] != null ? new Meta.fromJson(json['meta']) : null;
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
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
  int? perPage;
  int? page;
  String? order;
  String? orderBy;
  int? total;
  bool? nextPage;
  bool? previusPage;

  Meta(
      {this.perPage,
      this.page,
      this.order,
      this.orderBy,
      this.total,
      this.nextPage,
      this.previusPage});

  Meta.fromJson(Map<String, dynamic> json) {
    perPage = json['per_page'];
    page = json['page'];
    order = json['order'];
    orderBy = json['order_by'];
    total = json['total'];
    nextPage = json['next_page'];
    previusPage = json['previus_page'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['per_page'] = this.perPage;
    data['page'] = this.page;
    data['order'] = this.order;
    data['order_by'] = this.orderBy;
    data['total'] = this.total;
    data['next_page'] = this.nextPage;
    data['previus_page'] = this.previusPage;
    return data;
  }
}

class Data {
  int? id;
  String? email;
  String? name;
  String? username;
  String? password;
  String? avatar;
  String? biography;
  bool? active;
  bool? verified;
  String? createdAt;
  String? updatedAt;
  List<Followed>? followed;

  Data(
      {this.id,
      this.email,
      this.name,
      this.username,
      this.password,
      this.avatar,
      this.biography,
      this.active,
      this.verified,
      this.createdAt,
      this.updatedAt,
      this.followed});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    name = json['name'];
    username = json['username'];
    password = json['password'];
    avatar = json['avatar'];
    biography = json['biography'];
    active = json['active'];
    verified = json['verified'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['followed'] != null) {
      followed = <Followed>[];
      json['followed'].forEach((v) {
        followed!.add(new Followed.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['email'] = this.email;
    data['name'] = this.name;
    data['username'] = this.username;
    data['password'] = this.password;
    data['avatar'] = this.avatar;
    data['biography'] = this.biography;
    data['active'] = this.active;
    data['verified'] = this.verified;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.followed != null) {
      data['followed'] = this.followed!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Followed {
  int? id;
  int? followerId;
  int? followedId;
  bool? active;
  String? createdAt;
  String? updatedAt;

  Followed(
      {this.id,
      this.followerId,
      this.followedId,
      this.active,
      this.createdAt,
      this.updatedAt});

  Followed.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    followerId = json['follower_id'];
    followedId = json['followed_id'];
    active = json['active'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['follower_id'] = this.followerId;
    data['followed_id'] = this.followedId;
    data['active'] = this.active;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
