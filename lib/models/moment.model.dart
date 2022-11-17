class MomentModel {
  int? id;
  String? avatar;
  String? username;
  String? name;
  bool? verified;
  List<Moments>? moments;

  MomentModel({
    this.id,
    this.avatar,
    this.username,
    this.name,
    this.moments,
    this.verified,
  });

  MomentModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    avatar = json['avatar'];
    username = json['username'];
    name = json['name'];
    verified = json['verified'];
    if (json['moments'] != null) {
      moments = <Moments>[];
      json['moments'].forEach((v) {
        moments!.add(new Moments.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['avatar'] = this.avatar;
    data['username'] = this.username;
    data['name'] = this.name;
    data['verified'] = this.verified;
    if (this.moments != null) {
      data['moments'] = this.moments!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Moments {
  int? id;
  String? url;
  String? createdAt;
  String? type;
  String? subtype;

  Moments({this.url, this.createdAt, this.type, this.subtype});

  Moments.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    url = json['url'];
    createdAt = json['created_at'];
    type = json['type'];
    subtype = json['subtype'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['url'] = this.url;
    data['created_at'] = this.createdAt;
    data['type'] = this.type;
    data['subtype'] = this.subtype;
    return data;
  }
}
