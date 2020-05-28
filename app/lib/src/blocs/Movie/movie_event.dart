part of 'movie_bloc.dart';

@immutable
abstract class MovieEvent extends Equatable {
  MovieEvent();

  @override
  List get props => [];
}

class FetchMovieDetails extends MovieEvent {
  final MoviesModel moviesDetails;

  FetchMovieDetails({@required this.moviesDetails})
      : assert(moviesDetails != null);

  @override
  List get props => [moviesDetails];
}
