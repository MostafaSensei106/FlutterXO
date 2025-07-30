import 'package:flutter/material.dart';
import '../../config/const/sensei_const.dart';
import 'action_drawer_icons.dart';
import 'app_bar_title.dart';

class SenseiAppBar extends StatelessWidget implements PreferredSizeWidget {
  const SenseiAppBar(this.title, {super.key});
  final String title;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(final BuildContext context) => Container(
    decoration: const BoxDecoration(
      image: DecorationImage(
        image: AssetImage(SenseiConst.waterMelonCoverImage),
        fit: BoxFit.cover,
      ),
    ),
    child: AppBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      leading: const ActionDrawerIcon(),
      title: AppBarTitle(title: title),
    ),
  );
}
