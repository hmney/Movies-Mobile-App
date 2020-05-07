import 'package:app/src/blocs/Auth/auth_bloc.dart';
import 'package:app/src/blocs/simple_bloc_delegate.dart';
import 'package:app/src/repositories/user_repository.dart';
import 'package:app/src/views/Home/home.dart';
import 'package:app/src/views/Login/login_screen.dart';
import 'package:app/src/views/SplashScreen/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  BlocSupervisor.delegate = SimpleBlocDelegate();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final UserRepository _userRepository = UserRepository();
  AuthBloc _authBloc;

  @override
  void initState() {
    super.initState();
    _authBloc = AuthBloc(userRepository: _userRepository);
    _authBloc.add(AppStarted());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _authBloc,
      child: GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
        },
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primaryColor: Color(0xffdd2924),
            accentColor: Color(0xff030303),
          ),
          home: BlocBuilder(
            bloc: _authBloc,
            builder: (BuildContext context, AuthenticationState state) {
              if (state is Uninitialized) {
                return SplashScreen();
              }
              if (state is Unauthenticated) {
                return LoginScreen(userRepository: _userRepository);
              }
              if (state is Authenticated) {
                return Home();
              }
              return SplashScreen();
            },
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _authBloc.close();
    super.dispose();
  }
}
