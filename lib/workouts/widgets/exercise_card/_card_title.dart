part of 'exercise_card.dart';

enum _MenuActions {
  setRestTimer,
  delete,
}

class _CardTitle extends StatelessWidget {
  const _CardTitle({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final exerciseData = context.watch<ExerciseCardData>();
    final theme = Theme.of(context);
    final exerciseId = exerciseData.exercise.exerciseId;
    final exercises = context.read<Map<String, Exercise>>();
    final exerciseName = exercises[exerciseId]?.name;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${exerciseData.exerciseIndex + 1} of '
              '${exerciseData.exerciseCount}',
              style: theme.textTheme.overline,
            ),
            const SizedBox(
              height: AppSpacing.xxxs,
            ),
            Text(
              exerciseName ?? 'exercise not found',
              style: theme.textTheme.headline6,
            ),
          ],
        ),
        if (exerciseData.onExerciseChanged != null)
          ReorderableDragStartListener(
            index: exerciseData.exerciseIndex,
            child: const _MiniMenu(),
          ),
      ],
    );
  }
}

class _MiniMenu extends StatelessWidget {
  const _MiniMenu({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final exerciseData = context.watch<ExerciseCardData>();

    return PopupMenuButton<_MenuActions>(
      child: const Icon(Icons.menu),
      onSelected: (_MenuActions item) {
        switch (item) {
          case _MenuActions.setRestTimer:
            showModalBottomSheet<int>(
              context: context,
              builder: (BuildContext _) {
                return _RestTimePicker(
                  duration: exerciseData.exercise.restTime,
                );
              },
            ).then((duration) {
              if (duration != null) {
                exerciseData.onExerciseChanged?.call(
                  exerciseData.exerciseIndex,
                  exerciseData.exercise.copyWith(restTime: duration),
                );
              }
            });
            break;
          case _MenuActions.delete:
            exerciseData.onExerciseDeleted!(exerciseData.exerciseIndex);
            break;
        }
      },
      itemBuilder: (BuildContext context) => <PopupMenuEntry<_MenuActions>>[
        const PopupMenuItem<_MenuActions>(
          value: _MenuActions.setRestTimer,
          child: Text('Update rest timer'),
        ),
        PopupMenuItem<_MenuActions>(
          value: _MenuActions.delete,
          child: Text(
            'Remove exercise',
            style: TextStyle(color: Theme.of(context).colorScheme.error),
          ),
        ),
      ],
    );
  }
}

class _RestTimePicker extends StatefulWidget {
  const _RestTimePicker({
    Key? key,
    required this.duration,
  }) : super(key: key);

  final int duration;

  @override
  State<_RestTimePicker> createState() => _RestTimePickerState();
}

class _RestTimePickerState extends State<_RestTimePicker> {
  late int duration;

  @override
  void initState() {
    super.initState();
    duration = widget.duration;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: Center(
        child: Column(
          children: [
            AppNumberPicker(
              currentValue: duration,
              minValue: 0,
              maxValue: 600,
              step: 5,
              textMapper: (numberText) => DateTimeFormatters.formatSeconds(
                int.parse(numberText),
                showHours: false,
                showSeconds: true,
              ),
              onChanged: (value) {
                setState(() {
                  duration = value;
                });
              },
            ),
            AppTextButton(
              child: const Text('SAVE'),
              onPressed: () {
                Navigator.of(context).pop(duration);
              },
            )
          ],
        ),
      ),
    );
  }
}
