part of 'sign_in_bloc.dart';

/// {@template sign_in_event}
/// Template for sign in events
/// {@endtemplate}
abstract class SignInEvent extends Equatable {
  /// {@macro sign_in_event}
  const SignInEvent();

  @override
  List<Object> get props => [];
}

/// {@template sign_in_event}
/// Event fired when user changes email input value.
/// {@endtemplate}
class SignInEmailChanged extends SignInEvent {
  /// {@macro sign_in_event}
  const SignInEmailChanged(this.email);

  /// New email.
  final String email;

  @override
  List<Object> get props => [email];
}

/// {@template sign_in_event}
/// Event fired when user changes password input value.
/// {@endtemplate}
class SignInPasswordChanged extends SignInEvent {
  /// {@macro sign_in_event}
  const SignInPasswordChanged(this.password);

  /// New password.
  final String password;

  @override
  List<Object> get props => [password];
}

/// {@template sign_in_event}
/// Event fired when user submits credentials.
/// {@endtemplate}
class SignInCredentialsSubmitted extends SignInEvent {}
