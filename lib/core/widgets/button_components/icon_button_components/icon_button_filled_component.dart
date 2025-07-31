import 'package:flutter/material.dart' show IconButton, Theme;
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import '../../../config/const/sensei_const.dart' show SenseiConst;

class IconButtonFilledComponent extends StatelessWidget {
  const IconButtonFilledComponent({
    required this.icon,
    required this.onPressed,
    this.useInBorderRadius = false,
    super.key,
  });
  final IconData icon;
  final VoidCallback onPressed;
  final bool useInBorderRadius;

  @override
  /// Builds an [IconButton] widget that displays an icon and
  /// responds to taps by calling [onPressed] and providing haptic
  /// feedback. The button's appearance is determined by the [icon]
  /// property.
  Widget build(final BuildContext context) => IconButton.filled(
    icon: Icon(icon),
    color: Theme.of(context).colorScheme.surfaceContainer,
    onPressed: () {
      HapticFeedback.vibrate();
      onPressed();
    },
    enableFeedback: true,
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
