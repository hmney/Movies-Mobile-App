import 'dart:async';

import 'package:app/src/data/repositories/repositories.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final MoviesRepository moviesRepository;
  HomeBloc({@required this.moviesRepository}) : assert(moviesRepository != null);

  @override
  HomeState get initialState => HomeEmpty();

  @override
  Stream<HomeState> mapEventToState(
    HomeEvent event,
  ) async* {
    if (event is FetchHomeMovies) {
      yield HomeLoading();
      try {
        final genres = await moviesRepository.getGenresList();
        final movies = await moviesRepository.getMoviesforHomePage(genres); 
        yield HomeLoaded(movies: movies, genres: genres);
      } catch (e) {
        print(e);
        yield HomeError();
      }
    }
  }
}
