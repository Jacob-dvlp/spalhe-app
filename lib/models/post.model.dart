import 'auth.dart';

class PostModel {
  Meta? meta;
  List<PostData>? data;

  PostModel({this.meta, this.data});

  PostModel.fromJson(Map<String, dynamic> json) {
    meta = json['meta'] != null ? new Meta.fromJson(json['meta']) : null;
    if (json['data'] != null) {
      data = <PostData>[];
      json['data'].forEach((v) {
        data!.add(new PostData.fromJson(v));
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

class PostData {
  int? id;
  String? text;
  bool? published;
  int? userId;
  int? locationId;
  String? createdAt;
  String? updatedAt;
  UserModel? user;
  List<Likes>? likes;
  List<Medias>? medias;
  List<Mentions>? mentions;
  Count? cCount;
  Location? location;

  PostData({
    this.id,
    this.text,
    this.published,
    this.userId,
    this.locationId,
    this.createdAt,
    this.updatedAt,
    this.user,
    this.medias,
    this.mentions,
    this.cCount,
    this.location,
    this.likes,
  });

  PostData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    text = json['text'];
    published = json['published'];
    userId = json['user_id'];
    locationId = json['location_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    user = json['user'] != null ? new UserModel.fromJson(json['user']) : null;
    if (json['likes'] != null) {
      likes = <Likes>[];
      json['likes'].forEach((v) {
        likes!.add(new Likes.fromJson(v));
      });
    }
    location = json['location'] != null
        ? new Location.fromJson(json['location'])
        : null;
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
    if (this.location != null) {
      data['location'] = this.location!.toJson();
    }
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

class Location {
  String? name;
  int? id;

  Location({this.name, this.id});

  Location.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['id'] = this.id;
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

class Mentions {
  UserModel? user;

  Mentions({this.user});

  Mentions.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ? new UserModel.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.user != null) {
      data['user'] = this.user!.toJson();
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
