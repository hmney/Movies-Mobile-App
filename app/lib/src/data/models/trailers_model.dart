class TrailersModel {
  final String id;
  final String key;
  final String name;
  final String site;
  final String type;
  final int size;

  TrailersModel(
      {this.id,
      this.key,
      this.name,
      this.site,
      this.type,
      this.size});

  factory TrailersModel.fromJson(Map<String, dynamic> json) {
    return TrailersModel(
      id: json['id'],
      key: json['key'],
      name: json['name'],
      site: json['site'],
      type: json['type'],
      size: json['size']
    );
  }

  static List<TrailersModel> fromJsonArray(List jsonArray) {
    return jsonArray?.map((item) {
      return TrailersModel.fromJson(item);
    })?.toList();
  }
}
