class Video {
  final String id;
  final String key;
  final String name;
  final String site;
  final int size;
  final String type;

  Video({
    required this.id,
    required this.key,
    required this.name,
    required this.site,
    required this.size,
    required this.type,
  });

  factory Video.fromJson(Map<String, dynamic> json) {
    return Video(
      id: json['id'].toString(),
      key: json['key'].toString(),
      name: json['name'].toString(),
      site: json['site'].toString(),
      size: json['size'] as int,
      type: json['type'].toString(),
    );
  }
}
