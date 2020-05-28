class MoviesModel {
  final int id;
  final String name;
  final List<int> genres;
  final dynamic rating;
  final String posterPath;
  final String overview;

  MoviesModel({this.id, this.name, this.genres, this.rating, this.posterPath, this.overview});

  factory MoviesModel.fromJson(Map<String, dynamic> json) {
    return MoviesModel(
      id: json['id'],
      name: json['original_title'],
      genres: json['genre_ids'].cast<int>(),
      rating: json['vote_average'],
      posterPath: json['poster_path'],
      overview: json['overview'],
    );
  }

  static List<MoviesModel> fromJsonArray(List jsonArray) {
    return jsonArray?.map((item) {
      return MoviesModel.fromJson(item);
    })?.toList();
  }
}