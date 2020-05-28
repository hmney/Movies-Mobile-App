import 'dart:async';

import 'package:app/src/data/models/models.dart';
import 'package:app/src/data/repositories/repositories.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

part 'genre_event.dart';
part 'genre_state.dart';

class GenreBloc extends Bloc<GenreEvent, GenreState> {
  final MoviesRepository moviesRepository;

  GenreBloc({@required this.moviesRepository});
  @override
  GenreState get initialState => GenreInitial();

  @override
  Stream<GenreState> mapEventToState(
    GenreEvent event,
  ) async* {
    if (event is FetchGenreMovies) {
      yield GenreMoviesLoading();
      try {
        final _movies =
            await moviesRepository.getMoviesByGenre(event.genre.id.toString());
        yield GenreMoviesLoaded(genreMovies: _movies);
      } catch (e) {
        yield GenreMoviesError();
      }
    }
  }
}
