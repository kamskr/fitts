part of 'home_bloc.dart';

/// {@template home_state}
/// Template for the [HomeBloc] state.
/// {@endtemplate}
abstract class HomeState extends Equatable {
  /// {@macro home_state}
  const HomeState();

  @override
  List<Object> get props => [];
}

/// {@template home_initial_state}
/// The initial state of the [HomeBloc].
/// {@endtemplate}
class HomeInitialState extends HomeState {}

/// {@template home_error_state}
/// The error state of the [HomeBloc].
/// {@endtemplate}
class HomeErrorState extends HomeState {}

/// {@template home_success_state}
///  The state of the [HomeBloc] when loaded.
/// {@endtemplate}
class HomeSuccessState extends HomeState {
  /// {@macro home_success_state}
  const HomeSuccessState(this.userStats);

  /// The [UserStats] of current user.
  final UserStats userStats;

  @override
  List<Object> get props => [userStats];
}
