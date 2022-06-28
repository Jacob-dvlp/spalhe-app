import 'package:spalhe/models/post.model.dart';

class PostMediaModel {
  int? id;
  String? text;
  bool? published;
  int? userId;
  int? locationId;
  String? createdAt;
  String? updatedAt;
  List<Likes>? likes;
  String? location;
  User? user;
  List<Medias>? medias;
  List<Mentions>? mentions;
  Count? cCount;

  PostMediaModel(
      {this.id,
      this.text,
      this.published,
      this.userId,
      this.locationId,
      this.createdAt,
      this.updatedAt,
      this.likes,
      this.location,
      this.user,
      this.medias,
      this.mentions,
      this.cCount});

  PostMediaModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    text = json['text'];
    published = json['published'];
    userId = json['user_id'];
    locationId = json['location_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['likes'] != null) {
      likes = <Likes>[];
      json['likes'].forEach((v) {
        likes!.add(new Likes.fromJson(v));
      });
    }
    location = json['location'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    if (json['medias'] != null) {
      medias = <Medias>[];
      json['medias'].forEach((v) {
        medias!.add(new Medias.fromJson(v));
      });
    }
    if (json['mentions'] != null) {
      mentions = <Mentions>[];
      json['mentions'].forEach((v) {
        mentions!.add(new Mentions.fromJson(v));
      });
    }
    cCount = json['_count'] != null ? new Count.fromJson(json['_count']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['text'] = this.text;
    data['published'] = this.published;
    data['user_id'] = this.userId;
    data['location_id'] = this.locationId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.likes != null) {
      data['likes'] = this.likes!.map((v) => v.toJson()).toList();
    }
    data['location'] = this.location;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    if (this.medias != null) {
      data['medias'] = this.medias!.map((v) => v.toJson()).toList();
    }
    if (this.mentions != null) {
      data['mentions'] = this.mentions!.map((v) => v.toJson()).toList();
    }
    if (this.cCount != null) {
      data['_count'] = this.cCount!.toJson();
    }
    return data;
  }
}

class Likes {
  int? userId;

  Likes({this.userId});

  Likes.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    return data;
  }
}

class User {
  String? name;
  String? avatar;
  int? id;
  String? username;

  User({this.name, this.avatar, this.id, this.username});

  User.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    avatar = json['avatar'];
    id = json['id'];
    username = json['username'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['avatar'] = this.avatar;
    data['id'] = this.id;
    data['username'] = this.username;
    return data;
  }
}

class Medias {
  String? url;
  String? type;
  String? subtype;

  Medias({this.url, this.type, this.subtype});

  Medias.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    type = json['type'];
    subtype = json['subtype'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['url'] = this.url;
    data['type'] = this.type;
    data['subtype'] = this.subtype;
    return data;
  }
}

class Count {
  int? mentions;
  int? likes;
  int? comments;

  Count({this.mentions, this.likes, this.comments});

  Count.fromJson(Map<String, dynamic> json) {
    mentions = json['mentions'];
    likes = json['likes'];
    comments = json['comments'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['mentions'] = this.mentions;
    data['likes'] = this.likes;
    data['comments'] = this.comments;
    return data;
  }
}
