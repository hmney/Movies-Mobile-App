part of 'search_bloc.dart';

abstract class SearchState extends Equatable {
  const SearchState();

  @override
  List<Object> get props => [];
}

class SearchInitial extends SearchState {}

class SearchLoading extends SearchState {}

class SearchFound extends SearchState {
  final List<MoviesModel> moviesList;

  SearchFound({@required this.moviesList}) : assert(moviesList != null);

  @override
  List get props => [moviesList];
}

class SearchNotFound extends SearchState{}

class SearchError extends SearchState{}
