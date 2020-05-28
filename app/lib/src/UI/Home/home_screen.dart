import 'package:app/src/UI/MovieDetails/movie_details_screen.dart';
import 'package:app/src/UI/MoviesGenre/movies_genres.dart';
import 'package:app/src/UI/Search/search_screen.dart';
import 'package:app/src/blocs/Home/home_bloc.dart';
import 'package:app/src/data/repositories/repositories.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  final MoviesRepository _moviesRepository;

  HomeScreen({Key key, @required MoviesRepository moviesRepository})
      : assert(moviesRepository != null),
        _moviesRepository = moviesRepository,
        super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  MoviesRepository get _moviesRepository => widget._moviesRepository;
  HomeBloc _homeBloc;

  @override
  void initState() {
    super.initState();
    _homeBloc = HomeBloc(moviesRepository: _moviesRepository);
    _homeBloc.add(FetchHomeMovies());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _homeBloc,
      child: Scaffold(
        appBar: AppBar(
          leading: Image(
            image: AssetImage('assets/images/HomeLogo.png'),
          ),
          backgroundColor: Theme.of(context).primaryColor,
          actions: [
            Padding(
              padding: EdgeInsets.all(10),
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) {
                        return SearchScreenProvider(
                          moviesRepository: _moviesRepository,
                        );
                      },
                    ),
                  );
                },
                child: Icon(
                  Icons.search,
                  size: 30,
                ),
              ),
            )
          ],
        ),
        drawer: Drawer(
          
        ),
        body: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            if (state is HomeLoaded)
              return Container(
                color: Colors.white,
                child: ListView.separated(
                  padding: EdgeInsets.fromLTRB(5, 10, 0, 10),
                  separatorBuilder: (context, index) {
                    return SizedBox(
                      height: 30,
                    );
                  },
                  itemCount: state.genres.length,
                  itemBuilder: (context, index1) {
                    return Container(
                      child: Column(
                        children: <Widget>[
                          Container(
                            child: Row(
                              children: <Widget>[
                                Container(
                                  padding: EdgeInsets.all(10),
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    state.genres[index1].name,
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: Theme.of(context).accentColor,
                                    ),
                                  ),
                                ),
                                Spacer(),
                                Container(
                                  padding: EdgeInsets.all(15),
                                  alignment: Alignment.centerRight,
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(builder: (context) {
                                        return MoviesGenre(
                                          genre: state.genres[index1],
                                          moviesRepository: _moviesRepository,
                                        );
                                      }));
                                    },
                                    child: Text(
                                      'See all',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Theme.of(context).primaryColor,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 142,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: state.movies[index1].length,
                              itemBuilder: (context, index2) {
                                return Container(
                                  margin: EdgeInsets.fromLTRB(5, 0, 5, 0),
                                  width: 100,
                                  child: Container(
                                    child: GestureDetector(
                                      onTap: () {
                                        Navigator.of(context).push(
                                          MaterialPageRoute(builder: (context) {
                                            return MovieDetailsScreenProvider(
                                              movie: state.movies[index1]
                                                  [index2],
                                              moviesRepository:
                                                  _moviesRepository,
                                            );
                                          }),
                                        );
                                      },
                                      child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        child: (state.movies[index1][index2]
                                                    .posterPath !=
                                                null)
                                            ? Image.network(
                                                'http://image.tmdb.org/t/p/w185' +
                                                    state.movies[index1][index2]
                                                        .posterPath)
                                            : Container(
                                                color: Colors.grey,
                                              ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              );
            if (state is HomeLoading)
              return Container(
                child: Center(
                  child: CircularProgressIndicator(
                    backgroundColor: Theme.of(context).primaryColor,
                  ),
                ),
              );
            return Container(
              width: 0,
              height: 0,
            );
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    _homeBloc.close();
    super.dispose();
  }
}
