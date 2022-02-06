import 'package:authentication_client/authentication_client.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:form_validators/form_validators.dart';
import 'package:formz/formz.dart';

part 'sign_up_event.dart';
part 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  SignUpBloc(this._authenticationClient) : super(const SignUpState()) {
    on<SignUpUsernameChanged>(_onUsernameChanged);
    on<SignUpEmailChanged>(_onEmailChanged);
    on<SignUpPasswordChanged>(_onPasswordChanged);
    on<SignUpCredentialsSubmitted>(_onSubmit);
  }

  final AuthenticationClient _authenticationClient;

  void _onUsernameChanged(
      SignUpUsernameChanged event, Emitter<SignUpState> emit) {
    final username = Username.dirty(event.username);
    emit(state.copyWith(
      username: username,
      status: Formz.validate([username, state.email, state.password]),
    ));
  }

  void _onEmailChanged(SignUpEmailChanged event, Emitter<SignUpState> emit) {
    final email = Email.dirty(event.email);
    emit(state.copyWith(
      email: email,
      status: Formz.validate([state.username, email, state.password]),
    ));
  }

  void _onPasswordChanged(
      SignUpPasswordChanged event, Emitter<SignUpState> emit) {
    final password = Password.dirty(event.password);
    emit(state.copyWith(
      password: password,
      status: Formz.validate([state.username, state.email, password]),
    ));
  }

  Future<void> _onSubmit(
    SignUpCredentialsSubmitted event,
    Emitter<SignUpState> emit,
  ) async {
    if (!state.status.isValidated) {
      emit(state.copyWith(
        username: Username.dirty(state.username.value),
        email: Email.dirty(state.email.value),
        password: Password.dirty(state.password.value),
        status: Formz.validate([state.email, state.password]),
      ));
    } else {
      try {
        emit(state.copyWith(status: FormzStatus.submissionInProgress));
        await _authenticationClient.signInWithEmailAndPassword(
          email: state.email.value,
          password: state.password.value,
        );
        emit(state.copyWith(status: FormzStatus.submissionSuccess));
      } catch (_) {
        emit(state.copyWith(status: FormzStatus.submissionFailure));
      }
    }
  }
}
