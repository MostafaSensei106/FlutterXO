import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../config/const/sensei_const.dart';
import '../../config/fonts/fonts.dart';

class ExpansionTileComponent extends StatefulWidget {
  const ExpansionTileComponent({
    required this.leadingIcon,
    required this.title,
    required this.subtitle,
    required this.children,
    super.key,
    this.useInBorderRadius = false,
    this.useMargin = false,
  });
  final IconData leadingIcon;
  final String title;
  final String subtitle;
  final List<Widget> children;
  final bool useInBorderRadius;
  final bool useMargin;

  @override
  State<ExpansionTileComponent> createState() => _ExpansionTileComponentState();
}

class _ExpansionTileComponentState extends State<ExpansionTileComponent> {
  @override
  Widget build(final BuildContext context) {
    final tileMargin = widget.useMargin
        ? EdgeInsets.only(top: SenseiConst.margin.h)
        : null;
    final tileDecoration = BoxDecoration(
      color: Theme.of(context).colorScheme.surfaceContainer,
      borderRadius: BorderRadius.circular(
        widget.useInBorderRadius
            ? SenseiConst.inBorderRadius
            : SenseiConst.outBorderRadius,
      ),
    );
    final tileLeading = Container(
      padding: const EdgeInsets.all(SenseiConst.padding),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(SenseiConst.inBorderRadius),
        color: Theme.of(context).colorScheme.surfaceContainerHigh,
      ),
      child: Icon(widget.leadingIcon, size: SenseiConst.iconSize),
    );
    final tileTitle = Text(widget.title);
    final tileSubtitle = Text(
      widget.subtitle,
      style: AppTextStyle(context).subtitle,
    );
    final tileChildren = widget.children;
    final tileShape = RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(
        widget.useInBorderRadius
            ? SenseiConst.inBorderRadius
            : SenseiConst.outBorderRadius,
      ),
      side: BorderSide(
        color: Theme.of(context).colorScheme.outline.withAlpha(0x80),
      ),
    );

    return Container(
      margin: tileMargin,
      decoration: tileDecoration,
      child: ExpansionTile(
        leading: tileLeading,
        title: tileTitle,
        subtitle: tileSubtitle,
        backgroundColor: Theme.of(context).colorScheme.surfaceContainer,
        shape: tileShape,
        children: tileChildren,
      ),
    );
  }
}
