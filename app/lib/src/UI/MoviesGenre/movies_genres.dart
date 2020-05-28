import 'package:app/src/UI/MovieDetails/movie_details_screen.dart';
import 'package:app/src/blocs/Genre/genre_bloc.dart';
import 'package:app/src/data/models/models.dart';
import 'package:app/src/data/repositories/repositories.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MoviesGenre extends StatefulWidget {
  final GenresModel _genre;
  final MoviesRepository _moviesRepository;

  MoviesGenre(
      {Key key,
      @required GenresModel genre,
      @required MoviesRepository moviesRepository})
      : assert(genre != null && moviesRepository != null),
        _genre = genre,
        _moviesRepository = moviesRepository,
        super(key: key);
  @override
  _MoviesGenreState createState() => _MoviesGenreState();
}

class _MoviesGenreState extends State<MoviesGenre> {
  GenresModel get _genre => widget._genre;
  MoviesRepository get _moviesRepository => widget._moviesRepository;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(_genre.name),
          backgroundColor: Theme.of(context).primaryColor,
          iconTheme: IconThemeData(
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.white,
        body: BlocProvider(
          create: (context) => GenreBloc(moviesRepository: _moviesRepository)
            ..add(FetchGenreMovies(genre: _genre)),
          child: BlocBuilder<GenreBloc, GenreState>(
            builder: (context, state) {
              if (state is GenreMoviesLoading)
                return Center(
                  child: CircularProgressIndicator(
                    backgroundColor: Theme.of(context).accentColor,
                  ),
                );
              if (state is GenreMoviesLoaded)
                return Padding(
                  padding: EdgeInsets.all(10),
                  child: SizedBox(
                    child: GridView.builder(
                      shrinkWrap: true,
                      physics: ScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 0.0,
                          mainAxisSpacing: 10.0),
                      itemCount: state.genreMovies.length,
                      itemBuilder: (context, index) {
                        return Container(
                          child: GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(builder: (context) {
                                  return MovieDetailsScreenProvider(
                                    movie: state.genreMovies[index],
                                    moviesRepository: _moviesRepository,
                                  );
                                }),
                              );
                            },
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10.0),
                              child: (state.genreMovies[index].posterPath !=
                                      null)
                                  ? Image.network(
                                      'http://image.tmdb.org/t/p/w185' +
                                          state.genreMovies[index].posterPath)
                                  : Container(
                                      color: Colors.grey,
                                    ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                );
              if (state is GenreMoviesError)
                return Center(
                  child: Text('No Movies'),
                );
              return Container();
            },
          ),
        ),
      ),
    );
  }
}
