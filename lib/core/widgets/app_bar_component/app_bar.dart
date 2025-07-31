import 'package:flutter/material.dart';
import 'action_drawer_icons.dart';

class SenseiAppBar extends StatelessWidget implements PreferredSizeWidget {
  const SenseiAppBar({required this.title, super.key});
  final String title;
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(final BuildContext context) => AppBar(
    elevation: 0,
    backgroundColor: Colors.transparent,
    leading: const ActionDrawerIcon(),
    title: Text(title),
  );
}
