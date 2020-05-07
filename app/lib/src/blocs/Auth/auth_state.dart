part of 'auth_bloc.dart';

@immutable
abstract class AuthenticationState extends Equatable {
  AuthenticationState();
  @override
  List<Object> get props => [];
}

class Uninitialized extends AuthenticationState {
  @override
  String toString() => 'Uninitialized';
  @override
  List<Object> get props => [];
}

class Authenticated extends AuthenticationState {
  final String username;

  Authenticated(this.username);

  @override
  String toString() => 'Authenticated { displayName: $username }';
  @override
  List<Object> get props => [username];
}

class Unauthenticated extends AuthenticationState {
  @override
  String toString() => 'Unauthenticated';
  
  @override
  List<Object> get props => [];
}