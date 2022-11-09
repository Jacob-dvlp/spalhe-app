class FollowerModel {
  GetFollowers? getFollowers;

  FollowerModel({this.getFollowers});

  FollowerModel.fromJson(Map<String, dynamic> json) {
    getFollowers = json['getFollowers'] != null
        ? new GetFollowers.fromJson(json['getFollowers'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.getFollowers != null) {
      data['getFollowers'] = this.getFollowers!.toJson();
    }
    return data;
  }
}

class GetFollowers {
  Meta? meta;
  List<Data>? data;

  GetFollowers({this.meta, this.data});

  GetFollowers.fromJson(Map<String, dynamic> json) {
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
  bool? nextPage;
  bool? previusPage;
  int? page;
  int? perPage;
  int? total;

  Meta({this.nextPage, this.previusPage, this.page, this.perPage, this.total});

  Meta.fromJson(Map<String, dynamic> json) {
    nextPage = json['next_page'];
    previusPage = json['previus_page'];
    page = json['page'];
    perPage = json['per_page'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['next_page'] = this.nextPage;
    data['previus_page'] = this.previusPage;
    data['page'] = this.page;
    data['per_page'] = this.perPage;
    data['total'] = this.total;
    return data;
  }
}

class Data {
  bool? active;
  String? status;
  Follower? follower;

  Data({this.active, this.status, this.follower});

  Data.fromJson(Map<String, dynamic> json) {
    active = json['active'];
    status = json['status'];
    follower = json['follower'] != null
        ? new Follower.fromJson(json['follower'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['active'] = this.active;
    data['status'] = this.status;
    if (this.follower != null) {
      data['follower'] = this.follower!.toJson();
    }
    return data;
  }
}

class Follower {
  int? id;
  String? name;
  String? username;
  String? avatar;

  Follower({this.id, this.name, this.username, this.avatar});

  Follower.fromJson(Map<String, dynamic> json) {
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
