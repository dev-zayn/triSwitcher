library tri_switcher;

import 'package:flutter/material.dart';

/// Enum for the switch position
enum SwitchPosition { left, center, right }

class TriSwitcher extends StatefulWidget {
  const TriSwitcher({
    super.key,
    required this.onChanged,
    this.initialPosition,
    this.firstStateBackgroundColor = Colors.grey,
    this.secondStateBackgroundColor = Colors.green,
    this.thirdStateBackgroundColor = Colors.blue,
    this.firstStateToggleColor = Colors.white,
    this.secondStateToggleColor = Colors.white,
    this.thirdStateToggleColor = Colors.white,
    this.toggleShape = BoxShape.circle,
    this.borderRadius = const BorderRadius.all(Radius.circular(20.0)),
    this.duration = const Duration(milliseconds: 250),
    this.curve = Curves.linear,
    this.size = 76.5,
    this.icons,
  }) : assert(icons == null || icons.length == 3,
            'icons must be null or a list of exactly 3 widgets');

  /// Callback for the switcher
  final ValueChanged<SwitchPosition> onChanged;

  /// Initial position of the switcher
  final SwitchPosition? initialPosition;

  /// Color for the first state background
  final Color firstStateBackgroundColor;

  /// Color for the second state background
  final Color secondStateBackgroundColor;

  /// Color for the third state background
  final Color thirdStateBackgroundColor;

  /// Color for the first state toggle
  final Color firstStateToggleColor;

  /// Color for the second state toggle
  final Color secondStateToggleColor;

  /// Color for the third state toggle
  final Color thirdStateToggleColor;

  /// Icons for the switcher
  final List<Widget>? icons;

  /// Shape of the toggle
  final BoxShape toggleShape;

  /// Border radius for the switcher
  final BorderRadiusGeometry borderRadius;

  /// Duration for the animation
  final Duration duration;

  /// Curve for the animation
  final Curve curve;

  /// Width of the switcher
  final double size;

  @override
  State<TriSwitcher> createState() => _TriStateToggleSwitchPosition();
}

class _TriStateToggleSwitchPosition extends State<TriSwitcher> {
  late SwitchPosition switchInitialPosition;

  late SwitchPosition switchLastKnownPosition;

  late SwitchPosition _switchPosition;

  @override
  void initState() {
    _switchPosition = widget.initialPosition ?? SwitchPosition.left;
    switchInitialPosition = _switchPosition;
    switchLastKnownPosition = _switchPosition;
    super.initState();
  }

  void toggleState() {
    switch (switchInitialPosition) {
      case SwitchPosition.left:
        switchInitialPosition = SwitchPosition.center;
        switchLastKnownPosition = SwitchPosition.left;
        _switchPosition = SwitchPosition.center;

        break;
      case SwitchPosition.center:
        switchInitialPosition = SwitchPosition.right;
        switchLastKnownPosition = SwitchPosition.center;
        _switchPosition = SwitchPosition.right;
        break;
      case SwitchPosition.right:
        switchInitialPosition = SwitchPosition.left;
        switchLastKnownPosition = SwitchPosition.right;
        _switchPosition = SwitchPosition.left;
        break;
      default:
        switchInitialPosition = SwitchPosition.center;
        switchLastKnownPosition = SwitchPosition.left;
        _switchPosition = SwitchPosition.center;
        break;
    }
    setState(() {});
    widget.onChanged(_switchPosition);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: toggleState,
      child: AnimatedContainer(
        duration: widget.duration,
        curve: widget.curve,
        width: widget.size,
        height: widget.size * 0.45,
        decoration: BoxDecoration(
          color: _switchPosition == SwitchPosition.left
              ? widget.firstStateBackgroundColor
              : _switchPosition == SwitchPosition.center
                  ? widget.secondStateBackgroundColor
                  : widget.thirdStateBackgroundColor,
          borderRadius: widget.borderRadius,
        ),
        padding: const EdgeInsets.symmetric(vertical: 3.0),
        alignment: (_switchPosition == SwitchPosition.left
            ? Alignment.centerLeft
            : _switchPosition == SwitchPosition.center
                ? Alignment.center
                : Alignment.centerRight),
        child: Container(
            height: widget.size * .44,
            width: widget.size * .44,
            padding: const EdgeInsets.all(1.0),
            decoration: BoxDecoration(
              shape: widget.toggleShape,
              color: _switchPosition == SwitchPosition.left
                  ? widget.firstStateToggleColor
                  : _switchPosition == SwitchPosition.center
                      ? widget.secondStateToggleColor
                      : widget.thirdStateToggleColor,
            ),
            child: widget.icons != null
                ? widget.icons![_switchPosition.index]
                : const SizedBox()),
      ),
    );
  }
}
