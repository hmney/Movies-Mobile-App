part of 'signup_bloc.dart';

@immutable
class SignupState {
  final bool isFullNameValid;
  final bool isEmailValid;
  final bool isPasswordValid;
  final bool isConfirmPasswordValid;
  final bool isSubmitting;
  final bool isSuccess;
  final bool isFailure;

  bool get isFormValid => isEmailValid && isPasswordValid && isConfirmPasswordValid && isFullNameValid;

  SignupState({
    @required this.isFullNameValid,
    @required this.isEmailValid,
    @required this.isPasswordValid,
    @required this.isConfirmPasswordValid,
    @required this.isSubmitting,
    @required this.isSuccess,
    @required this.isFailure,
  });

  factory SignupState.empty() {
    return SignupState(
      isFullNameValid: true,
      isEmailValid: true,
      isPasswordValid: true,
      isConfirmPasswordValid: true,
      isSubmitting: false,
      isSuccess: false,
      isFailure: false,
    );
  }

  factory SignupState.loading() {
    return SignupState(
      isFullNameValid: true,
      isEmailValid: true,
      isPasswordValid: true,
      isConfirmPasswordValid: true,
      isSubmitting: true,
      isSuccess: false,
      isFailure: false,
    );
  }

  factory SignupState.failure() {
    return SignupState(
      isFullNameValid: true,
      isEmailValid: true,
      isPasswordValid: true,
      isConfirmPasswordValid: true,
      isSubmitting: false,
      isSuccess: false,
      isFailure: true,
    );
  }

  factory SignupState.success() {
    return SignupState(
      isFullNameValid: true,
      isEmailValid: true,
      isPasswordValid: true,
      isConfirmPasswordValid: true,
      isSubmitting: false,
      isSuccess: true,
      isFailure: false,
    );
  }

  SignupState update({
    bool isFullNameValid,
    bool isEmailValid,
    bool isPasswordValid,
    bool isConfirmPasswordValid,
  }) {
    return copyWith(
      isFullNameValid: isFullNameValid,
      isEmailValid: isEmailValid,
      isPasswordValid: isPasswordValid,
      isConfirmPasswordValid: isConfirmPasswordValid,
      isSubmitting: false,
      isSuccess: false,
      isFailure: false,
    );
  }

  SignupState copyWith({
    bool isFullNameValid,
    bool isEmailValid,
    bool isPasswordValid,
    bool isConfirmPasswordValid,
    bool isSubmitEnabled,
    bool isSubmitting,
    bool isSuccess,
    bool isFailure, 
  }) {
    return SignupState(
      isFullNameValid: isFullNameValid ?? this.isFullNameValid,
      isEmailValid: isEmailValid ?? this.isEmailValid,
      isPasswordValid: isPasswordValid ?? this.isPasswordValid,
      isConfirmPasswordValid: isConfirmPasswordValid ?? this.isConfirmPasswordValid,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      isSuccess: isSuccess ?? this.isSuccess,
      isFailure: isFailure ?? this.isFailure,
    );
  }

  @override
  String toString() {
    return '''SignupState {
      isFullNameValid: $isFullNameValid,
      isEmailValid: $isEmailValid,
      isPasswordValid: $isPasswordValid,
      isConfirmPassword: $isConfirmPasswordValid,
      isSubmitting: $isSubmitting,
      isSuccess: $isSuccess,
      isFailure: $isFailure,
    }''';
  }
}
