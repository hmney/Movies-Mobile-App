part of 'signup_bloc.dart';

@immutable
abstract class SignupEvent extends Equatable {
  SignupEvent();

  @override
  List<Object> get props => [];
}

class EmailChanged extends SignupEvent {
  final String email;

  EmailChanged({@required this.email});

  @override
  String toString() => 'EmailChanged { email :$email }';

  @override
  List<Object> get props => [email];
}

class PasswordChanged extends SignupEvent {
  final String password;

  PasswordChanged({@required this.password});

  @override
  String toString() => 'PasswordChanged { password: $password }';

  @override
  List<Object> get props => [password];
}

class ConfirmPasswordChanged extends SignupEvent {
  final String confirmPassword;
  final String password;

  ConfirmPasswordChanged({@required this.confirmPassword, @required this.password});

  @override
  String toString() => 'ConfirmPasswordChanged { confirmPassword: $confirmPassword, password: $password }';

  @override
  List<Object> get props => [confirmPassword];
}

class Submitted extends SignupEvent {
  final String email;
  final String password;

  Submitted({@required this.email, @required this.password}): assert(email != null, password != null);

  @override
  String toString() {
    return 'Submitted { email: $email, password: $password }';
  }

  @override
  List<Object> get props => [email, password];
}
