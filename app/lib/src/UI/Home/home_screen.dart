import 'package:app/src/blocs/Home/home_bloc.dart';
import 'package:app/src/data/models/models.dart';
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
                onTap: () {},
                child: Icon(
                  Icons.search,
                  size: 30,
                ),
              ),
            )
          ],
        ),
        body: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            if (state is HomeLoaded)
              return Container(
                color: Colors.white,
                child: ListView.builder(
                  itemCount: state.movies.length,
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
                                    'Test',
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
                                  child: Text(
                                    'See all',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Theme.of(context).primaryColor,
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
                              itemBuilder: (context, index2) {
                                MoviesModel results =
                                    state.movies[index1][index2];
                                return Container(
                                  margin: EdgeInsets.fromLTRB(5, 0, 5, 0),
                                  width: 100,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Text(results.name),
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
                child: CircularProgressIndicator(),
              );
            return Container(
              child: CircularProgressIndicator(),
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


class GenreMoviesList extends StatefulWidget {
  @override
  _GenreMoviesListState createState() => _GenreMoviesListState();
}

class _GenreMoviesListState extends State<GenreMoviesList> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
// class HomeScreen extends StatefulWidget {
//   final UserRepository _userRepository;

//   HomeScreen({Key key, @required UserRepository userRepository})
//       : assert(userRepository != null),
//         _userRepository = userRepository,
//         super(key: key);
//   @override
//   _HomeScreenState createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         leading: Image(
//           image: AssetImage('assets/images/HomeLogo.png'),
//         ),
//         backgroundColor: Theme.of(context).primaryColor,
//         actions: [
//           Padding(
//             padding: EdgeInsets.all(10),
//                       child: GestureDetector(
//               onTap: () {},
//               child: Icon(
//                 Icons.search,
//                 size: 30,
//               ),
//             ),
//           )
//         ],
//       ),
//       body: Container(
//         color: Colors.white,
//         child: ListView(
//           scrollDirection: Axis.vertical,
//           children: <Widget>[
//             _horzientalWidget(context),
//             SizedBox(
//               width: 10,
//             ),
//             _horzientalWidget(context),
//             SizedBox(
//               width: 10,
//             ),
//             _horzientalWidget(context),
//             SizedBox(
//               width: 10,
//             ),
//             _horzientalWidget(context),
//             SizedBox(
//               width: 10,
//             ),
//             _horzientalWidget(context),
//             SizedBox(
//               width: 10,
//             ),
//             _horzientalWidget(context),
//             SizedBox(
//               width: 10,
//             ),
//             _horzientalWidget(context),
//             SizedBox(
//               width: 10,
//             ),
//             _horzientalWidget(context),
//             SizedBox(
//               width: 10,
//             ),
//             _horzientalWidget(context),
//             SizedBox(
//               width: 10,
//             ),
//             _horzientalWidget(context),
//             SizedBox(
//               width: 10,
//             ),
//             _horzientalWidget(context),
//             Padding(padding: EdgeInsets.all(10)),
//           ],
//         ),
//       ),
//       bottomNavigationBar: _bottomNavigationBar(context),
//     );
//   }

//   Widget _bottomNavigationBar(BuildContext context) {
//     return BottomNavigationBar(
//       backgroundColor: Colors.white,
//       onTap: (int) {},
//       currentIndex1: 0,
//       items: [
//         BottomNavigationBarItem(
//           icon: Icon(Icons.home),
//           title: Text('MOVIES'),
//         ),
//         BottomNavigationBarItem(
//           icon: Icon(Icons.mail),
//           title: Text('TV'),
//         ),
//         BottomNavigationBarItem(
//           icon: Icon(Icons.person),
//           title: Text('PROFILE'),
//         ),
//       ],
//     );
//   }

//   Widget _horzientalWidget(BuildContext context) {
//     return Container(
//       child: Column(
//         children: <Widget>[
//           Container(
//             child: Row(
//               children: <Widget>[
//                 Container(
//                   padding: EdgeInsets.all(10),
//                   alignment: Alignment.centerLeft,
//                   child: Text(
//                     'Drama',
//                     style: TextStyle(
//                       fontSize: 20,
//                       color: Theme.of(context).accentColor,
//                     ),
//                   ),
//                 ),
//                 Spacer(),
//                 Container(
//                   padding: EdgeInsets.all(15),
//                   alignment: Alignment.centerRight,
//                   child: Text(
//                     'See all',
//                     style: TextStyle(
//                       fontSize: 14,
//                       color: Theme.of(context).primaryColor,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           SizedBox(
//             height: 142,
//             child: ListView(
//               scrollDirection: Axis.horizontal,
//               children: <Widget>[
//                 SizedBox(width: 5),
//                 Container(
//                   width: 100,
//                   decoration: BoxDecoration(
//                     color: Colors.blue,
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                 ),
//                 SizedBox(width: 5),
//                 Container(
//                   width: 100,
//                   decoration: BoxDecoration(
//                     color: Colors.blue,
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                 ),
//                 SizedBox(width: 5),
//                 Container(
//                   width: 100,
//                   decoration: BoxDecoration(
//                     color: Colors.blue,
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                 ),
//                 SizedBox(width: 5),
//                 Container(
//                   width: 100,
//                   decoration: BoxDecoration(
//                     color: Colors.blue,
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                 ),
//                 SizedBox(width: 5),
//                 Container(
//                   width: 100,
//                   decoration: BoxDecoration(
//                     color: Colors.blue,
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                 ),
//                 SizedBox(width: 5),
//                 Container(
//                   width: 100,
//                   decoration: BoxDecoration(
//                     color: Colors.blue,
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                 ),
//                 SizedBox(width: 5),
//                 Container(
//                   width: 100,
//                   decoration: BoxDecoration(
//                     color: Colors.blue,
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                 ),
//                 SizedBox(width: 5),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
