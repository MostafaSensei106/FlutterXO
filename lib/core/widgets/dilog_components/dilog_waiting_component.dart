import 'package:flutter/material.dart';
import '../../config/const/sensei_const.dart';
import 'dilog_component.dart';

class DilogWatingComponent extends DilogComponent {
  const DilogWatingComponent({
    required super.title,
    required super.message,
    required super.icon,
    super.key,
    super.actions,
  });

  @override
  Widget build(final BuildContext context) => AlertDialog(
    icon: const Icon(Icons.info_outline_rounded, size: SenseiConst.iconSize),
    title: Text(title),
    content: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const LinearProgressIndicator(),
        const SizedBox(height: 16),
        Text(message),
      ],
    ),
  );
}
