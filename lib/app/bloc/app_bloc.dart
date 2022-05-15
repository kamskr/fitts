import 'dart:async';

import 'package:api_models/api_models.dart';
import 'package:authentication_client/authentication_client.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';
import 'package:user_profile_repository/user_profile_repository.dart';

part 'app_event.dart';
part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  AppBloc({
    required AuthenticationClient authenticationClient,
    required UserProfileRepository userProfileRepository,
  })  : _authenticationClient = authenticationClient,
        _userProfileRepository = userProfileRepository,
        super(const AppState.loading(null)) {
    on<AppUserChanged>(_onUserChanged);
    on<AppUserProfileChanged>(_onUserProfileUpdated);
    _userSubscription = _authenticationClient.user.listen(_userChanged);

    _userProfileSubscription = _authenticationClient.user
        .flatMap((user) => _userProfileRepository.userProfile(user.email!))
        .handleError(addError)
        .listen(_userProfileUpdated);
  }

  final AuthenticationClient _authenticationClient;

  final UserProfileRepository _userProfileRepository;

  late StreamSubscription<User> _userSubscription;
  late StreamSubscription<UserProfile> _userProfileSubscription;

  void _userChanged(User user) => add(AppUserChanged(user));
  void _userProfileUpdated(UserProfile userProfile) {
    add(AppUserProfileChanged(userProfile));
  }

  Future<void> _onUserChanged(
    AppUserChanged event,
    Emitter<AppState> emit,
  ) async {
    emit(const AppState.loading(null));
    if (event.user == User.empty) {
      return emit(const AppState.unauthenticated());
    }
    return emit(AppState.loading(event.user));
  }

  void _onUserProfileUpdated(
    AppUserProfileChanged event,
    Emitter<AppState> emit,
  ) {
    if (event.userProfile == UserProfile.empty) {
      return;
    }
    return emit(AppState.authenticated(
      event.userProfile,
      // event.userProfile.isNewUser,
      true,
    ));
  }

  @override
  Future<void> close() {
    _userSubscription.cancel();
    _userProfileSubscription.cancel();
    return super.close();
  }
}
