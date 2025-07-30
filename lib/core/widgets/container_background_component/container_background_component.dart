import 'package:flutter/material.dart' show EdgeInsetsGeometry, Theme;
import 'package:flutter/widgets.dart'
    show
        BorderRadius,
        BoxDecoration,
        BuildContext,
        Color,
        Container,
        StatelessWidget,
        Widget;

import '../../config/const/sensei_const.dart';

class ContainerBackgroundComponent extends StatelessWidget {
  const ContainerBackgroundComponent({
    required this.child,
    super.key,
    this.useInBorderRadius = false,
    this.margin,
    this.padding,
    this.color,
  });
  final Widget child;
  final bool useInBorderRadius;
  final Color? color;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;

  @override
  /// Returns a [Container] widget with the given properties.
  ///
  /// The [color] property of the [BoxDecoration] is set to the
  /// [Theme.of(context).colorScheme.surfaceContainer] color.
  ///
  /// The [borderRadius] property of the [BoxDecoration] is set to a
  /// [BorderRadius.circular] with a radius determined by the
  /// [useInBorderRadius] property.
  ///
  /// The [child] is passed as-is.
  Widget build(final BuildContext context) => Container(
    margin: margin,
    padding: padding,
    decoration: BoxDecoration(
      color: color ?? Theme.of(context).colorScheme.surfaceContainer,
      borderRadius: useInBorderRadius
          ? BorderRadius.circular(SenseiConst.inBorderRadius)
          : BorderRadius.circular(SenseiConst.outBorderRadius),
    ),
    child: child,
  );
}
