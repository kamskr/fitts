import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'workout_training_event.dart';
part 'workout_training_state.dart';

class WorkoutTrainingBloc extends Bloc<WorkoutTrainingEvent, WorkoutTrainingState> {
  WorkoutTrainingBloc() : super(WorkoutTrainingInitial()) {
    on<WorkoutTrainingEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
