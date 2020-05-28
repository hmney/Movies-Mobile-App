part of 'home_bloc.dart';

@immutable
abstract class HomeState extends Equatable{
  const HomeState();

  @override
  List get props => [];
}

class HomeEmpty extends HomeState {}

class HomeLoading extends HomeState {}

class HomeLoaded extends HomeState {
  final List<dynamic> movies;
  final List<dynamic> genres;

  const HomeLoaded({@required this.movies, @required this.genres}) : assert(movies != null, genres != null);

  @override
  List get props => [movies, genres];
}

class HomeError extends HomeState {}
