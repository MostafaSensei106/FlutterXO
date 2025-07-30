import 'package:flutter/material.dart'
    show
        IconButton,
        StatelessWidget,
        IconData,
        VoidCallback,
        BuildContext,
        Widget,
        Icon,
        SystemMouseCursors;
import 'package:flutter/services.dart' show HapticFeedback;

class IconButtonComponent extends StatelessWidget {
  const IconButtonComponent({
    required this.icon,
    required this.onPressed,
    super.key,
  });
  final IconData icon;
  final VoidCallback onPressed;

  @override
  /// Builds an [IconButton] widget that displays an icon and
  /// responds to taps by calling [onPressed] and providing haptic
  /// feedback. The button's appearance is determined by the [icon]
  /// property.
  Widget build(final BuildContext context) => IconButton(
    icon: Icon(icon),
    onPressed: () {
      HapticFeedback.vibrate();
      onPressed();
    },
    style: IconButton.styleFrom(
      elevation: 0,
      enabledMouseCursor: SystemMouseCursors.click,
    ),
  );
}
