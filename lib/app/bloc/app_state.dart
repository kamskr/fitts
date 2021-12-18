part of 'app_bloc.dart';

enum AppStatus { authenticated, unauthenticated }

class AppState extends Equatable {
  const AppState._({
    required this.status,
    required this.user,
  });

  const AppState.authenticated(User user)
      : this._(
          status: AppStatus.authenticated,
          user: user,
        );

  const AppState.unauthenticated(User user)
      : this._(
          status: AppStatus.unauthenticated,
          user: user,
        );

  final AppStatus status;
  final User user;

  @override
  List<Object> get props => [status, user];
}
