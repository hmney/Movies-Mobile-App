import 'package:app/src/blocs/Auth/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: RaisedButton(
        child: Text('LogOut'),
        onPressed: () {
          BlocProvider.of<AuthBloc>(context).add(LoggedOut());
        },
        
      ),
    );
  }
}