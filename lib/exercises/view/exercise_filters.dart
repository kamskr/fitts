import 'package:app_models/app_models.dart';
import 'package:app_ui/app_ui.dart';
import 'package:fitts/exercises/exercises.dart';
import 'package:fitts/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// {@template exercise_filters}
///  Page for editing active filters in exercises list.
/// {@endtemplate}
class ExerciseFilters extends StatelessWidget {
  /// {@macro exercise_filters}
  const ExerciseFilters({Key? key}) : super(key: key);

  /// Route helper.
  static Route<void> route() =>
      MaterialPageRoute<void>(builder: (_) => const ExerciseFilters());

  @override
  Widget build(BuildContext context) {
    return const _ExerciseFiltersView();
  }
}

class _ExerciseFiltersView extends StatelessWidget {
  const _ExerciseFiltersView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        iconTheme:
            IconThemeData(color: Theme.of(context).colorScheme.onPrimary),
      ),
      body: DecoratedBox(
        decoration: BoxDecoration(
          gradient:
              Theme.of(context).extension<AppColorScheme>()!.primaryGradient1,
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.md,
            ),
            child: SingleChildScrollView(
              child: SafeArea(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'Filter',
                      style: Theme.of(context).textTheme.headline3!.copyWith(
                            color: Theme.of(context).colorScheme.onPrimary,
                          ),
                    ),
                    const _MuscleFilters(),
                    const _EquipmentFilters(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _MuscleFilters extends StatelessWidget {
  const _MuscleFilters({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const AppGap.lg(),
        Text(
          'MUSCLE GROUP',
          style: Theme.of(context).textTheme.caption!.copyWith(
                color: Theme.of(context).colorScheme.onPrimary.withOpacity(0.7),
              ),
        ),
        const AppGap.md(),
        Wrap(
          children: [
            ...Muscle.values
                .map(
                  (muscle) => BlocBuilder<ExercisesBloc, ExercisesState>(
                    builder: (context, state) {
                      final active = state.muscleFilter.contains(muscle);

                      return Padding(
                        padding: const EdgeInsets.only(
                          right: AppSpacing.xs,
                          bottom: AppSpacing.xs,
                        ),
                        child: _FilterChip(
                          text: TextFormatters.camelToSentence(muscle.name),
                          isSelected: active,
                          onPressed: (selected) {
                            final newMuscleFilter = [...state.muscleFilter];

                            if (selected) {
                              newMuscleFilter.add(muscle);
                            } else {
                              newMuscleFilter.remove(muscle);
                            }

                            context.read<ExercisesBloc>().add(
                                  ExercisesFiltersChanged(
                                    muscleFilter: newMuscleFilter,
                                    equipmentFilter: state.equipmentFilter,
                                  ),
                                );
                          },
                        ),
                      );
                    },
                  ),
                )
                .toList(),
          ],
        ),
      ],
    );
  }
}

class _EquipmentFilters extends StatelessWidget {
  const _EquipmentFilters({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const AppGap.lg(),
        Text(
          'EQUIPMENT TYPE',
          style: Theme.of(context).textTheme.caption!.copyWith(
                color: Theme.of(context).colorScheme.onPrimary.withOpacity(0.7),
              ),
        ),
        const AppGap.md(),
        Wrap(
          children: [
            ...Equipment.values
                .map(
                  (equipment) => BlocBuilder<ExercisesBloc, ExercisesState>(
                    builder: (context, state) {
                      final active = state.equipmentFilter.contains(equipment);

                      return Padding(
                        padding: const EdgeInsets.only(
                          right: AppSpacing.xs,
                          bottom: AppSpacing.xs,
                        ),
                        child: _FilterChip(
                          text: TextFormatters.camelToSentence(equipment.name),
                          isSelected: active,
                          onPressed: (selected) {
                            final newEquipmentFilter = [
                              ...state.equipmentFilter
                            ];

                            if (selected) {
                              newEquipmentFilter.add(equipment);
                            } else {
                              newEquipmentFilter.remove(equipment);
                            }

                            context.read<ExercisesBloc>().add(
                                  ExercisesFiltersChanged(
                                    muscleFilter: state.muscleFilter,
                                    equipmentFilter: newEquipmentFilter,
                                  ),
                                );
                          },
                        ),
                      );
                    },
                  ),
                )
                .toList(),
          ],
        ),
      ],
    );
  }
}

class _FilterChip extends StatelessWidget {
  const _FilterChip({
    Key? key,
    required this.text,
    required this.isSelected,
    required this.onPressed,
  }) : super(key: key);

  final String text;
  final bool isSelected;
  final ValueChanged<bool> onPressed;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(canvasColor: Colors.transparent),
      child: FilterChip(
        padding: const EdgeInsets.symmetric(
          vertical: AppSpacing.sm,
          horizontal: AppSpacing.md,
        ),
        backgroundColor: Theme.of(context)
            .extension<AppColorScheme>()!
            .primary50
            .withOpacity(0.2),
        selectedColor: Theme.of(context).extension<AppColorScheme>()!.primary50,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
        ),
        selected: isSelected,
        label: Text(
          text,
          style: TextStyle(
            color: isSelected
                ? Theme.of(context).colorScheme.onBackground
                : Theme.of(context).colorScheme.onPrimary,
          ),
        ),
        onSelected: onPressed,
      ),
    );
  }
}
