class HashtagsModel {
  List<GetHastags>? getHashtags;

  HashtagsModel({this.getHashtags});

  HashtagsModel.fromJson(Map<String, dynamic> json) {
    if (json['getHashtags'] != null) {
      getHashtags = <GetHastags>[];
      json['getHashtags'].forEach((v) {
        getHashtags!.add(new GetHastags.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.getHashtags != null) {
      data['getHashtags'] = this.getHashtags!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class GetHastags {
  int? id;
  String? hastag;
  Count? cCount;
  String? createdAt;
  String? updatedAt;

  GetHastags(
      {this.id, this.hastag, this.cCount, this.createdAt, this.updatedAt});

  GetHastags.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    hastag = json['hastag'];
    cCount = json['_count'] != null ? new Count.fromJson(json['_count']) : null;
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['hastag'] = this.hastag;
    if (this.cCount != null) {
      data['_count'] = this.cCount!.toJson();
    }
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class Count {
  int? hashtagsOnPost;

  Count({this.hashtagsOnPost});

  Count.fromJson(Map<String, dynamic> json) {
    hashtagsOnPost = json['hashtags_on_post'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['hashtags_on_post'] = this.hashtagsOnPost;
    return data;
  }
}
