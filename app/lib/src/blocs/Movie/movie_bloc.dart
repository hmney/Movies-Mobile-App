import 'dart:async';

import 'package:app/src/UI/Search/search_screen.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'movie_event.dart';
part 'movie_state.dart';

class MovieBloc extends Bloc<MovieEvent, MovieState> {
  @override
  MovieState get initialState => MovieInitial();

  @override
  Stream<MovieState> mapEventToState(
    MovieEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
