import 'dart:async';

import 'package:authentication_client/authentication_client.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:user_profile_repository/user_profile_repository.dart';

part 'app_event.dart';
part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  AppBloc({
    required AuthenticationClient authenticationClient,
    required UserProfileRepository userProfileRepository,
  })  : _authenticationClient = authenticationClient,
        _userProfileRepository = userProfileRepository,
        super(const AppState.loading()) {
    on<AppUserChanged>(_onUserChanged);
    _userSubscription = _authenticationClient.user.listen(_userChanged);
  }

  final AuthenticationClient _authenticationClient;

  final UserProfileRepository _userProfileRepository;

  late StreamSubscription<User> _userSubscription;

  void _userChanged(User user) => add(AppUserChanged(user));

  Future<void> _onUserChanged(
    AppUserChanged event,
    Emitter<AppState> emit,
  ) async {
    emit(const AppState.loading());
    if (event.user == User.empty) {
      return emit(const AppState.unauthenticated());
    }

    /// There should not be a situation where user's email is null.
    /// If it is the case, it means that the user model from firebase
    /// may be broken.
    if (event.user.email == null) {
      return emit(AppState.authenticated(event.user, true));
    }

    final userProfile =
        await _userProfileRepository.userProfile(event.user.email!).first;

    return emit(AppState.authenticated(event.user, userProfile.isNewUser));
  }

  @override
  Future<void> close() {
    _userSubscription.cancel();
    return super.close();
  }
}
