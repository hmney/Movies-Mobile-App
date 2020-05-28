import 'dart:async';

import 'package:app/src/data/models/models.dart';
import 'package:app/src/data/repositories/repositories.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  MoviesRepository moviesRepository;
  
  SearchBloc({@required this.moviesRepository})
      : assert(moviesRepository != null);

  @override
  SearchState get initialState => SearchInitial();

  @override
  Stream<SearchState> mapEventToState(
    SearchEvent event,
  ) async* {
    if (event is FindMovie) {
      yield SearchLoading();
      try {
        final result = await moviesRepository.getMoviebyName(event.movieName);
        print(result.length);
        if (result?.length != 0)
          yield SearchFound(moviesList: result);
        else
          yield SearchNotFound();
      } catch (e) {
        yield SearchError();
      }
    }
  }
}
