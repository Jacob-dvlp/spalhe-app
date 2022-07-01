import 'package:spalhe/models/user.model.dart';

class CommentsModel {
  CommentsModel({
    required this.meta,
    required this.data,
  });
  late final Meta meta;
  late final List<Data> data;

  CommentsModel.fromJson(Map<String, dynamic> json) {
    meta = Meta.fromJson(json['meta']);
    data = List.from(json['data']).map((e) => Data.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['meta'] = meta.toJson();
    _data['data'] = data.map((e) => e.toJson()).toList();
    return _data;
  }
}

class Meta {
  Meta({
    required this.nextPage,
    required this.previusPage,
    required this.total,
    required this.page,
  });
  late final bool nextPage;
  late final bool previusPage;
  late final int total;
  late final int page;

  Meta.fromJson(Map<String, dynamic> json) {
    nextPage = json['next_page'];
    previusPage = json['previus_page'];
    total = json['total'];
    page = json['page'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['next_page'] = nextPage;
    _data['previus_page'] = previusPage;
    _data['total'] = total;
    _data['page'] = page;
    return _data;
  }
}

class Data {
  Data({
    required this.id,
    required this.text,
    required this.user,
  });
  late final int id;
  late final String text;
  late final UserModel user;

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    text = json['text'];
    user = UserModel.fromJson(json['user']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['text'] = text;
    _data['user'] = user.toJson();
    return _data;
  }
}
