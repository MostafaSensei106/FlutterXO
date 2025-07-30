import 'package:flutter/material.dart'
    show
        BorderRadius,
        BoxDecoration,
        BuildContext,
        Column,
        Container,
        EdgeInsets,
        Icon,
        IconData,
        InkWell,
        ListTile,
        Material,
        Radius,
        StatelessWidget,
        Text,
        TextOverflow,
        Theme,
        VoidCallback,
        Widget;
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../config/const/app_enums.dart' show ListTileGroupType;
import '../../config/const/sensei_const.dart';
import '../../config/fonts/fonts.dart' show AppTextStyle;
import '../container_background_component/container_background_component.dart';
import '../divider.dart' show FullAppDividerComponents;
import '../inkwell_component/inkwell_component.dart';

class ListTileIconComponent extends StatelessWidget {
  const ListTileIconComponent({
    required this.iconLeading,
    required this.title,
    required this.groupType,
    super.key,
    this.subtitle,
    this.trailing,
    this.onTap,
    this.useinBorderRadius = false,
    this.selected,
    this.useMargin = true,
  });
  final IconData iconLeading;
  final String title;
  final String? subtitle;
  final Widget? trailing;
  final VoidCallback? onTap;
  final bool? selected;
  final bool useinBorderRadius;
  final bool useMargin;
  final ListTileGroupType groupType;

  /// Calculates the border radius for the [ListTile] based on the [ListTileGroupType]
  /// and [useinBorderRadius].
  ///
  /// The [ListTileGroupType.top] and [ListTileGroupType.bottom] will have a border
  /// radius on the top and bottom respectively, while [ListTileGroupType.single] will
  /// have a border radius on all sides. [ListTileGroupType.middle] and
  /// [ListTileGroupType.none] will have no border radius.
  ///
  /// If [useinBorderRadius] is `true`, the radius will be set to
  /// [AppConstants.inBorderRadius], otherwise it will be set to
  /// [AppConstants.outBorderRadius].
  BorderRadius _getBorderRadius() {
    final borderRadius = useinBorderRadius
        ? SenseiConst.inBorderRadius
        : SenseiConst.outBorderRadius;
    switch (groupType) {
      case ListTileGroupType.top:
        return BorderRadius.vertical(top: Radius.circular(borderRadius));
      case ListTileGroupType.bottom:
        return BorderRadius.vertical(bottom: Radius.circular(borderRadius));
      case ListTileGroupType.single:
        return BorderRadius.circular(borderRadius);
      case ListTileGroupType.middle:
        return BorderRadius.zero;
      case ListTileGroupType.none:
        return BorderRadius.circular(0);
    }
  }

  @override
  /// Builds a [Container] widget with a [Column] containing a [Material]
  /// widget wrapping a [ListTile]. The appearance and behavior of the
  /// [ListTile] are determined by the provided parameters. It includes
  /// customizable [iconLeading], [title], [subtitle], and [trailing] widgets.
  /// The [onTap] callback is triggered when the [InkWell] is tapped.
  /// The border radius is configured based on the [groupType] and
  /// [useinBorderRadius] properties, and the background color is set
  /// according to the current theme's color scheme.
  Widget build(final BuildContext context) {
    final borderRadius = _getBorderRadius();
    return Container(
      margin:
          useMargin &&
              (groupType == ListTileGroupType.top ||
                  groupType == ListTileGroupType.single)
          ? EdgeInsets.only(top: SenseiConst.margin.h)
          : null,
      decoration: BoxDecoration(
        borderRadius: borderRadius,
        color: Theme.of(context).colorScheme.surfaceContainer,
      ),
      child: Column(
        children: [
          InkwellComponent(
            onTap: onTap == null
                ? null
                : () {
                    onTap!();
                  },
            borderRadius: borderRadius,
            child: ListTile(
              leading: ContainerBackgroundComponent(
                padding: const EdgeInsets.all(SenseiConst.padding),
                color: Theme.of(context).colorScheme.surfaceContainerHigh,
                useInBorderRadius: true,
                child: Icon(iconLeading, size: SenseiConst.iconSize),
              ),
              title: Text(title),
              subtitle: subtitle != null
                  ? Text(subtitle!, overflow: TextOverflow.ellipsis)
                  : null,
              subtitleTextStyle: AppTextStyle(context).subtitle,
              trailing: trailing,
              horizontalTitleGap: 13,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: SenseiConst.padding,
              ),
            ),
          ),
          if (groupType == ListTileGroupType.middle ||
              groupType == ListTileGroupType.top)
            const FullAppDividerComponents(),
        ],
      ),
    );
  }
}
