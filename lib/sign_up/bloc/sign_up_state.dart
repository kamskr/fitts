part of 'sign_up_bloc.dart';

class SignUpState extends Equatable {
  const SignUpState({
    this.username = const Username.pure(),
    this.email = const Email.pure(),
    this.password = const Password.pure(),
    this.status = FormzStatus.pure,
    this.errorMessage,
  });

  final Username username;
  final Email email;
  final Password password;
  final FormzStatus status;
  final String? errorMessage;

  @override
  List<Object> get props => [username, email, password, status];

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
