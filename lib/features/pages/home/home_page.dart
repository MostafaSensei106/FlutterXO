import 'package:flutter/material.dart';

import '../../../core/config/const/app_enums.dart';
import '../../../core/logic/game/cubit/game_cubit.dart';
import '../../../core/widgets/app_drawer/widgets/drawer.dart'
    show SettingsDrawer;
import '../../../core/widgets/button_components/icon_button_components/icon_button_filled_component.dart';
import '../gmae/game_page.dart';
import '../setting_page/settings_page.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(final BuildContext context) => Scaffold(
    appBar: AppBar(
      title: const Text('Wellcome to Tic Tac Toe Game'),
      leading: IconButtonFilledComponent(
        icon: Icons.more_horiz_rounded,
        onPressed: () => Scaffold.of(context).openDrawer(),
      ),
    ),
    drawer: const SettingsDrawer(),
    body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.games, size: 100, color: Colors.blue),
          const SizedBox(height: 30),
          const Text(
            'Choose Game Mode',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 30),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (final context) =>
                      const GameScreen(mode: GameMode.vsAI),
                ),
              );
            },
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
              child: Text('Play vs AI', style: TextStyle(fontSize: 18)),
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (final context) =>
                      const GameScreen(mode: GameMode.vsFriend),
                ),
              );
            },
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
              child: Text('Play vs Friend', style: TextStyle(fontSize: 18)),
            ),
          ),
        ],
      ),
    ),
  );
}
