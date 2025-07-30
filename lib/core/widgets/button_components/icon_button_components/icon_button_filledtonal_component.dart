import 'package:flutter/material.dart'
    show
        IconButton,
        Theme,
        StatelessWidget,
        IconData,
        VoidCallback,
        Color,
        BuildContext,
        Widget,
        Icon,
        BorderRadius,
        RoundedRectangleBorder,
        SystemMouseCursors;
import 'package:flutter/services.dart' show HapticFeedback;

import '../../../config/const/sensei_const.dart' show SenseiConst;

class IconButtonFilledTonalComponent extends StatelessWidget {
  const IconButtonFilledTonalComponent({
    required this.icon,
    required this.onPressed,
    this.useInBorderRadius = false,
    this.color,
    super.key,
  });
  final IconData icon;
  final VoidCallback onPressed;
  final bool useInBorderRadius;
  final Color? color;

  @override
  /// Builds an [IconButton] widget that displays an icon and
  /// responds to taps by calling [onPressed] and providing haptic
  /// feedback. The button's appearance is determined by the [icon]
  /// property.
  Widget build(final BuildContext context) => IconButton.filledTonal(
    icon: Icon(icon),
    color: color ?? Theme.of(context).colorScheme.onSurface,
    onPressed: () {
      HapticFeedback.vibrate();
      onPressed();
    },
    style: IconButton.styleFrom(
      shape: RoundedRectangleBorder(
        borderRadius: useInBorderRadius
            ? BorderRadius.circular(SenseiConst.inBorderRadius)
            : BorderRadius.circular(SenseiConst.outBorderRadius),
      ),
      elevation: 0,
      enabledMouseCursor: SystemMouseCursors.click,
    ),
  );
}
