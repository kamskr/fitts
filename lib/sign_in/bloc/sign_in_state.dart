part of 'sign_in_bloc.dart';

/// {@template sign_in_state}
/// State of the sign in process.
/// {@endtemplate}
class SignInState extends Equatable {
  /// {@macro sign_in_state}
  const SignInState({
    this.email = const Email.pure(),
    this.password = const Password.pure(),
    this.status = FormzStatus.pure,
    this.errorMessage,
  });

  /// User email.
  final Email email;

  /// User password.
  final Password password;

  /// Status of the form.
  final FormzStatus status;

  /// Error message.
  final String? errorMessage;

  @override
  List<Object> get props => [email, password, status];

  /// Copy method.
  SignInState copyWith({
    Email? email,
    Password? password,
    FormzStatus? status,
    String? errorMessage,
  }) {
    return SignInState(
      email: email ?? this.email,
      password: password ?? this.password,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
