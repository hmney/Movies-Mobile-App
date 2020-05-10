class TrailersModel {
  final String id;
  final String key;
  final String name;
  final String site;
  final String type;
  String thumbnail;

  TrailersModel(
      {this.id,
      this.key,
      this.name,
      this.site,
      this.type,
      this.thumbnail = ''});

  factory TrailersModel.fromJson(Map<dynamic, dynamic> json) {
    return TrailersModel(
      id: json['id'],
      key: json['key'],
      name: json['name'],
      site: json['site'],
      type: json['type'],
      thumbnail: json['site'].toString().toLowerCase() == 'youtube'
          ? 'http://img.youtube.com/vi/' + json['key'] + '/hqdefault.jpg'
          : '',
    );
  }
}
