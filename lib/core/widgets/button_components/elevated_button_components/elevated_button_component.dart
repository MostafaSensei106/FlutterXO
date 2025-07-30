import 'package:flutter/material.dart'
    show
        StatelessWidget,
        EdgeInsets,
        IconData,
        BuildContext,
        Widget,
        ElevatedButton,
        Icon,
        Text,
        Theme,
        BorderRadius,
        RoundedRectangleBorder,
        WidgetStateMouseCursor,
        Container;

import '../../../config/const/sensei_const.dart' show SenseiConst;

class ElevatedButtonCompnent extends StatelessWidget {
  const ElevatedButtonCompnent({
    required this.label,
    required this.icon,
    required this.onPressed,
    super.key,
    this.isEnabled = true,
    this.useMargin = false,
    this.useInBorderRadius = false,
  });
  final String label;
  final IconData icon;
  final void Function()? onPressed;
  final bool isEnabled;
  final bool useMargin;
  final bool useInBorderRadius;

  @override
  /// Returns a [SizedBox] widget with a [ElevatedButton.icon] widget as child.
  /// The [ElevatedButton.icon] widget is configured with the given properties.
  ///
  /// The [ElevatedButton.icon] widget is fully enabled if [isEnabled] is true,
  /// otherwise it is disabled.
  ///
  /// The [ElevatedButton.icon] widget has a rounded border with the
  /// [SenseiConst.inBorderRadius] radius, and an elevation of 2.
  ///
  /// The button is filled with the [Theme.of(context).colorScheme.primaryContainer]
  /// color and has a foreground color of
  /// [Theme.of(context).colorScheme.onPrimaryContainer].
  ///
  /// The button icon is filled with the [Theme.of(context).colorScheme.onPrimaryContainer]
  /// color and has a size of [SenseiConst.iconSize].
  ///
  /// The button label is filled with the [Theme.of(context).colorScheme.onPrimaryContainer]
  /// color and has a size of [SenseiConst.iconSize].
  ///
  /// When the button is disabled, the background color is set to
  /// [Theme.of(context).colorScheme.error], the foreground color is set to
  /// [Theme.of(context).colorScheme.onError], and the icon color is set to
  /// [Theme.of(context).colorScheme.onError].
  ///
  /// The button has a padding of [SenseiConst.padding] around it, and an enabled
  /// mouse cursor.
  Widget build(final BuildContext context) => Container(
    margin: useMargin ? const EdgeInsets.only(top: SenseiConst.margin) : null,
    child: ElevatedButton.icon(
      onPressed: isEnabled ? onPressed : null,
      icon: Icon(icon, size: SenseiConst.iconSize),
      label: Text(label),
      style: ElevatedButton.styleFrom(
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        foregroundColor: Theme.of(context).colorScheme.onPrimaryContainer,
        disabledBackgroundColor: Theme.of(context).colorScheme.error,
        disabledForegroundColor: Theme.of(context).colorScheme.onError,
        iconColor: Theme.of(context).colorScheme.onPrimaryContainer,
        disabledIconColor: Theme.of(context).colorScheme.onError,
        padding: const EdgeInsets.symmetric(
          horizontal: SenseiConst.padding,
          vertical: SenseiConst.padding,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: useInBorderRadius
              ? BorderRadius.circular(SenseiConst.inBorderRadius)
              : BorderRadius.circular(SenseiConst.outBorderRadius),
        ),
        elevation: 2,
        enableFeedback: true,
        enabledMouseCursor: WidgetStateMouseCursor.clickable,
      ),
    ),
  );
}
