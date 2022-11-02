import 'package:spalhe/models/user.model.dart';

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
  int? page;
  int? perPage;
  int? total;
  bool? previusPage;
  bool? nextPage;

  Meta({this.page, this.perPage, this.total, this.previusPage, this.nextPage});

  Meta.fromJson(Map<String, dynamic> json) {
    page = json['page'];
    perPage = json['per_page'];
    total = json['total'];
    previusPage = json['previus_page'];
    nextPage = json['next_page'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['page'] = this.page;
    data['per_page'] = this.perPage;
    data['total'] = this.total;
    data['previus_page'] = this.previusPage;
    data['next_page'] = this.nextPage;
    return data;
  }
}

class PostData {
  int? id;
  String? text;
  bool? published;
  bool? isLiked;
  List<Medias>? medias;
  Location? location;
  List<Mentions>? mentions;
  UserModel? user;
  PostData? repost;
  Count? cCount;
  String? createdAt;

  PostData({
    this.id,
    this.text,
    this.published,
    this.isLiked,
    this.medias,
    this.location,
    this.mentions,
    this.user,
    this.cCount,
    this.repost,
    this.createdAt,
  });

  PostData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    text = json['text'];
    published = json['published'];
    isLiked = json['is_liked'];
    if (json['medias'] != null) {
      medias = <Medias>[];
      json['medias'].forEach((v) {
        medias!.add(new Medias.fromJson(v));
      });
    }
    location = json['location'] != null
        ? new Location.fromJson(json['location'])
        : null;
    if (json['mentions'] != null) {
      mentions = <Mentions>[];
      json['mentions'].forEach((v) {
        mentions!.add(new Mentions.fromJson(v));
      });
    }
    user = json['user'] != null ? new UserModel.fromJson(json['user']) : null;
    cCount = json['_count'] != null ? new Count.fromJson(json['_count']) : null;
    repost =
        json['repost'] != null ? new PostData.fromJson(json['repost']) : null;
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['text'] = this.text;
    data['published'] = this.published;
    data['is_liked'] = this.isLiked;
    if (this.medias != null) {
      data['medias'] = this.medias!.map((v) => v.toJson()).toList();
    }
    if (this.location != null) {
      data['location'] = this.location!.toJson();
    }
    if (this.mentions != null) {
      data['mentions'] = this.mentions!.map((v) => v.toJson()).toList();
    }
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    if (this.cCount != null) {
      data['_count'] = this.cCount!.toJson();
    }
    if (this.repost != null) {
      data['repost'] = this.repost!.toJson();
    }
    data['created_at'] = this.createdAt;
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

class Location {
  int? id;
  String? name;

  Location({this.id, this.name});

  Location.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}

class Mentions {
  UserMention? user;

  Mentions({this.user});

  Mentions.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ? new UserMention.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    return data;
  }
}

class UserMention {
  int? id;
  String? name;
  String? avatar;

  UserMention({this.id, this.name, this.avatar});

  UserMention.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    avatar = json['avatar'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['avatar'] = this.avatar;
    return data;
  }
}

class Count {
  int? mentions;
  int? likes;
  int? comments;
  int? reposts;

  Count({
    this.mentions,
    this.likes,
    this.comments,
    this.reposts,
  });

  Count.fromJson(Map<String, dynamic> json) {
    mentions = json['mentions'];
    likes = json['likes'];
    comments = json['comments'];
    reposts = json['reposts'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['mentions'] = this.mentions;
    data['likes'] = this.likes;
    data['comments'] = this.comments;
    data['reposts'] = this.reposts;
    return data;
  }
}
