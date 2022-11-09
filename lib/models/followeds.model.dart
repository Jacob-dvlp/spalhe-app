class FollowedModel {
  GetFollowed? getFollowed;

  FollowedModel({this.getFollowed});

  FollowedModel.fromJson(Map<String, dynamic> json) {
    getFollowed = json['getFollowed'] != null
        ? new GetFollowed.fromJson(json['getFollowed'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.getFollowed != null) {
      data['getFollowed'] = this.getFollowed!.toJson();
    }
    return data;
  }
}

class GetFollowed {
  Meta? meta;
  List<Data>? data;

  GetFollowed({this.meta, this.data});

  GetFollowed.fromJson(Map<String, dynamic> json) {
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
  Followed? followed;

  Data({this.active, this.status, this.followed});

  Data.fromJson(Map<String, dynamic> json) {
    active = json['active'];
    status = json['status'];
    followed = json['followed'] != null
        ? new Followed.fromJson(json['followed'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['active'] = this.active;
    data['status'] = this.status;
    if (this.followed != null) {
      data['followed'] = this.followed!.toJson();
    }
    return data;
  }
}

class Followed {
  int? id;
  String? name;
  String? username;
  String? avatar;

  Followed({this.id, this.name, this.username, this.avatar});

  Followed.fromJson(Map<String, dynamic> json) {
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
