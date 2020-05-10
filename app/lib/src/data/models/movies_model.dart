import 'package:app/src/data/models/genres_model.dart';

class MoviesModel {
  final int id;
  final String name;
  final List<dynamic> genres;
  final dynamic rating;
  final String posterPath;
  final String overview;

  MoviesModel({this.id, this.name, this.genres, this.rating, this.posterPath, this.overview});

  factory MoviesModel.fromJson(Map<String, dynamic> json) {
    return MoviesModel(
      id: json['id'],
      name: json['original_title'],
      genres: GenresModel.fromJsonArray(json['genres']),
      rating: json['vote_average'],
      posterPath: 'https://image.tmdb.org/t/p/w500' + json['poster_path'],
      overview: json['overview'],
    );
  }

  static List<MoviesModel> fromJsonArray(List jsonArray) {
    return jsonArray?.map((item) {
      return MoviesModel.fromJson(item);
    })?.toList();
  }
}