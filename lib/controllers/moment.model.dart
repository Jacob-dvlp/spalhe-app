class MomentsModel {
  String? name;
  String? avatar;
  int? id;
  List<Moments>? moments;

  MomentsModel({this.name, this.avatar, this.id, this.moments});

  MomentsModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    avatar = json['avatar'];
    id = json['id'];
    if (json['moments'] != null) {
      moments = <Moments>[];
      json['moments'].forEach((v) {
        moments!.add(new Moments.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['avatar'] = this.avatar;
    data['id'] = this.id;
    if (this.moments != null) {
      data['moments'] = this.moments!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Moments {
  int? id;
  String? url;
  String? type;
  String? createdAt;
  String? subtype;

  Moments({this.id, this.url, this.type, this.createdAt, this.subtype});

  Moments.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    url = json['url'];
    type = json['type'];
    createdAt = json['created_at'];
    subtype = json['subtype'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['url'] = this.url;
    data['type'] = this.type;
    data['created_at'] = this.createdAt;
    data['subtype'] = this.subtype;
    return data;
  }
}
