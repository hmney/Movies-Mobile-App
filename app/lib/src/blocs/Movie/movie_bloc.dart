import 'dart:async';

import 'package:app/src/data/models/models.dart';
import 'package:app/src/data/repositories/repositories.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'movie_event.dart';
part 'movie_state.dart';

class MovieBloc extends Bloc<MovieEvent, MovieState> {
  MoviesRepository moviesRepository;
  
  MovieBloc({@required this.moviesRepository})
      : assert(moviesRepository != null);

  @override
  MovieState get initialState => MovieDetailsInitial();

  @override
  Stream<MovieState> mapEventToState(
    MovieEvent event,
  ) async* {
    if (event is FetchMovieDetails) {
      yield MovieDetailsLoading();
      try {
        final cast =
            await moviesRepository.getMovieCredits(event.moviesDetails.id);
        final recommendation = await moviesRepository
            .gethMovieRecommendations(event.moviesDetails.id);
        final trailer =
            await moviesRepository.getMovieTraliers(event.moviesDetails.id);
        yield MovieDetailsLoaded(
            movieDetails: event.moviesDetails,
            trailer: trailer,
            cast: cast,
            recommendation: recommendation);
      } catch (e) {
        yield MovieDetailsError();
      }
    }
  }
}
