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

  const HomeLoaded({@required this.movies}) : assert(movies != null);

  @override
  List get props => [movies];
}

class HomeError extends HomeState {}
