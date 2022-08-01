part of 'app_bloc.dart';

/// {@template app_event}
///  Boilerplate for events.
/// {@endtemplate}
abstract class AppEvent extends Equatable {
  /// {@macro app_event}
  const AppEvent();
}

/// {@template app_user_changed}
/// Event for when the user changes.
/// User represent authenticated user from authentication_client.
/// {@endtemplate}
class AppUserChanged extends AppEvent {
  /// {@macro app_user_changed}
  const AppUserChanged(this.user);

  /// User from authentication_client.
  final User user;

  @override
  List<Object> get props => [user];
}

/// {@template app_user_profile_changed}
///  Event for when the user profile changes.
/// {@endtemplate}
class AppUserProfileChanged extends AppEvent {
  /// {@macro app_user_profile_changed}
  const AppUserProfileChanged(this.userProfile);

  /// User profile from user_profile_repository.
  final UserProfile userProfile;

  @override
  List<Object> get props => [userProfile];
}
