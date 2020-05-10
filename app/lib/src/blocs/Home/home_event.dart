part of 'home_bloc.dart';

@immutable
abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List get props => [];
}

class FetchHomeMovies extends HomeEvent {
  FetchHomeMovies();

  @override
  List get props => [];
}
