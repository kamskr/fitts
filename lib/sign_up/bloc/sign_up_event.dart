part of 'sign_up_bloc.dart';

/// {@template sign_up_event}
/// Template for sign up events
/// {@endtemplate}
abstract class SignUpEvent extends Equatable {
  /// {@macro sign_up_event}
  const SignUpEvent();

  @override
  List<Object> get props => [];
}

/// {@template sign_up_event}
/// Event fired when user changes username input value.
/// {@endtemplate}
class SignUpUsernameChanged extends SignUpEvent {
  /// {@macro sign_up_event}
  const SignUpUsernameChanged(this.username);

  /// New username.
  final String username;

  @override
  List<Object> get props => [username];
}

/// {@template sign_up_event}
/// Event fired when user changes email input value.
/// {@endtemplate}
class SignUpEmailChanged extends SignUpEvent {
  /// {@macro sign_up_event}
  const SignUpEmailChanged(this.email);

  /// New email.
  final String email;

  @override
  List<Object> get props => [email];
}

/// {@template sign_up_event}
/// Event fired when user changes password input value.
/// {@endtemplate}
class SignUpPasswordChanged extends SignUpEvent {
  /// {@macro sign_up_event}
  const SignUpPasswordChanged(this.password);

  /// New password.
  final String password;

  @override
  List<Object> get props => [password];
}

/// {@template sign_up_event}
/// Event fired when user submits credentials.
/// {@endtemplate}
class SignUpCredentialsSubmitted extends SignUpEvent {}
