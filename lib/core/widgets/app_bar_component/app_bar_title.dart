import 'package:flutter/material.dart';

import '../../config/fonts/fonts.dart';

class AppBarTitle extends StatelessWidget {
  const AppBarTitle({required this.title, super.key});

  final String title;

  @override
  /// Returns an [AnimatedSwitcher] which displays the [title] within a [Text]
  /// widget. When the [title] changes, the widget is animated out by sliding
  /// upwards and fading out, before the new widget is animated in by sliding
  /// downwards and fading in. The animation is curve is a ease-in-out curve.
  ///
  Widget build(final BuildContext context) => AnimatedSwitcher(
    duration: const Duration(milliseconds: 550),
    switchInCurve: Curves.easeInOut,
    switchOutCurve: Curves.easeInOut,
    transitionBuilder:
        (final Widget child, final Animation<double> animation) =>
            SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0, 1),
                end: Offset.zero,
              ).animate(animation),
              child: FadeTransition(opacity: animation, child: child),
            ),
    child: Text(
      title,
      key: ValueKey<String>(title),
      style: AppTextStyle(context).headline2.copyWith(color: Colors.white),
    ),
  );
}
