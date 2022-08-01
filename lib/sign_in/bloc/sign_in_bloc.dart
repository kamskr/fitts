import 'package:authentication_client/authentication_client.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:form_validators/form_validators.dart';
import 'package:formz/formz.dart';

part 'sign_in_event.dart';
part 'sign_in_state.dart';

/// {@template sign_in_bloc}
/// Bloc used for managing sign in flow.
/// {@endtemplate}
class SignInBloc extends Bloc<SignInEvent, SignInState> {
  /// {@macro sign_in_bloc}
  SignInBloc(this._authenticationClient) : super(const SignInState()) {
    on<SignInEmailChanged>(_onEmailChanged);
    on<SignInPasswordChanged>(_onPasswordChanged);
    on<SignInCredentialsSubmitted>(_onSubmit);
  }

  final AuthenticationClient _authenticationClient;

  void _onEmailChanged(SignInEmailChanged event, Emitter<SignInState> emit) {
    final email = Email.dirty(event.email);
    emit(
      state.copyWith(
        email: email,
        status: Formz.validate([email, state.password]),
      ),
    );
  }

  void _onPasswordChanged(
    SignInPasswordChanged event,
    Emitter<SignInState> emit,
  ) {
    final password = Password.dirty(event.password);
    emit(
      state.copyWith(
        password: password,
        status: Formz.validate([state.email, password]),
      ),
    );
  }

  Future<void> _onSubmit(
    SignInCredentialsSubmitted event,
    Emitter<SignInState> emit,
  ) async {
    if (!state.status.isValidated) {
      emit(
        state.copyWith(
          email: Email.dirty(state.email.value),
          password: Password.dirty(state.password.value),
          status: Formz.validate([state.email, state.password]),
        ),
      );
    } else {
      try {
        emit(state.copyWith(status: FormzStatus.submissionInProgress));
        await _authenticationClient.signInWithEmailAndPassword(
          email: state.email.value,
          password: state.password.value,
        );
        emit(state.copyWith(status: FormzStatus.submissionSuccess));
      } on LogInWithEmailAndPasswordFailure catch (e) {
        emit(
          state.copyWith(
            errorMessage: e.message,
            status: FormzStatus.submissionFailure,
          ),
        );
      } catch (e, st) {
        emit(
          state.copyWith(
            status: FormzStatus.submissionFailure,
          ),
        );
        addError(e, st);
      }
    }
  }
}
