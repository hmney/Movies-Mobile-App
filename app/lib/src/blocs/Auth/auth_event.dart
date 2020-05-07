part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent extends Equatable {
  AuthEvent([List props = const []]);
}

class AppStarted extends AuthEvent {
   @override
  String toString() => 'AppStarted';

  @override
  List<Object> get props => [];
}

class LoggedIn extends AuthEvent {
  @override
  String toString() => 'LoggedIn';
  
  @override
  List<Object> get props => [];
}

class LoggedOut extends AuthEvent {
  @override
  String toString() => 'LoggedOut';
  @override
  List<Object> get props => [];
}
