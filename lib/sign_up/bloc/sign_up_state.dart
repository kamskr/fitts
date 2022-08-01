part of 'sign_up_bloc.dart';

/// {@template sign_up_state}
/// State of the sign up process.
/// {@endtemplate}
class SignUpState extends Equatable {
  /// {@macro sign_up_state}
  const SignUpState({
    this.username = const Username.pure(),
    this.email = const Email.pure(),
    this.password = const Password.pure(),
    this.status = FormzStatus.pure,
    this.errorMessage,
  });

  /// User username.
  final Username username;

  /// User email.
  final Email email;

  /// User password.
  final Password password;

  /// Status of the form.
  final FormzStatus status;

  /// Error message.
  final String? errorMessage;

  @override
  List<Object> get props => [username, email, password, status];

  /// Copy method.
  SignUpState copyWith({
    Username? username,
    Email? email,
    Password? password,
    FormzStatus? status,
    String? errorMessage,
  }) {
    return SignUpState(
      username: username ?? this.username,
      email: email ?? this.email,
      password: password ?? this.password,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
