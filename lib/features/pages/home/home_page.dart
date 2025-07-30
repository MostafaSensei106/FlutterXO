import 'package:flutter/material.dart';

import '../gmae/game_page.dart' show GameScreen;

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(final BuildContext context) => Scaffold(
    appBar: AppBar(
      title: const Text('XO Game'),
      actions: [
        IconButton(
          icon: const Icon(Icons.settings),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (final context) => SettingsScreen()),
            );
          },
        ),
      ],
    ),
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
                  builder: (final context) => GameScreen(mode: GameMode.vsAI),
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
                  builder: (final context) => GameScreen(mode: GameMode.vsFriend),
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
