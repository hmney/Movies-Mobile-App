part of 'login_bloc.dart';

@immutable
abstract class LoginEvent extends Equatable {
  LoginEvent([List props = const []]);
}

class EmailChanged extends LoginEvent {
  final String email;

  EmailChanged({@required this.email}) : super([email]);

  @override
  String toString() => 'EmailChanged { email :$email }';

  @override
  List<Object> get props => [];
}

class PasswordChanged extends LoginEvent {
  final String password;

  PasswordChanged({@required this.password}) : super([password]);

  @override
  String toString() => 'PasswordChanged { password: $password }';

  @override
  List<Object> get props => [];
}

class Submitted extends LoginEvent {
  final String email;
  final String password;

  Submitted({@required this.email, @required this.password});

  @override
  String toString() {
    return 'Submitted { email: $email, password: $password }';
  }

  @override
  List<Object> get props => [email, password];
}

class LoginWithGooglePressed extends LoginEvent {
  @override
  String toString() => 'LoginWithGooglePressed';

  @override
  List<Object> get props => [];
}

class LoginWithCredentialsPressed extends LoginEvent {
  final String email;
  final String password;

  LoginWithCredentialsPressed({@required this.email, @required this.password})
      : super([email, password]);

  @override
  String toString() {
    return 'LoginWithCredentialsPressed { email: $email, password: $password }';
  }

  @override
  List<Object> get props => [];
}