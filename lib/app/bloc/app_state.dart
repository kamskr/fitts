part of 'app_bloc.dart';

enum AppStatus {
  loading,
  authenticated,
  unauthenticated,
  onboardingRequired,
}

class AppState extends Equatable {
  const AppState.initial({
    required this.userProfile,
    this.status = AppStatus.loading,
    this.user = User.empty,
  });

  final AppStatus status;
  final User user;
  final UserProfile userProfile;

  AppState copyWith({
    AppStatus? status,
    bool? isNewUser,
    User? user,
    UserProfile? userProfile,
  }) {
    return AppState.initial(
      status: status ?? this.status,
      user: user ?? this.user,
      userProfile: userProfile ?? this.userProfile,
    );
  }

  @override
  List<Object?> get props => [status, user, userProfile];
}
