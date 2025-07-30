import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart'
    show
        BuildContext,
        StatelessWidget,
        Widget,
        AlertDialog,
        IconData,
        VoidCallback,
        Theme;

import '../../config/const/sensei_const.dart' show SenseiConst;
import '../container_background_component/container_background_component.dart';

class DilogAskUserComponents extends StatelessWidget {
  const DilogAskUserComponents({
    required this.title,
    required this.question,
    required this.icon,
    required this.isYes,
    required this.onYes,
    required this.onNo,
    super.key,
  });

  final String title;
  final String question;
  final IconData icon;
  final bool isYes;
  final VoidCallback onYes;
  final VoidCallback onNo;

  @override
  Widget build(final BuildContext context) => AlertDialog(
    elevation: 0,
    icon: Icon(icon, size: SenseiConst.iconSize),
    title: Text(title),
    content: ContainerBackgroundComponent(
      useInBorderRadius: true,
      padding: const EdgeInsets.all(SenseiConst.padding),
      color: Theme.of(context).colorScheme.primaryContainer,
      child: Text(question),
    ),
  );
}
