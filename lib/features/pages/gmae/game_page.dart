import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/config/const/app_enums.dart';
import '../../../core/logic/game/cubit/game_cubit.dart';
import '../../../core/logic/game/cubit/game_state.dart';
import '../../../core/logic/settings/cubit/settings_cubit.dart';
import '../../../core/logic/settings/cubit/settings_state.dart';
import '../../../core/widgets/button_components/icon_button_components/icon_button_filled_component.dart';

class GameScreen extends StatelessWidget {
  const GameScreen({required this.mode, super.key});
  final GameMode mode;

  @override
  Widget build(final BuildContext context) => Scaffold(
    appBar: AppBar(
      title: Text(mode == GameMode.vsAI ? 'vs AI' : 'vs Friend'),
      actions: [
        IconButtonFilledComponent(
          icon: Icons.refresh,
          onPressed: () {
            context.read<GameCubit>().startNewGame(mode: mode);
          },
        ),
      ],
    ),
    body: BlocBuilder<GameCubit, GameState>(
      builder: (final context, final gameState) =>
          BlocBuilder<SettingsCubit, SettingsState>(
            bloc: context.read<SettingsCubit>(),
            builder: (final context, final settingsState) {
              // Start new game when screen loads
              if (gameState.mode != mode) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  context.read<GameCubit>().startNewGame(
                    mode: mode,
                    difficulty: settingsState.aiDifficulty,
                    timeMode: settingsState.timeMode,
                  );
                });
              }

              return Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    buildPlayerInfo(gameState, settingsState, context),
                    const SizedBox(height: 20),
                    buildGameBoard(context, gameState),
                    const SizedBox(height: 20),
                    buildGameStatus(gameState, settingsState),
                    const SizedBox(height: 20),
                    if (gameState.status != GameStatus.playing)
                      ElevatedButton(
                        onPressed: () {
                          context.read<GameCubit>().startNewGame(
                            mode: mode,
                            difficulty: settingsState.aiDifficulty,
                            timeMode: settingsState.timeMode,
                          );
                        },
                        child: const Text('Play Again'),
                      ),
                  ],
                ),
              );
            },
          ),
    ),
  );

  Widget buildPlayerInfo(
    final GameState gameState,
    final SettingsState settingsState,
    final BuildContext context,
  ) {
    final player1Name = settingsState.player1Name;
    final player2Name = gameState.mode == GameMode.vsAI
        ? 'AI (${getDifficultyText(settingsState.aiDifficulty)})'
        : settingsState.player2Name;

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              children: [
                Text(
                  player1Name,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: gameState.currentPlayer == 'X'
                        ? Colors.blue
                        : Colors.grey,
                  ),
                ),
                const Text(
                  'X',
                  style: TextStyle(fontSize: 24, color: Colors.blue),
                ),
                if (gameState.timeMode != TimeMode.classic)
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: gameState.currentPlayer == 'X'
                          ? Colors.blue
                          : Colors.grey,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      formatTime(gameState.player1TimeLeft),
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
              ],
            ),
            Column(
              children: [
                const Text(
                  'VS',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                if (gameState.timeMode != TimeMode.classic)
                  Text(
                    getTimeModeText(gameState.timeMode),
                    style: const TextStyle(fontSize: 14, color: Colors.grey),
                  ),
              ],
            ),
            Column(
              children: [
                Text(
                  player2Name,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: gameState.currentPlayer == 'O'
                        ? Colors.red
                        : Colors.grey,
                  ),
                ),
                const Text(
                  'O',
                  style: TextStyle(fontSize: 24, color: Colors.red),
                ),
                if (gameState.timeMode != TimeMode.classic &&
                    gameState.mode == GameMode.vsFriend)
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: gameState.currentPlayer == 'O'
                          ? Colors.red
                          : Colors.grey,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      formatTime(gameState.player2TimeLeft),
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
              ],
            ),
          ],
        ),
        if (gameState.timeMode != TimeMode.classic &&
            gameState.status == GameStatus.playing)
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () {
                    if (gameState.isTimerActive) {
                      context.read<GameCubit>().pauseTimer();
                    } else {
                      context.read<GameCubit>().resumeTimer();
                    }
                  },
                  icon: Icon(
                    gameState.isTimerActive ? Icons.pause : Icons.play_arrow,
                    color: Colors.blue,
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }

  Widget buildGameBoard(
    final BuildContext context,
    final GameState gameState,
  ) => AspectRatio(
    aspectRatio: 1,
    child: Container(
      decoration: BoxDecoration(border: Border.all(width: 2)),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
        ),
        itemCount: 9,
        itemBuilder: (final context, final index) => GestureDetector(
          onTap: () => context.read<GameCubit>().makeMove(index),
          child: Container(
            decoration: BoxDecoration(border: Border.all()),
            child: Center(
              child: Text(
                gameState.board[index],
                style: TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                  color: gameState.board[index] == 'X'
                      ? Colors.blue
                      : Colors.red,
                ),
              ),
            ),
          ),
        ),
      ),
    ),
  );

  Widget buildGameStatus(
    final GameState gameState,
    final SettingsState settingsState,
  ) {
    String statusText;
    switch (gameState.status) {
      case GameStatus.playing:
        if (gameState.isAITurn) {
          statusText = 'AI is thinking...';
        } else {
          final currentPlayerName = gameState.currentPlayer == 'X'
              ? settingsState.player1Name
              : (gameState.mode == GameMode.vsAI
                    ? 'AI'
                    : settingsState.player2Name);
          statusText = '$currentPlayerName\'s turn';
        }
        break;
      case GameStatus.xWins:
        statusText = '${settingsState.player1Name} Wins!';
        break;
      case GameStatus.oWins:
        final winnerName = gameState.mode == GameMode.vsAI
            ? 'AI Wins!'
            : '${settingsState.player2Name} Wins!';
        statusText = winnerName;
        break;
      case GameStatus.draw:
        statusText = 'It\'s a Draw!';
        break;
    }

    return Text(
      statusText,
      style: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: gameState.status == GameStatus.playing
            ? Colors.blue
            : Colors.green,
      ),
    );
  }

  String getDifficultyText(final AIDifficulty difficulty) {
    switch (difficulty) {
      case AIDifficulty.easy:
        return 'Easy';
      case AIDifficulty.medium:
        return 'Medium';
      case AIDifficulty.hard:
        return 'Hard';
    }
  }

  String formatTime(final int seconds) {
    final minutes = seconds ~/ 60;
    final remainingSeconds = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  String getTimeModeText(final TimeMode mode) {
    switch (mode) {
      case TimeMode.classic:
        return 'Classic';
      case TimeMode.rapid5:
        return 'Rapid 5min';
      case TimeMode.rapid10:
        return 'Rapid 10min';
      case TimeMode.rapid15:
        return 'Rapid 15min';
      case TimeMode.rapid30:
        return 'Rapid 30min';
      case TimeMode.blitz:
        return 'Blitz 3min';
      case TimeMode.bullet:
        return 'Bullet 1min';
    }
  }
}
