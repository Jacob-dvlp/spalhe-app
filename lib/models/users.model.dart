import 'package:spalhe/models/user.model.dart';

class UsersModel {
  Meta? meta;
  List<UserModel>? data;

  UsersModel({this.meta, this.data});

  UsersModel.fromJson(Map<String, dynamic> json) {
    meta = json['meta'] != null ? new Meta.fromJson(json['meta']) : null;
    if (json['data'] != null) {
      data = <UserModel>[];
      json['data'].forEach((v) {
        data!.add(new UserModel.fromJson(v));
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
  bool? previusPage;
  bool? nextPage;
  int? total;

  Meta({this.page, this.perPage, this.previusPage, this.nextPage, this.total});

  Meta.fromJson(Map<String, dynamic> json) {
    page = json['page'];
    perPage = json['per_page'];
    previusPage = json['previus_page'];
    nextPage = json['next_page'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['page'] = this.page;
    data['per_page'] = this.perPage;
    data['previus_page'] = this.previusPage;
    data['next_page'] = this.nextPage;
    data['total'] = this.total;
    return data;
  }
}
