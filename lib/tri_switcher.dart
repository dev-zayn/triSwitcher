library tri_switcher;

import 'package:flutter/material.dart';

/// Enum representing the switch positions
enum SwitchPosition { left, center, right }

/// A custom widget that switches between three states (left, center, right)
/// when dragged or tapped.
class TriSwitcher extends StatefulWidget {
  /// Creates a [TriSwitcher] widget.
  ///
  /// The [onChanged] callback must not be null.
  /// The [icons] list, if provided, must contain exactly 3 widgets.
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
    this.borderRadius,
    this.duration = const Duration(milliseconds: 250),
    this.curve = Curves.linear,
    this.size = 76.5,
    this.icons,
  }) : assert(icons == null || icons.length == 3,
            'icons must be null or a list of exactly 3 widgets');

  /// Callback that is called when the switch position changes.
  final ValueChanged<SwitchPosition> onChanged;

  /// Initial position of the switcher.
  final SwitchPosition? initialPosition;

  /// Background color for the first state.
  final Color firstStateBackgroundColor;

  /// Background color for the second state.
  final Color secondStateBackgroundColor;

  /// Background color for the third state.
  final Color thirdStateBackgroundColor;

  /// Toggle color for the first state.
  final Color firstStateToggleColor;

  /// Toggle color for the second state.
  final Color secondStateToggleColor;

  /// Toggle color for the third state.
  final Color thirdStateToggleColor;

  /// List of icons to display in the toggle.
  final List<Widget>? icons;

  /// Shape of the toggle.
  final BoxShape toggleShape;

  /// Border radius for the switcher.
  final BorderRadiusGeometry? borderRadius;

  /// Duration of the animation.
  final Duration duration;

  /// Curve of the animation.
  final Curve curve;

  /// Size of the switcher.
  final double size;

  @override
  State<TriSwitcher> createState() => _TriStateToggleSwitchPosition();
}

class _TriStateToggleSwitchPosition extends State<TriSwitcher> {
  /// Current position of the switcher.
  late SwitchPosition _switchPosition;

  /// Distance dragged by the user.
  double _dragDistance = 0.0;

  /// Threshold for the drag distance to change the state.
  final double _dragThreshold = 20.0;

  @override
  void initState() {
    super.initState();
    _switchPosition = widget.initialPosition ?? SwitchPosition.left;
  }

  /// Toggles the state of the switcher.
  ///
  /// If [position] is provided, sets the switcher to that position.
  /// Otherwise, cycles through the positions in the order: left -> center -> right.
  void toggleState({SwitchPosition? position}) {
    setState(() {
      if (position != null) {
        _switchPosition = position;
      } else {
        _switchPosition =
            SwitchPosition.values[(_switchPosition.index + 1) % 3];
      }
    });
    widget.onChanged(_switchPosition);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: toggleState,
      onPanUpdate: (details) {
        _dragDistance += details.delta.dx;
        if (_dragDistance.abs() > _dragThreshold) {
          if (_dragDistance > 0 && _switchPosition != SwitchPosition.right) {
            toggleState(
                position: SwitchPosition.values[_switchPosition.index + 1]);
          } else if (_dragDistance < 0 &&
              _switchPosition != SwitchPosition.left) {
            toggleState(
                position: SwitchPosition.values[_switchPosition.index - 1]);
          }
          _dragDistance = 0.0;
        }
      },
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
          borderRadius:
              widget.borderRadius ?? BorderRadius.circular(widget.size * 0.5),
        ),
        padding: const EdgeInsets.symmetric(vertical: 3.0),
        alignment: _switchPosition == SwitchPosition.left
            ? Alignment.centerLeft
            : _switchPosition == SwitchPosition.center
                ? Alignment.center
                : Alignment.centerRight,
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
              : const SizedBox.shrink(),
        ),
      ),
    );
  }
}
