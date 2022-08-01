import 'package:authentication_client/authentication_client.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';

part 'welcome_state.dart';

/// {@template welcome_cubit}
/// Cubit used for managing welcome page state.
///
/// It's only responsible for firing signInWithGoogle method.
/// {@endtemplate}
class WelcomeCubit extends Cubit<WelcomeState> {
  /// {@macro welcome_cubit}
  WelcomeCubit(this._authenticationClient) : super(const WelcomeState());

  final AuthenticationClient _authenticationClient;

  /// Sign in with Google.
  Future<void> signInWithGoogle() async {
    emit(state.copyWith(status: FormzStatus.submissionInProgress));
    try {
      await _authenticationClient.signInWithGoogle();
    } on LogInWithGoogleFailure catch (e) {
      emit(
        state.copyWith(
          errorMessage: e.message,
          status: FormzStatus.submissionFailure,
        ),
      );
    } catch (_) {
      emit(state.copyWith(status: FormzStatus.submissionFailure));
    }
  }
}
