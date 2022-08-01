part of 'welcome_cubit.dart';

/// {@template welcome_state}
/// State of the welcome page.
/// {@endtemplate}
class WelcomeState extends Equatable {
  /// {@macro welcome_state}
  const WelcomeState({
    this.status = FormzStatus.pure,
    this.errorMessage,
  });

  /// Status of the welcome page.
  final FormzStatus status;

  /// Error message.
  final String? errorMessage;

  @override
  List<Object> get props => [status];

  /// Copy method.
  WelcomeState copyWith({
    FormzStatus? status,
    String? errorMessage,
  }) {
    return WelcomeState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}

/// {@template welcome_state}
/// Initial state of the welcome page.
/// {@endtemplate}
class WelcomeInitial extends WelcomeState {}
