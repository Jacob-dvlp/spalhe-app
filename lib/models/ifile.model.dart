class IFile {
  final String name;
  final String url;
  final String type;

  IFile({
    required this.name,
    required this.url,
    required this.type,
  });

  factory IFile.fromJson(Map<String, dynamic> json) {
    return IFile(
      name: json['name'],
      url: json['url'],
      type: json['type'],
    );
  }
}
