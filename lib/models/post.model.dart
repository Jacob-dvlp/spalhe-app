class PostModel {
  Meta? meta;
  List<PostData>? data;

  PostModel({this.meta, this.data});

  PostModel.fromJson(Map<String, dynamic> json) {
    meta = json['meta'] != null ? Meta.fromJson(json['meta']) : null;
    if (json['data'] != null) {
      data = <PostData>[];
      json['data'].forEach((v) {
        data!.add(PostData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (meta != null) {
      data['meta'] = meta!.toJson();
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['per_page'] = perPage;
    data['page'] = page;
    data['order'] = order;
    data['order_by'] = orderBy;
    data['total'] = total;
    return data;
  }
}

class PostData {
  int? id;
  String? text;
  int? sharePostId;
  int? shareUserId;
  int? userId;
  User? user;
  List<Medias>? medias;
  List<int>? mentions;

  PostData({
    this.id,
    this.text,
    this.sharePostId,
    this.shareUserId,
    this.userId,
    this.medias,
    this.mentions,
    this.user,
  });

  PostData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    text = json['text'];
    sharePostId = json['share_post_id'];
    shareUserId = json['share_user_id'];
    userId = json['user_id'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    if (json['medias'] != null) {
      medias = <Medias>[];
      json['medias'].forEach((v) {
        medias!.add(Medias.fromJson(v));
      });
    }
    if (json['mentions'] != null) {
      mentions = <int>[];
      json['mentions'].forEach((v) {
        mentions!.add(v);
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['text'] = text;
    data['share_post_id'] = sharePostId;
    data['share_user_id'] = shareUserId;
    data['user_id'] = userId;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    if (medias != null) {
      data['medias'] = medias!.map((v) => v.toJson()).toList();
    }
    if (mentions != null) {
      data['mentions'] = mentions!.map((v) => v).toList();
    }
    return data;
  }
}

class User {
  int? id;
  String? name;
  String? email;
  String? username;
  bool? private;
  String? avatar;

  User(
      {this.id,
      this.name,
      this.email,
      this.username,
      this.private,
      this.avatar});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    username = json['username'];
    private = json['private'];
    avatar = json['avatar'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['email'] = email;
    data['username'] = username;
    data['private'] = private;
    data['avatar'] = avatar;
    return data;
  }
}

class Medias {
  int? id;
  String? name;
  String? file;
  String? url;
  String? type;
  String? subtype;
  int? postId;

  Medias({
    this.id,
    this.name,
    this.file,
    this.url,
    this.type,
    this.subtype,
    this.postId,
  });

  Medias.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    file = json['file'];
    url = json['url'];
    type = json['type'];
    subtype = json['subtype'];
    postId = json['post_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['file'] = file;
    data['url'] = url;
    data['type'] = type;
    data['subtype'] = subtype;
    data['post_id'] = postId;
    return data;
  }
}
