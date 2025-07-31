import 'package:flutter/material.dart';

import '../../../core/config/const/app_enums.dart';
import '../../../core/routing/routes.dart';
import '../../../core/widgets/app_bar_component/app_bar.dart';
import '../../../core/widgets/app_drawer/widgets/drawer.dart'
    show SettingsDrawer;
import '../../../core/widgets/button_components/elevated_button_components/elevated_button_component.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(final BuildContext context) => Scaffold(
    appBar: const SenseiAppBar(title: 'Home'),
    drawer: const SettingsDrawer(),
    body: Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset('assets/icon.png'),
            const SizedBox(height: 32),
            const Text(
              'Choose Game Mode',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 32),
            ElevatedButtonCompnent(
              label: 'Play vs AI',
              icon: Icons.computer,
              onPressed: () => Navigator.pushNamed(
                context,
                Routes.game,
                arguments: GameMode.vsAI,
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButtonCompnent(
              label: 'Play vs Friend',
              icon: Icons.people_outline_rounded,
              onPressed: () => Navigator.pushNamed(
                context,
                Routes.game,
                arguments: GameMode.vsFriend,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
