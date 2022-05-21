part of 'app_bloc.dart';

enum AppStatus {
  loading,
  authenticated,
  unauthenticated,
}

class AppState extends Equatable {
  const AppState.initial({
    this.status = AppStatus.loading,
    this.isNewUser = false,
    this.user,
    this.userProfile,
  });

  final AppStatus status;
  final User? user;
  final UserProfile? userProfile;
  final bool isNewUser;

  AppState copyWith({
    AppStatus? status,
    bool? isNewUser,
    User? user,
    UserProfile? userProfile,
  }) {
    return AppState.initial(
      status: status ?? this.status,
      isNewUser: isNewUser ?? this.isNewUser,
      user: user ?? this.user,
      userProfile: userProfile ?? this.userProfile,
    );
  }

  @override
  List<Object?> get props => [status, user, userProfile, isNewUser];
}
