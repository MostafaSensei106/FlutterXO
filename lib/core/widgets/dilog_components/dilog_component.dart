import 'package:flutter/material.dart';
import '../../config/const/sensei_const.dart';
import '../container_background_component/container_background_component.dart';

class DilogComponent extends StatelessWidget {
  const DilogComponent({
    required this.title,
    required this.message,
    required this.actions,
    required this.icon,
    super.key,
  });
  final String title;
  final String message;
  final IconData icon;
  final List<Widget>? actions;

  /// Show the dialog component
  ///
  /// This function will show the DilogComponent in the given context.
  /// It will create a new instance of DilogComponent with the given
  /// title, message, actions and icon.
  void show(final BuildContext context) {
    showDialog(
      context: context,
      builder: (final BuildContext context) => DilogComponent(
        title: title,
        message: message,
        actions: actions,
        icon: icon,
      ),
    );
  }

  @override
  /// Builds a [DilogComponent].
  ///
  /// This function returns an [AlertDialog] widget with an icon of the given
  /// [icon], a title of the given [title], a content of the given [message],
  /// and actions of the given [actions].
  ///
  /// The [AlertDialog] widget is configured with no elevation, a shape of
  /// [RoundedRectangleBorder] with the [SenseiConst.outBorderRadius] radius,
  /// and a content padding of [SenseiConst.padding].
  ///
  /// The content of the [AlertDialog] widget is a [Container] widget with a
  /// padding of [SenseiConst.padding] and a decoration of
  /// [BoxDecoration] with a color of the
  /// [Theme.of(context).colorScheme.surfaceContainer] color and a border
  /// radius of [SenseiConst.inBorderRadius.r].
  ///
  /// The [Container] widget has a [Text] widget as child, which is
  /// configured with the given [message] and no style.
  Widget build(final BuildContext context) => AlertDialog(
    elevation: 0,
    icon: Icon(icon, size: SenseiConst.iconSize),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(SenseiConst.outBorderRadius),
    ),
    title: Text(title),
    content: ContainerBackgroundComponent(
      useInBorderRadius: true,
      padding: const EdgeInsets.all(SenseiConst.padding),
      color: Theme.of(context).colorScheme.surfaceContainer,
      child: Text(message),
    ),
    actions: actions,
  );
}
