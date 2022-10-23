part of 'exercise_card.dart';

class _WeightIndicator extends StatefulWidget {
  const _WeightIndicator({
    Key? key,
    required this.set,
    required this.enabled,
    required this.onSetUpdated,
  }) : super(key: key);

  final ExerciseSet set;
  final bool enabled;
  final ValueChanged<ExerciseSet> onSetUpdated;

  @override
  State<_WeightIndicator> createState() => _WeightIndicatorState();
}

class _WeightIndicatorState extends State<_WeightIndicator> {
  final FocusNode _focus = FocusNode();
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.set.weight.toString());
  }

  @override
  void didUpdateWidget(covariant _WeightIndicator oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.set != widget.set && !_focus.hasFocus) {
      _controller.text = widget.set.weight.toString();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _SetTextInput(
          decimal: true,
          enabled: widget.enabled,
          focus: _focus,
          controller: _controller,
          onChanged: (value) {
            final text = value.replaceFirst(',', '.').replaceAll(',', '');

            widget.onSetUpdated(
              widget.set.copyWith(
                weight: double.tryParse(text) ?? 0,
              ),
            );
          },
        ),
        const AppGap.xxs(),
        Text(
          'kg',
          style: Theme.of(context).textTheme.bodyText2,
        ),
        const AppGap.xs(),
      ],
    );
  }
}

class _RepsCount extends StatefulWidget {
  const _RepsCount({
    Key? key,
    required this.set,
    required this.enabled,
    required this.onSetUpdated,
  }) : super(key: key);

  final ExerciseSet set;
  final bool enabled;
  final ValueChanged<ExerciseSet> onSetUpdated;

  @override
  State<_RepsCount> createState() => _RepsCountState();
}

class _RepsCountState extends State<_RepsCount> {
  final FocusNode _focus = FocusNode();
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller =
        TextEditingController(text: widget.set.repetitions.toString());
  }

  @override
  void didUpdateWidget(covariant _RepsCount oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.set != widget.set && !_focus.hasFocus) {
      _controller.text = widget.set.repetitions.toString();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _SetTextInput(
          enabled: widget.enabled,
          focus: _focus,
          controller: _controller,
          onChanged: (value) {
            widget.onSetUpdated(
              widget.set.copyWith(
                repetitions: int.tryParse(value) ?? 0,
              ),
            );
          },
        ),
        const AppGap.xxs(),
        Text(
          'reps',
          style: Theme.of(context).textTheme.bodyText2,
        ),
        const AppGap.xs(),
      ],
    );
  }
}

class _SetTextInput extends StatelessWidget {
  const _SetTextInput({
    Key? key,
    required this.enabled,
    required this.focus,
    required this.controller,
    required this.onChanged,
    this.decimal = false,
  }) : super(key: key);

  final bool enabled;
  final FocusNode focus;
  final TextEditingController controller;
  final ValueChanged<String> onChanged;
  final bool? decimal;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 37,
      width: 100,
      child: TextFormField(
        enabled: enabled,
        focusNode: focus,
        decoration: const InputDecoration(
          hintText: '0',
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          contentPadding: EdgeInsets.zero,
          border: InputBorder.none,
        ),
        enableSuggestions: false,
        autocorrect: false,
        controller: controller,
        keyboardType: TextInputType.numberWithOptions(
          decimal: decimal,
        ),
        style: Theme.of(context).textTheme.headline4!.copyWith(
              overflow: TextOverflow.ellipsis,
            ),
        textAlign: TextAlign.center,
        textAlignVertical: TextAlignVertical.center,
        onChanged: onChanged,
      ),
    );
  }
}