part of 'app_bloc.dart';

/// {@template app_status }
/// Enum for application status.
/// {@endtemplate}
enum AppStatus {
  /// Initial state of the application and loading state.
  loading,

  /// Application is authenticated.
  authenticated,

  /// Application is unauthenticated.
  unauthenticated,

  /// Logged in user does not have a properly setup profile.
  /// Redirect to onboarding.
  onboardingRequired,
}

/// {@template app_state}
/// Application state object
/// {@endtemplate}
class AppState extends Equatable {
  /// {@macro app_state}
  const AppState.initial({
    required this.userProfile,
    this.status = AppStatus.loading,
    this.user = User.empty,
  });

  /// Current status of the application.
  final AppStatus status;

  /// Current user of the application.
  final User user;

  /// Current user profile of the application.
  final UserProfile userProfile;

  /// Copy method
  AppState copyWith({
    AppStatus? status,
    User? user,
    UserProfile? userProfile,
  }) {
    return AppState.initial(
      user: user ?? this.user,
      status: status ?? this.status,
      userProfile: userProfile ?? this.userProfile,
    );
  }

  @override
  List<Object?> get props => [status, user, userProfile];
}
