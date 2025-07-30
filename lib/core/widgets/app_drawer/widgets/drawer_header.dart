import 'package:flutter/material.dart';
import '../../../config/const/sensei_const.dart';

class DrawerHeaderWidget extends StatelessWidget {
  const DrawerHeaderWidget({super.key});

  @override
  /// Returns a [DrawerHeader] widget with a [Decoration] set to a [BoxDecoration]
  /// with a [DecorationImage] as the [image] property. The [DecorationImage] is
  /// configured with the 'assets/images/WaterMelonCover.jpg' image and a
  /// [BoxFit] of [BoxFit.cover].
  ///
  /// The child of the [DrawerHeader] widget is null.
  Widget build(final BuildContext context) => const DrawerHeader(
    decoration: BoxDecoration(
      image: DecorationImage(
        image: AssetImage(SenseiConst.drawerImage),
        fit: BoxFit.cover,
      ),
    ),
    child: null,
  );
}
