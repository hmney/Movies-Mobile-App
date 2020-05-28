part of 'search_bloc.dart';

abstract class SearchEvent extends Equatable {
  const SearchEvent();

  @override
  List get props => [];
}

class FindMovie extends SearchEvent {
  final String movieName;

  const FindMovie({@required this.movieName});

  @override
  List get props => [movieName];
}
