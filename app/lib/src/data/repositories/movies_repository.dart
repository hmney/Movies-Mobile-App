import 'package:app/src/data/data_providers/movies_api_provider.dart';
import 'package:app/src/data/models/models.dart';
import 'dart:async';

class MoviesRepository {
  final MoviesApiProvider _moviesApiProvider;

  MoviesRepository({MoviesApiProvider moviesApiProvider})
      : _moviesApiProvider = moviesApiProvider ?? MoviesApiProvider();

  Future<List<GenresModel>> getGenresList() async {
    return _moviesApiProvider.fetchGenresList();
  }

  Future<List<MoviesModel>> getMoviesByGenre(String genreId) async {
    return _moviesApiProvider.fetchMoviesByGenre(genreId);
  }

  Future<List<List<MoviesModel>>> getMoviesforHomePage() async {
    final genres = await getGenresList();
    print(genres.length);
    final List<List<MoviesModel>> homePageMovies = List();

    genres.forEach((genre) async {
      final List<MoviesModel> moviesList = await getMoviesByGenre(genre.name.toString());
      homePageMovies.add(moviesList);
    });
    return homePageMovies;
  }

  Future<MoviesModel> getMovieDetails(int movieId) async {
    return _moviesApiProvider.fetchMovieDetails(movieId);
  }

  Future<List<CastsModel>> getMovieCredits(int movieId) async {
    return _moviesApiProvider.fetchMovieCredits(movieId);
  }

  Future<List<MoviesModel>> gethMovieRecommendations(int movieId) async {
    return _moviesApiProvider.fetchMovieRecommendations(movieId);
  }

  Future<List<MoviesModel>> fetchMoviebyName(String movieName) async {
    return _moviesApiProvider.fetchMoviebyName(movieName);
  }

  Future<TrailersModel> fetchMovieTraliers(int movieId) async {
    return _moviesApiProvider.fetchMovieTraliers(movieId);
  }
}
