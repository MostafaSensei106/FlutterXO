import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/config/const/app_enums.dart';
import '../../../core/logic/settings/cubit/settings_cubit.dart';
import '../../../core/logic/settings/cubit/settings_state.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(final BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Settings')),
    body: BlocBuilder<SettingsCubit, SettingsState>(
      builder: (final context, final state) => Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Player Names',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            TextField(
              decoration: const InputDecoration(
                labelText: 'Player 1 Name (X)',
                border: OutlineInputBorder(),
              ),
              controller: TextEditingController(text: state.player1Name),
              onChanged: (final value) {
                context.read<SettingsCubit>().updatePlayer1Name(value);
              },
            ),
            const SizedBox(height: 15),
            TextField(
              decoration: const InputDecoration(
                labelText: 'Player 2 Name (O)',
                border: OutlineInputBorder(),
              ),
              controller: TextEditingController(text: state.player2Name),
              onChanged: (final value) {
                context.read<SettingsCubit>().updatePlayer2Name(value);
              },
            ),
            const SizedBox(height: 30),
            const Text(
              'AI Difficulty',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Column(
              children: AIDifficulty.values
                  .map(
                    (final difficulty) => RadioListTile<AIDifficulty>(
                      title: Text(_getDifficultyDescription(difficulty)),
                      value: difficulty,
                      groupValue: state.aiDifficulty,
                      onChanged: (final AIDifficulty? value) {
                        if (value != null) {
                          context.read<SettingsCubit>().updateAIDifficulty(
                            value,
                          );
                        }
                      },
                    ),
                  )
                  .toList(),
            ),
          ],
        ),
      ),
    ),
  );

  String _getDifficultyDescription(final AIDifficulty difficulty) {
    switch (difficulty) {
      case AIDifficulty.easy:
        return 'Easy - Random moves';
      case AIDifficulty.medium:
        return 'Medium - Sometimes smart';
      case AIDifficulty.hard:
        return 'Hard - Always optimal';
    }
  }

  String _getTimeModeDescription(final TimeMode timeMode) {
    switch (timeMode) {
      case TimeMode.classic:
        return 'Classic - No time limit';
      case TimeMode.rapid5:
        return 'Rapid - 5 minutes per player';
      case TimeMode.rapid10:
        return 'Rapid - 10 minutes per player';
      case TimeMode.rapid15:
        return 'Rapid - 15 minutes per player';
      case TimeMode.rapid30:
        return 'Rapid - 30 minutes per player';
      case TimeMode.blitz:
        return 'Blitz - 3 minutes per player';
      case TimeMode.bullet:
        return 'Bullet - 1 minute per player';
    }
  }
}
