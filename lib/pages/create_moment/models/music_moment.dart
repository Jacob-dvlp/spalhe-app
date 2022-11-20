class MusicMomentModel {
  SearchMusicMoment? searchMusicMoment;

  MusicMomentModel({this.searchMusicMoment});

  MusicMomentModel.fromJson(Map<String, dynamic> json) {
    searchMusicMoment = json['searchMusicMoment'] != null
        ? new SearchMusicMoment.fromJson(json['searchMusicMoment'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.searchMusicMoment != null) {
      data['searchMusicMoment'] = this.searchMusicMoment!.toJson();
    }
    return data;
  }
}

class SearchMusicMoment {
  List<IMusicMoment>? data;

  SearchMusicMoment({this.data});

  SearchMusicMoment.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <IMusicMoment>[];
      json['data'].forEach((v) {
        data!.add(new IMusicMoment.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class IMusicMoment {
  int? id;
  String? title;
  String? preview;
  int? duration;
  String? link;
  Album? album;

  IMusicMoment(
      {this.id,
      this.title,
      this.preview,
      this.duration,
      this.link,
      this.album});

  IMusicMoment.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    preview = json['preview'];
    duration = json['duration'];
    link = json['link'];
    album = json['album'] != null ? new Album.fromJson(json['album']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['preview'] = this.preview;
    data['duration'] = this.duration;
    data['link'] = this.link;
    if (this.album != null) {
      data['album'] = this.album!.toJson();
    }
    return data;
  }
}

class Album {
  int? id;
  String? title;
  String? cover;

  Album({this.id, this.title, this.cover});

  Album.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    cover = json['cover'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['cover'] = this.cover;
    return data;
  }
}
