part of 'exercise_card.dart';

class _ExerciseNotes extends StatefulWidget {
  const _ExerciseNotes({Key? key}) : super(key: key);

  @override
  State<_ExerciseNotes> createState() => _ExerciseNotesState();
}

class _ExerciseNotesState extends State<_ExerciseNotes> {
  final _focus = FocusNode();
  late WorkoutExercise exercise;

  @override
  void initState() {
    super.initState();
    exercise = context.read<ExerciseCardData>().exercise;
    _focus.addListener(() {
      if (!_focus.hasFocus) {
        context.read<ExerciseCardData>().onExerciseChanged?.call(
              context.read<ExerciseCardData>().exerciseIndex,
              exercise,
            );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final exerciseCardData = context.watch<ExerciseCardData>();

    if (exerciseCardData.onExerciseChanged == null &&
        exerciseCardData.exercise.notes.isEmpty) {
      return const SizedBox();
    }

    return TextFormField(
      focusNode: _focus,
      maxLines: null,
      keyboardType: TextInputType.multiline,
      enabled: exerciseCardData.onExerciseChanged != null,
      decoration: const InputDecoration(
        border: InputBorder.none,
        hintText: 'Notes',
      ),
      initialValue: exerciseCardData.exercise.notes,
      onChanged: exerciseCardData.onExerciseChanged == null
          ? null
          : (value) {
              setState(() {
                exercise = exercise.copyWith(notes: value);
              });
            },
    );
  }
}
