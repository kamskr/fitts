part of 'welcome_cubit.dart';

class WelcomeState extends Equatable {
  const WelcomeState({
    this.status = FormzStatus.pure,
    this.errorMessage,
  });

  final FormzStatus status;
  final String? errorMessage;

  @override
  List<Object> get props => [status];

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

class WelcomeInitial extends WelcomeState {}
