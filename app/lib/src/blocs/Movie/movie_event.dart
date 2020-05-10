part of 'movie_bloc.dart';

@immutable
abstract class MovieEvent extends Equatable {
  MovieEvent();

  @override
  List get props => [];
}

// class FetchHomeMovies extends MovieEvent {
//   FetchHomeMovies();

//   @override
//   List get props => [];
// }

// class FetchGenreMovies extends MovieEvent {
//   final String genreId;
//   FetchGenreMovies({@required this.genreId}) : assert(genreId != null);

//   @override
//   List get props => [genreId];  
// }

// class FetchMovieDetails extends MovieEvent {
//   final int movieId;

//   FetchMovieDetails({@required this.movieId}) : assert(movieId != null);

//   @override
//   List get props => [movieId]; 
// }

// class SearchMovie extends MovieEvent {
//   final String movieName;

//   SearchMovie({@required this.movieName}) : assert(movieName != null);

//   @override
//   List get props => [movieName]; 
// }
