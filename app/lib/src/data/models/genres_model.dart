class GenresModel {
  final int id;
  final String name;

  GenresModel({this.id, this.name});

  factory GenresModel.fromJson(Map<String, dynamic> json) {
    return GenresModel(
      id: json['id'],
      name: json['name'],
    );
  }

  static List<GenresModel> fromJsonArray(List jsonArray) {
    return jsonArray?.map((item) {
      return GenresModel.fromJson(item);
    })?.toList();
  }
}
