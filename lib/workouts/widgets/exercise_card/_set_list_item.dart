part of 'exercise_card.dart';

class _SetListItem extends StatelessWidget {
  const _SetListItem({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const containerWidth = 80.0;

    final setData = context.watch<ExerciseSetData>();
    final exerciseCardData = context.read<ExerciseCardData>();

    final child = Container(
      padding: const EdgeInsets.symmetric(
        vertical: AppSpacing.sm,
        horizontal: AppSpacing.lg,
      ),
      color: setData.set.isDone == true
          ? Theme.of(context)
              .extension<AppColorScheme>()!
              .black100
              .withOpacity(0.4)
          : Colors.transparent,
      child: const _SetInfo(
        containerWidth: containerWidth,
      ),
    );

    if (exerciseCardData.onExerciseSetDeleted != null) {
      return Dismissible(
        key: ValueKey(setData.set),
        onDismissed: (_) {
          exerciseCardData.onExerciseSetDeleted!(
            exerciseCardData.exerciseIndex,
            context.read<ExerciseSetData>().setIndex,
          );
        },
        direction: DismissDirection.endToStart,
        background: ColoredBox(
          color: Theme.of(context).colorScheme.error,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: const [
              Icon(
                Icons.delete,
                color: Colors.white,
              ),
              AppGap.md(),
            ],
          ),
        ),
        child: child,
      );
    }

    return child;
  }
}

class _SetInfo extends StatefulWidget {
  const _SetInfo({
    Key? key,
    required this.containerWidth,
  }) : super(key: key);

  final double containerWidth;

  @override
  State<_SetInfo> createState() => _SetInfoState();
}

class _SetInfoState extends State<_SetInfo> with TickerProviderStateMixin {
  static const animationDuration = Duration(milliseconds: 200);
  bool _isEditingSet = false;
  late ExerciseSet _set;

  late final AnimationController _controller;

  late final Animation<double> _containerAnimation;
  late final Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();
    _set = context.read<ExerciseSetData>().set;

    _controller = AnimationController(
      vsync: this,
      duration: animationDuration,
    );

    _containerAnimation =
        Tween<double>(begin: 70, end: 200).animate(_controller)
          ..addListener(() {
            setState(() {});
          });
    _opacityAnimation = Tween<double>(begin: 0, end: 1).animate(_controller)
      ..addListener(() {
        setState(() {});
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: context.read<ExerciseCardData>().onExerciseSetChanged == null
          ? () {}
          : () {
              if (!_isEditingSet) {
                _controller.forward();
                setState(() {
                  _isEditingSet = true;
                });
              }
              FocusScope.of(context).unfocus();
            },
      child: Column(
        children: [
          SizedBox(
            height: _containerAnimation.value,
            width: double.infinity,
            child: Stack(
              fit: StackFit.expand,
              children: [
                AnimatedAlign(
                  alignment: !_isEditingSet
                      ? Alignment.centerLeft
                      : Alignment.topCenter,
                  duration: animationDuration,
                  child: _SetIndicator(
                    isEditingSet: _isEditingSet,
                  ),
                ),
                AnimatedAlign(
                  alignment: Alignment.center,
                  duration: animationDuration,
                  child: _RepsCount(
                    set: _set,
                    enabled: _isEditingSet,
                    onSetUpdated: (set) {
                      setState(() {
                        _set = set;
                      });
                    },
                  ),
                ),
                AnimatedAlign(
                  alignment: !_isEditingSet
                      ? Alignment.centerRight
                      : Alignment.bottomCenter,
                  duration: animationDuration,
                  child: _WeightIndicator(
                    set: _set,
                    enabled: _isEditingSet,
                    onSetUpdated: (set) {
                      setState(() {
                        _set = set;
                      });
                    },
                  ),
                ),
                Visibility(
                  visible: _isEditingSet,
                  child: Opacity(
                    opacity: _opacityAnimation.value,
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: _RemoveRepButton(
                        onPressed: () {
                          setState(() {
                            _set = _set.copyWith(
                              repetitions: _set.repetitions - 1,
                            );
                          });
                        },
                      ),
                    ),
                  ),
                ),
                Visibility(
                  visible: _isEditingSet,
                  child: Opacity(
                    opacity: _opacityAnimation.value,
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: _AddRepButton(
                        onPressed: () {
                          setState(() {
                            _set = _set.copyWith(
                              repetitions: _set.repetitions + 1,
                            );
                          });
                        },
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          Visibility(
            visible: _isEditingSet,
            child: const AppGap.md(),
          ),
          Visibility(
            visible: _isEditingSet,
            child: Opacity(
              opacity: _opacityAnimation.value,
              child: AppButton.accentGradient(
                onPressed: () {
                  _controller.reverse();

                  final exerciseCardData = context.read<ExerciseCardData>();
                  final setData = context.read<ExerciseSetData>();
                  final onSetFinished =
                      context.read<ExerciseCardData>().onSetFinished;

                  setState(() {
                    _isEditingSet = !_isEditingSet;
                    if (onSetFinished != null) {
                      _set = _set.copyWith(isDone: true);
                    }
                  });

                  Future.delayed(const Duration(milliseconds: 300), () {
                    exerciseCardData.onExerciseSetChanged?.call(
                      exerciseCardData.exerciseIndex,
                      setData.setIndex,
                      _set,
                    );
                    onSetFinished?.call(
                      exerciseCardData.exerciseIndex,
                      setData.setIndex,
                      _set,
                    );
                  });
                },
                child: context.read<ExerciseCardData>().onSetFinished != null
                    ? const Text('FINISH SET')
                    : const Text('SAVE SET'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _AddRepButton extends StatelessWidget {
  const _AddRepButton({
    Key? key,
    required this.onPressed,
  }) : super(key: key);

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 44,
      width: 44,
      decoration: BoxDecoration(
        border: Border.all(
          color: Theme.of(context).extension<AppColorScheme>()!.black100,
        ),
      ),
      child: AppTextButton(
        onPressed: onPressed,
        child: const Icon(Icons.add),
      ),
    );
  }
}

class _RemoveRepButton extends StatelessWidget {
  const _RemoveRepButton({
    Key? key,
    required this.onPressed,
  }) : super(key: key);

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 44,
      width: 44,
      decoration: BoxDecoration(
        border: Border.all(
          color: Theme.of(context).extension<AppColorScheme>()!.black100,
        ),
      ),
      child: AppTextButton(
        onPressed: onPressed,
        child: const Icon(Icons.remove),
      ),
    );
  }
}
