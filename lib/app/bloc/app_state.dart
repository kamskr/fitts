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
  });

  const AppState.loading() : this._(status: AppStatus.loading);

  const AppState.authenticated(User user, bool isNewUser)
      : this._(
          status: AppStatus.authenticated,
          user: user,
          isNewUser: isNewUser,
        );

  const AppState.unauthenticated() : this._(status: AppStatus.unauthenticated);

  final AppStatus status;
  final User? user;
  final bool isNewUser;

  @override
  List<Object?> get props => [status, user];
}
