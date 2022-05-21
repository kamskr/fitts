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
        super(
          AppState.initial(userProfile: UserProfile.empty),
        ) {
    on<AppUserChanged>(_onUserChanged);
    on<AppUserProfileChanged>(_onUserProfileChanged);
    _userSubscription = _authenticationClient.user.listen(_userChanged);

    _userProfileSubscription = _authenticationClient.user
        .flatMap((user) => _userProfileRepository.userProfile(user.email!))
        .handleError(addError)
        .listen(_userProfileChanged);
  }

  final AuthenticationClient _authenticationClient;

  final UserProfileRepository _userProfileRepository;

  late StreamSubscription<User> _userSubscription;
  late StreamSubscription<UserProfile> _userProfileSubscription;

  void _userChanged(User user) => add(AppUserChanged(user));
  void _userProfileChanged(UserProfile userProfile) {
    return add(AppUserProfileChanged(userProfile));
  }

  Future<void> _onUserChanged(
    AppUserChanged event,
    Emitter<AppState> emit,
  ) async {
    emit(state.copyWith(status: AppStatus.loading));
    if (event.user == User.empty) {
      return emit(state.copyWith(status: AppStatus.unauthenticated));
    }
    return emit(state.copyWith(user: event.user));
  }

  void _onUserProfileChanged(
    AppUserProfileChanged event,
    Emitter<AppState> emit,
  ) {
    if (event.userProfile == UserProfile.empty) {
      return;
    }

    return emit(state.copyWith(
      userProfile: event.userProfile,
      status: event.userProfile.profileStatus == ProfileStatus.active
          ? AppStatus.authenticated
          : AppStatus.onboardingRequired,
    ));
  }

  @override
  Future<void> close() {
    _userSubscription.cancel();
    _userProfileSubscription.cancel();
    return super.close();
  }
}
