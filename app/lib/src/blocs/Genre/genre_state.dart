part of 'genre_bloc.dart';

abstract class GenreState extends Equatable {
  const GenreState();

  @override
  List<Object> get props => [];
}

class GenreInitial extends GenreState {}

class GenreMoviesLoading extends GenreState {}

class GenreMoviesLoaded extends GenreState {
  final List<MoviesModel> genreMovies;

  GenreMoviesLoaded({@required this.genreMovies});

  @override
  List get props => [genreMovies];
}

class GenreMoviesError extends GenreState {}
