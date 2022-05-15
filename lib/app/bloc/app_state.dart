part of 'app_bloc.dart';

enum AppStatus {
  loading,
  authenticated,
  unauthenticated,
}

class AppState extends Equatable {
  const AppState._({
    required this.status,
    this.isNewUser = false,
    this.user,
    this.userProfile,
  });

  const AppState.loading(User? user)
      : this._(
          status: AppStatus.loading,
          user: user,
        );

  const AppState.authenticated(UserProfile userProfile, bool isNewUser)
      : this._(
          status: AppStatus.authenticated,
          userProfile: userProfile,
          isNewUser: isNewUser,
        );

  const AppState.unauthenticated() : this._(status: AppStatus.unauthenticated);

  final AppStatus status;
  final User? user;
  final UserProfile? userProfile;
  final bool isNewUser;

  @override
  List<Object?> get props => [status, user];
}
