import 'package:app/src/UI/MovieDetails/movie_details_screen.dart';
import 'package:app/src/blocs/Search/search_bloc.dart';
import 'package:app/src/data/repositories/repositories.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class SearchScreenProvider extends StatefulWidget {
  final MoviesRepository _moviesRepository;

  SearchScreenProvider({Key key, MoviesRepository moviesRepository})
      : _moviesRepository = moviesRepository,
        assert(moviesRepository != null),
        super(key: key);
  @override
  _SearchScreenProviderState createState() => _SearchScreenProviderState();
}

class _SearchScreenProviderState extends State<SearchScreenProvider> {
  SearchBloc _searchBloc;
  MoviesRepository get _moviesRepository => widget._moviesRepository;

  @override
  void initState() {
    super.initState();
    _searchBloc = SearchBloc(moviesRepository: _moviesRepository);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _searchBloc,
      child: SearchScreen(moviesRepository: _moviesRepository),
    );
  }

  void dispos() {
    _searchBloc.close();
    super.dispose();
  }
}

class SearchScreen extends StatefulWidget {
  final MoviesRepository _moviesRepository;

  SearchScreen({Key key, MoviesRepository moviesRepository})
      : _moviesRepository = moviesRepository,
        assert(moviesRepository != null),
        super(key: key);
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  MoviesRepository get _moviesRepository => widget._moviesRepository;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0.0,
            iconTheme: IconThemeData(
              color: Theme.of(context).accentColor,
            ),
          ),
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(20),
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      prefixIcon: IconButton(
                        icon: Icon(
                          Icons.search,
                          color: Theme.of(context).accentColor,
                        ),
                        onPressed: () => {
                          if (_searchController.text.isNotEmpty)
                            BlocProvider.of<SearchBloc>(context).add(
                                FindMovie(movieName: _searchController.text))
                        },
                      ),
                      hintText: 'Search',
                      labelStyle:
                          TextStyle(color: Theme.of(context).accentColor),
                      focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Theme.of(context).accentColor),
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                          gapPadding: 0),
                      border: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Theme.of(context).primaryColor),
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                          gapPadding: 0),
                      hintStyle:
                          TextStyle(color: Theme.of(context).accentColor),
                    ),
                  ),
                ),
                BlocBuilder<SearchBloc, SearchState>(
                  builder: (context, state) {
                    if (state is SearchLoading)
                      return Padding(
                        padding: EdgeInsets.all(10),
                        child: Center(
                          child: CircularProgressIndicator(
                            backgroundColor: Theme.of(context).primaryColor,
                          ),
                        ),
                      );
                    if (state is SearchFound)
                      return Padding(
                        padding: EdgeInsets.all(8.0),
                        child: ListView.separated(
                          shrinkWrap: true,
                          physics: ScrollPhysics(),
                          separatorBuilder: (context, index) {
                            return SizedBox(
                              height: 30,
                            );
                          },
                          itemCount: state.moviesList.length,
                          itemBuilder: (context, index) {
                            return Container(
                              padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                              height: 100,
                              child: Row(
                                children: <Widget>[
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(10.0),
                                    child: GestureDetector(
                                      onTap: () {
                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  MovieDetailsScreenProvider(
                                                    movie:
                                                        state.moviesList[index],
                                                    moviesRepository:
                                                        _moviesRepository,
                                                  )),
                                        );
                                      },
                                      child: (state.moviesList[index]
                                                  .posterPath !=
                                              null)
                                          ? Image.network(
                                              'http://image.tmdb.org/t/p/w185' +
                                                  state.moviesList[index]
                                                      .posterPath)
                                          : Container(
                                            width: 65,
                                              color: Colors.grey,
                                            ),
                                    ),
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Container(
                                        width: 220,
                                        padding: EdgeInsets.all(10),
                                        child: GestureDetector(
                                          onTap: () {
                                            Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      MovieDetailsScreenProvider(
                                                        movie: state
                                                            .moviesList[index],
                                                        moviesRepository:
                                                            _moviesRepository,
                                                      )),
                                            );
                                          },
                                          child: Text(
                                            state.moviesList[index].name,
                                            style: TextStyle(
                                              color:
                                                  Theme.of(context).accentColor,
                                              fontSize: 20,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        padding:
                                            EdgeInsets.fromLTRB(10, 0, 0, 0),
                                        child: RatingBarIndicator(
                                          itemSize: 20,
                                          direction: Axis.horizontal,
                                          rating:
                                              state.moviesList[index].rating /
                                                  2,
                                          itemBuilder: (context, _) => Icon(
                                            Icons.star,
                                            color:
                                                Theme.of(context).primaryColor,
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            );
                          },
                        ),
                      );
                    if (state is SearchNotFound)
                      return Text('We cannot find the movie, Try again');
                    if (state is SearchError) return Text('Error');
                    return Container();
                  },
                ),
              ],
            ),
          )),
    );
  }
}
