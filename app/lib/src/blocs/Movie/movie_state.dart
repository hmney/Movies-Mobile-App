part of 'movie_bloc.dart';

@immutable
abstract class MovieState extends Equatable {
  MovieState();

  @override
  List get props => [];
}

class MovieDetailsInitial extends MovieState {}

class MovieDetailsLoading extends MovieState {}

class MovieDetailsLoaded extends MovieState {
  final MoviesModel movieDetails;
  final List<TrailersModel> trailer;
  final List<CastsModel> cast;
  final List<MoviesModel> recommendation;

  MovieDetailsLoaded(
      {@required this.movieDetails,
      @required this.trailer,
      @required this.cast,
      @required this.recommendation})
      : assert(movieDetails != null &&
            trailer != null &&
            cast != null &&
            recommendation != null);

  @override
  List get props => [movieDetails, trailer, cast, recommendation];
}

class MovieDetailsError extends MovieState {}
