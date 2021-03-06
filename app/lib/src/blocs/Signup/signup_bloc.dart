import 'dart:async';
import 'package:app/src/data/repositories/user_repository.dart';
import 'package:app/src/helpers/validators.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
part 'signup_event.dart';
part 'signup_state.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  final UserRepository _userRepository;

  SignupBloc({@required UserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository;

  @override
  SignupState get initialState => SignupState.empty();

  @override
  Stream<SignupState> mapEventToState(
    SignupEvent event,
  ) async* {
    if (event is FullNameChanged) {
      yield* _mapFullNameChangedToState(event.fullName);
    } else if (event is EmailChanged) {
      yield* _mapEmailChangedToState(event.email);
    } else if (event is PasswordChanged) {
      yield* _mapPasswordChangedToState(event.password);
    } else if (event is ConfirmPasswordChanged) {
      yield* _mapConfirmPasswordChangedToState(
          event.confirmPassword, event.password);
    } else if (event is Submitted) {
      yield* _mapFormSubmittedToState(event.fullName, event.email, event.password, event.confirmPassword);
    }
  }

  Stream<SignupState> _mapFullNameChangedToState(String fullName) async* {
    yield state.update(
      isFullNameValid: Validators.isValidFullName(fullName),
    );
  }

  Stream<SignupState> _mapEmailChangedToState(String email) async* {
    yield state.update(
      isEmailValid: Validators.isValidEmail(email),
    );
  }

  Stream<SignupState> _mapPasswordChangedToState(String password) async* {
    yield state.update(
      isPasswordValid: Validators.isValidPassword(password),
    );
  }

  Stream<SignupState> _mapConfirmPasswordChangedToState(
      String confirmPassword, String password) async* {
    yield state.update(
      isConfirmPasswordValid: confirmPassword == password,
    );
  }

  Stream<SignupState> _mapFormSubmittedToState(
    String fullName,
    String email,
    String password,
    String confirmPassword
  ) async* {
    yield SignupState.loading();
    if (fullName != null && email != null && password != null && confirmPassword != null) {
      try {
        await _userRepository.signUpWithCredentials(
          email: email,
          password: password,
        );
        yield SignupState.success();
      } catch (_) {
        yield SignupState.failure();
      }
    } else {
      yield SignupState.failure();
    }
  }
}
