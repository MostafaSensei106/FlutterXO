import 'package:flutter/material.dart'
    show
        StatefulWidget,
        IconData,
        State,
        SingleTickerProviderStateMixin,
        AnimationController,
        Animation,
        BuildContext,
        Widget,
        EdgeInsets,
        SizedBox,
        IntTween,
        Theme,
        Icon,
        TextAlign,
        Text,
        Column;

import '../../config/const/sensei_const.dart' show SenseiConst;
import '../../config/fonts/fonts.dart' show AppTextStyle;
import '../container_background_component/container_background_component.dart'
    show ContainerBackgroundComponent;

/// A visual counter widget that displays an icon, a title, and an animated integer value.
///
/// [CounterItemsComponent] is a stateful widget that animates from a previous
/// integer value to a new target value using an [AnimationController].
///
/// It’s used to present counter-style statistics in a compact and styled container.
class CounterItemsComponent extends StatefulWidget {
  /// Creates a [CounterItemsComponent].
  ///
  /// Requires:
  /// - [icon]: The icon to display.
  /// - [title]: The text title below the icon.
  /// - [targetValue]: The integer target value to count up to.
  const CounterItemsComponent({
    required this.icon,
    required this.title,
    required this.targetValue,
    super.key,
  });

  /// The icon displayed at the top of the component.
  final IconData icon;

  /// The title displayed below the icon.
  final String title;

  /// The final value to animate to.
  final int targetValue;

  @override
  State<CounterItemsComponent> createState() => _CounterItemsComponentState();
}

/// State class for [CounterItemsComponent].
///
/// Manages the animation logic and handles rebuilds when the target value changes.
class _CounterItemsComponentState extends State<CounterItemsComponent>
    with SingleTickerProviderStateMixin {
  /// Controller for driving the counter animation.
  late AnimationController _controller;

  /// Integer animation from the current to the target value.
  late Animation<int> _animation;

  /// Holds the current value of the counter during animation.
  int _currentValue = 0;

  @override
  /// Initializes the animation controller and triggers the first animation.
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    _updateAnimation(widget.targetValue);
  }

  @override
  /// Updates the animation if the target value has changed.
  ///
  /// Called automatically when the parent widget rebuilds and passes new parameters.
  void didUpdateWidget(final CounterItemsComponent oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.targetValue != oldWidget.targetValue) {
      _updateAnimation(widget.targetValue);
    }
  }

  /// Updates the animation to a new [targetValue].
  ///
  /// Animates from [_currentValue] to [targetValue] and updates the state
  /// during the animation.
  void _updateAnimation(final int targetValue) {
    _animation =
        IntTween(begin: _currentValue, end: targetValue).animate(_controller)
          ..addListener(() {
            setState(() {
              _currentValue = _animation.value;
            });
          });

    _controller.forward(from: 0.0);
  }

  @override
  /// Disposes the animation controller to free resources.
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  /// Builds the animated counter widget layout.
  ///
  /// Contains:
  /// - Icon in styled container
  /// - Title text
  /// - Current animated value
  Widget build(final BuildContext context) => ContainerBackgroundComponent(
    margin: const EdgeInsets.only(top: SenseiConst.margin),
    padding: const EdgeInsets.all(SenseiConst.padding),
    child: Column(
      children: [
        ContainerBackgroundComponent(
          useInBorderRadius: true,
          padding: const EdgeInsets.all(SenseiConst.padding),
          color: Theme.of(context).colorScheme.primaryContainer,
          child: Icon(
            widget.icon,
            size: SenseiConst.iconSize,
            color: Theme.of(context).colorScheme.onPrimary,
          ),
        ),
        const SizedBox(height: 4),
        Text(widget.title, textAlign: TextAlign.center),
        const SizedBox(height: 4),
        Text(
          _currentValue.toString(),
          style: AppTextStyle(context).subtitle.copyWith(fontSize: 16),
        ),
      ],
    ),
  );
}
