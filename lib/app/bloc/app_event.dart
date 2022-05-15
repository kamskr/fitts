part of 'app_bloc.dart';

abstract class AppEvent extends Equatable {
  const AppEvent();
}

class AppUserChanged extends AppEvent {
  @visibleForTesting
  const AppUserChanged(this.user);

  final User user;

  @override
  List<Object> get props => [user];
}

class AppUserProfileChanged extends AppEvent {
  const AppUserProfileChanged(this.userProfile);

  final UserProfile userProfile;

  @override
  List<Object> get props => [userProfile];
}
