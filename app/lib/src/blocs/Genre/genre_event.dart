part of 'genre_bloc.dart';

abstract class GenreEvent extends Equatable {
  const GenreEvent();

  @override
  List get props => [];
}

class FetchGenreMovies extends GenreEvent {
  final GenresModel genre;

  FetchGenreMovies({@required this.genre});

  @override
  List get props => [genre];
}
