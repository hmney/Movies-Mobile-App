class CastsModel {
  final int id;
  final int castId;
  final String name;
  final String profilePath;

  CastsModel({this.id, this.castId, this.name, this.profilePath});

  factory CastsModel.fromJson(Map<String, dynamic> json) {
    return CastsModel(
      id: json['id'],
      castId: json['cast_id'],
      name: json['name'],
      profilePath: json['profile_path'] != null ? 'https://image.tmdb.org/t/p/w200' + json['profile_path'] : null
    );
  }
  
  static List<CastsModel> fromJsonArray(List jsonArray) {
    return jsonArray?.map((item) {
      return CastsModel.fromJson(item);
    })?.toList();
  }
}