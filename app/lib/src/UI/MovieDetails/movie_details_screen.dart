import 'package:app/src/blocs/Movie/movie_bloc.dart';
import 'package:app/src/data/models/movies_model.dart';
import 'package:app/src/data/repositories/repositories.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class MovieDetailsScreenProvider extends StatefulWidget {
  final MoviesModel _movieDetails;
  final MoviesRepository _moviesRepository;

  MovieDetailsScreenProvider(
      {Key key, MoviesModel movie, MoviesRepository moviesRepository})
      : assert(movie != null, moviesRepository != null),
        _movieDetails = movie,
        _moviesRepository = moviesRepository,
        super(key: key);

  @override
  _MovieDetailsScreenProviderState createState() =>
      _MovieDetailsScreenProviderState();
}

class _MovieDetailsScreenProviderState
    extends State<MovieDetailsScreenProvider> {
  MoviesRepository get _moviesRepository => widget._moviesRepository;
  MoviesModel get _movieDetails => widget._movieDetails;
  MovieBloc _movieBloc;

  @override
  void initState() {
    super.initState();
    _movieBloc = MovieBloc(moviesRepository: _moviesRepository);
    _movieBloc.add(FetchMovieDetails(moviesDetails: _movieDetails));
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _movieBloc,
      child: MovieDetailsScreen(moviesRepository: _moviesRepository,),
    );
  }

  void dispos() {
    super.dispose();
    _movieBloc.close();
  }
}

class MovieDetailsScreen extends StatefulWidget {
  final MoviesRepository _moviesRepository;

  MovieDetailsScreen({Key key, MoviesRepository moviesRepository})
      : assert(moviesRepository != null),
        _moviesRepository = moviesRepository,
        super(key: key);
  @override
  _MovieDetailsScreenState createState() => _MovieDetailsScreenState();
}

class _MovieDetailsScreenState extends State<MovieDetailsScreen> {
  MoviesRepository get _moviesRepository => widget._moviesRepository;
  VideoPlayerController _vedioController;
  Future<void> _initializeVideoPlayerFuture;

  @override
  void initState() {
    _vedioController = VideoPlayerController.network(
      'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4',
    );
    _initializeVideoPlayerFuture = _vedioController.initialize();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: BlocBuilder<MovieBloc, MovieState>(
          builder: (context, state) {
            if (state is MovieDetailsLoading)
              return Center(
                child: CircularProgressIndicator(
                  backgroundColor: Theme.of(context).primaryColor,
                ),
              );
            if (state is MovieDetailsLoaded)
              return SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Container(
                      child: FutureBuilder(
                        future: _initializeVideoPlayerFuture,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.done) {
                            return Container(
                              child: Stack(
                                children: <Widget>[
                                  AspectRatio(
                                    aspectRatio:
                                        _vedioController.value.aspectRatio,
                                    child: VideoPlayer(_vedioController),
                                  ),
                                  Positioned(
                                    child: AppBar(
                                      backgroundColor: Colors.transparent,
                                      elevation: 0,
                                    ),
                                  ),
                                  Positioned(
                                    left: 140,
                                    top: 70,
                                    child: FloatingActionButton(
                                      backgroundColor: Colors.transparent,
                                      onPressed: () {
                                        setState(() {
                                          _vedioController.value.isPlaying
                                              ? _vedioController.pause()
                                              : _vedioController.play();
                                        });
                                      },
                                      child: Icon(
                                        _vedioController.value.isPlaying
                                            ? Icons.pause_circle_outline
                                            : Icons.play_circle_outline,
                                        size: 70,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          } else {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(20),
                      child: Row(
                        children: <Widget>[
                          Container(
                            width: 220,
                            child: Text(
                              state.movieDetails.name,
                              style: TextStyle(
                                  color: Theme.of(context).accentColor,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Spacer(),
                          Container(
                            child: RatingBarIndicator(
                              itemSize: 20,
                              direction: Axis.horizontal,
                              rating: state.movieDetails.rating / 2,
                              itemBuilder: (context, _) => Icon(
                                Icons.star,
                                color: Theme.of(context).primaryColor,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(20, 0, 20, 20),
                      child: Container(
                        child: Text(
                          state.movieDetails.overview,
                          style:
                              TextStyle(fontSize: 18, color: Colors.grey[600]),
                        ),
                      ),
                    ),
                    Column(
                      children: <Widget>[
                        Container(
                          alignment: Alignment.centerLeft,
                          padding: EdgeInsets.all(20),
                          child: Text('Full Cast & Crew'),
                        ),
                        SizedBox(
                          height: 90,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: state.cast.length,
                            itemBuilder: (context, index) {
                              return Container(
                                margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                                width: 60,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: (state.cast[index].profilePath != null)
                                      ? Image.network(
                                          state.cast[index].profilePath)
                                      : Container(
                                          color: Colors.grey,
                                        ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.all(20),
                      child: Container(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'More Like This',
                          style: TextStyle(
                            color: Theme.of(context).accentColor,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: SizedBox(
                        child: GridView.builder(
                          shrinkWrap: true,
                          physics: ScrollPhysics(),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 0.0,
                                  mainAxisSpacing: 10.0),
                          itemCount: state.recommendation.length,
                          itemBuilder: (context, index) {
                            return Container(
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(builder: (context) {
                                      return MovieDetailsScreenProvider(
                                        movie: state.recommendation[index],
                                        moviesRepository: _moviesRepository,
                                      );
                                    }),
                                  );
                                },
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10.0),
                                  child: (state.recommendation[index]
                                              .posterPath !=
                                          null)
                                      ? Image.network(
                                          'http://image.tmdb.org/t/p/w185' +
                                              state.recommendation[index]
                                                  .posterPath)
                                      : Container(
                                          color: Colors.grey,
                                        ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              );
            if (state is MovieDetailsError)
              return Container(
                child: Text('Error'),
              );
            return Container();
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    _vedioController.dispose();
    super.dispose();
  }
}
