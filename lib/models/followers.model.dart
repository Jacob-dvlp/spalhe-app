class FollowersModel {
  Meta? meta;
  List<Data>? data;

  FollowersModel({this.meta, this.data});

  FollowersModel.fromJson(Map<String, dynamic> json) {
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

  Meta({this.perPage, this.page, this.order, this.orderBy, this.total});

  Meta.fromJson(Map<String, dynamic> json) {
    perPage = json['per_page'];
    page = json['page'];
    order = json['order'];
    orderBy = json['order_by'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['per_page'] = this.perPage;
    data['page'] = this.page;
    data['order'] = this.order;
    data['order_by'] = this.orderBy;
    data['total'] = this.total;
    return data;
  }
}

class Data {
  int? id;
  int? followerId;
  int? followedId;
  bool? active;
  String? createdAt;
  String? updatedAt;
  Follower? follower;

  Data(
      {this.id,
      this.followerId,
      this.followedId,
      this.active,
      this.createdAt,
      this.updatedAt,
      this.follower});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    followerId = json['follower_id'];
    followedId = json['followed_id'];
    active = json['active'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    follower = json['follower'] != null
        ? new Follower.fromJson(json['follower'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['follower_id'] = this.followerId;
    data['followed_id'] = this.followedId;
    data['active'] = this.active;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.follower != null) {
      data['follower'] = this.follower!.toJson();
    }
    return data;
  }
}

class Follower {
  String? name;
  int? id;
  String? avatar;

  Follower({this.name, this.id, this.avatar});

  Follower.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    id = json['id'];
    avatar = json['avatar'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['id'] = this.id;
    data['avatar'] = this.avatar;
    return data;
  }
}
