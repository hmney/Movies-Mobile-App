import 'package:app/src/data/models/models.dart';
import 'package:app/src/data/models/trailers_model.dart';
import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' show Client;

class MoviesApiProvider {
  final _apiKey = '400aa52f1d1dfb1c52a9601683c2dae8';
  final _baseUrl = 'http://api.themoviedb.org/3';

  Client client = new Client();

  Future<List<GenresModel>> fetchGenresList() async {
    try {
      final response = await client.get("$_baseUrl/genre/movie/list?api_key=$_apiKey");
      if (response.statusCode == 200) {
        return GenresModel.fromJsonArray(json.decode(response.body));
      } else {
        throw Exception('Failed to fetch genres');
      }
    } catch (e) {
      print(e);
      throw Exception('Something went wrong, please try again.');
    }
  }

  Future<List<MoviesModel>> fetchMoviesByGenre(String genreId) async {
    try {
      final response = await client.get("$_baseUrl/discover/movie?api_key=$_apiKey&sort_by=popularity.desc&with_genres=$genreId");
      if (response.statusCode == 200) {
        var result = json.decode(response.body);
        return MoviesModel.fromJsonArray(result['results']);
      } else {
        throw Exception('Failed to fetch movies');
      }
    } catch (e) {
      print(e);
      throw Exception('Something went wrong, please try again.');
    }
  }

  Future<MoviesModel> fetchMovieDetails(int movieId) async {
    try {
      final response = await client.get("$_baseUrl/movie/$movieId?api_key=$_apiKey");
      if (response.statusCode == 200) {
        return MoviesModel.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to fetch movie details');
      }
    } catch (e) {
      print(e);
      throw Exception('Something went wrong, please try again.');
    }
  }

  Future<List<CastsModel>> fetchMovieCredits(int movieId) async {
    try {
      final response = await client.get("$_baseUrl/movie/$movieId/credits?api_key=$_apiKey");
      if (response.statusCode == 200) {
        var results = json.decode(response.body);
        return CastsModel.fromJsonArray(results['cast']);
      } else {
        throw Exception('Failed to fetch movie credits');
      }
    } catch (e) {
      print(e);
      throw Exception('Something went wrong, please try again.');
    }
  }

  Future<List<MoviesModel>> fetchMovieRecommendations(int movieId) async {
    try {
      final response = await client.get("$_baseUrl/movie/$movieId/recommendations?api_key=$_apiKey");
      if (response.statusCode == 200) {
        var results = json.decode(response.body);
        return MoviesModel.fromJsonArray(results['results']);
      } else {
        throw Exception('Failed to fetch movie recommendations');
      }
    } catch (e) {
      print(e);
      throw Exception('Something went wrong, please try again.');
    }
  }

  Future<List<MoviesModel>> fetchMoviebyName(String movieName) async {
    try {
      final response = await client.get("$_baseUrl/search/movie?api_key=$_apiKey?query=$movieName");
      if (response.statusCode == 200) {
        var results = json.decode(response.body);
        return MoviesModel.fromJsonArray(results['results']);
      } else {
        throw Exception('Failed to fetch movie searched');
      }
    } catch (e) {
      print(e);
      throw Exception('Something went wrong, please try again.');
    }
  }

  Future<TrailersModel> fetchMovieTraliers(int movieId) async {
    try {
      final response = await client.get("$_baseUrl/movie/$movieId/videos?api_key=$_apiKey");
      if (response.statusCode == 200) {
        return TrailersModel.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to fetch trailers');
      }
    } catch(e) {
      throw Exception('Something went wrong, please try again.');
    }
  }

  
}
