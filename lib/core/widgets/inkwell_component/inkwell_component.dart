import 'package:flutter/material.dart'
    show
        BorderRadius,
        BuildContext,
        Colors,
        InkWell,
        Material,
        StatelessWidget,
        VoidCallback,
        Widget;
import 'package:flutter/services.dart' show HapticFeedback;

class InkwellComponent extends StatelessWidget {
  const InkwellComponent({
    required this.child,
    required this.borderRadius,
    super.key,
    this.onTap,
  });
  final Widget child;
  final BorderRadius borderRadius;
  final VoidCallback? onTap;
  @override
  Widget build(final BuildContext context) => Material(
    color: Colors.transparent,
    child: InkWell(
      borderRadius: borderRadius,
      onTap: onTap == null
          ? null
          : () {
              HapticFeedback.vibrate();
              onTap!();
            },
      child: child,
    ),
  );
}
