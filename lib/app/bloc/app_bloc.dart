import 'dart:async';

import 'package:api_models/api_models.dart';
import 'package:authentication_client/authentication_client.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rxdart/rxdart.dart';
import 'package:user_profile_repository/user_profile_repository.dart';

part 'app_event.dart';
part 'app_state.dart';

/// {@template app_bloc}
/// Bloc user for managing global application state.
/// This bloc also manages authentication and active user.
/// {@endtemplate}
class AppBloc extends Bloc<AppEvent, AppState> {
  /// {@macro app_bloc}
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
    _userSubscription =
        _authenticationClient.user.listen((user) => add(AppUserChanged(user)));

    _userProfileSubscription = _authenticationClient.user
        .flatMap((user) => _userProfileRepository.userProfile(user.email!))
        .handleError(addError)
        .listen((userProfile) => add(AppUserProfileChanged(userProfile)));
  }

  final AuthenticationClient _authenticationClient;

  final UserProfileRepository _userProfileRepository;

  late StreamSubscription<User> _userSubscription;
  late StreamSubscription<UserProfile> _userProfileSubscription;

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
      return emit(state.copyWith(status: AppStatus.unauthenticated));
    }

    if (event.userProfile == UserProfile.empty.copyWith(email: 'waiting')) {
      return;
    }

    return emit(
      state.copyWith(
        userProfile: event.userProfile,
        status: event.userProfile.profileStatus == ProfileStatus.active
            ? AppStatus.authenticated
            : AppStatus.onboardingRequired,
      ),
    );
  }

  @override
  Future<void> close() {
    _userSubscription.cancel();
    _userProfileSubscription.cancel();
    return super.close();
  }
}
