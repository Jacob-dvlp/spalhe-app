import 'package:flutter/material.dart';

enum ItemType { sticker, text }

enum StickerType { sticker, hours, music }

class ItemMoment {
  Matrix4? position;
  ItemType? type;
  Sticker? sticker;

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

class Sticker {
  String? name;
  String? path;
  StickerType? type;

  Sticker({this.name, this.path, this.type});

  factory Sticker.fromJson(Map<String, dynamic> json) {
    return Sticker(
      name: json['name'],
      path: json['path'],
      type: StickerType.values[json['type']],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'path': path,
      'type': type?.index,
    };
  }
}
