import 'dart:async';

import 'package:authentication_client/authentication_client.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'app_event.dart';
part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  AppBloc({
    required AuthenticationClient authenticationClient,
  })  : _authenticationClient = authenticationClient,
        super(const AppState.loading()) {
    on<AppUserChanged>(_onUserChanged);
    _userSubscription = _authenticationClient.user.listen(_userChanged);
  }

  final AuthenticationClient _authenticationClient;
  late StreamSubscription<User> _userSubscription;

  void _userChanged(User user) => add(AppUserChanged(user));

  void _onUserChanged(AppUserChanged event, Emitter<AppState> emit) {
    if (event.user == User.empty) {
      return emit(const AppState.unauthenticated());
    }

    return emit(AppState.authenticated(event.user));
  }

  @override
  Future<void> close() {
    _userSubscription.cancel();
    return super.close();
  }
}
