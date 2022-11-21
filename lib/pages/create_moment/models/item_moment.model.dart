import 'package:flutter/material.dart';

enum ItemType { sticker, text }

enum StickerType { sticker, hours, music }

class ItemMoment {
  Matrix4? position;
  ItemType? type;
  StickerModel? sticker;

  ItemMoment({
    this.position,
    this.type,
    this.sticker,
  });

  factory ItemMoment.fromJson(Map<String, dynamic> json) {
    return ItemMoment(
      position: json['position'],
      type: json['type'],
      sticker: json['sticker'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'position': position?.storage,
      'type': type?.index,
      'sticker': sticker?.toJson(),
    };
  }
}

class TextMoment {
  String? text;
  TextStyleMoment? style;

  TextMoment({
    this.text,
    this.style,
  });

  factory TextMoment.fromJson(Map<String, dynamic> json) {
    return TextMoment(
      text: json['text'],
      style: TextStyleMoment.fromJson(json['style']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'text': text,
      'style': style?.toJson(),
    };
  }
}

class TextStyleMoment {
  Color? color;
  double? fontSize;
  FontWeight? fontWeight;
  String? fontFamily;

  TextStyleMoment({
    this.color,
    this.fontSize,
    this.fontWeight,
    this.fontFamily,
  });

  factory TextStyleMoment.fromJson(Map<String, dynamic> json) {
    return TextStyleMoment(
      color: Color(json['color']),
      fontSize: json['fontSize'],
      fontWeight: FontWeight.values[json['fontWeight']],
      fontFamily: json['fontFamily'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'color': color!.value,
      'fontSize': fontSize,
      'fontWeight': fontWeight!.index,
      'fontFamily': fontFamily,
    };
  }
}

class StickerModel {
  String? name;
  String? path;
  StickerType? type;
  HoursModel? hours;
  MusicModel? music;

  StickerModel({this.name, this.path, this.type, this.hours, this.music});

  factory StickerModel.fromJson(Map<String, dynamic> json) {
    return StickerModel(
      name: json['name'],
      path: json['path'],
      type: StickerType.values[json['type']],
      hours: json['hours'] != null ? HoursModel.fromJson(json['hours']) : null,
      music: json['music'] != null ? MusicModel.fromJson(json['music']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'path': path,
      'type': type?.index,
      'hours': hours?.toJson(),
      'music': music?.toJson(),
    };
  }
}

class HoursModel {
  String? hours;

  HoursModel({this.hours});

  factory HoursModel.fromJson(Map<String, dynamic> json) {
    return HoursModel(
      hours: json['hours'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'hours': hours,
    };
  }
}

class MusicModel {
  String? title;
  String? url;
  String? preview;
  String? artistName;

  MusicModel({
    this.title,
    this.preview,
    this.url,
    this.artistName,
  });

  factory MusicModel.fromJson(Map<String, dynamic> json) {
    return MusicModel(
      title: json['title'],
      preview: json['preview'],
      url: json['url'],
      artistName: json['artistName'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'preview': preview,
      'url': url,
      'artistName': artistName,
    };
  }
}
