import 'package:flutter/material.dart';

class GameScreen extends StatelessWidget {

  const GameScreen({required this.mode, super.key});
  final GameMode mode;

  @override
  Widget build(final BuildContext context) => Scaffold(
      appBar: AppBar(
        title: Text(mode == GameMode.vsAI ? 'vs AI' : 'vs Friend'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              context.read<GameCubit>().startNewGame(mode: mode);
            },
          ),
        ],
      ),
      body: BlocBuilder<GameCubit, GameState>(
        builder: (final context, final gameState) => BlocBuilder<SettingsState, SettingsState>(
            bloc: context.read<SettingsCubit>(),
            builder: (final context, final settingsState) {
              // Start new game when screen loads
              if (gameState.mode != mode) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  context.read<GameCubit>().startNewGame(
                    mode: mode,
                    difficulty: settingsState.aiDifficulty,
                  );
                });
              }

              return Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    _buildPlayerInfo(gameState, settingsState),
                    const SizedBox(height: 20),
                    _buildGameBoard(context, gameState),
                    const SizedBox(height: 20),
                    _buildGameStatus(gameState, settingsState),
                    const SizedBox(height: 20),
                    if (gameState.status != GameStatus.playing)
                      ElevatedButton(
                        onPressed: () {
                          context.read<GameCubit>().startNewGame(
                            mode: mode,
                            difficulty: settingsState.aiDifficulty,
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

  Widget _buildPlayerInfo(final GameState gameState, final SettingsState settingsState) {
    final String player1Name = settingsState.player1Name;
    final String player2Name = gameState.mode == GameMode.vsAI
        ? 'AI (${_getDifficultyText(settingsState.aiDifficulty)})'
        : settingsState.player2Name;

    return Row(
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
            const Text('X', style: TextStyle(fontSize: 24, color: Colors.blue)),
          ],
        ),
        const Text('VS', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
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
            const Text('O', style: TextStyle(fontSize: 24, color: Colors.red)),
          ],
        ),
      ],
    );
  }

  Widget _buildGameBoard(final BuildContext context, final GameState gameState) => AspectRatio(
      aspectRatio: 1,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(width: 2),
        ),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
          ),
          itemCount: 9,
          itemBuilder: (final context, final index) => GestureDetector(
              onTap: () => context.read<GameCubit>().makeMove(index),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(),
                ),
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

  Widget _buildGameStatus(final GameState gameState, final SettingsState settingsState) {
    String statusText;
    switch (gameState.status) {
      case GameStatus.playing:
        if (gameState.isAITurn) {
          statusText = 'AI is thinking...';
        } else {
          final String currentPlayerName = gameState.currentPlayer == 'X'
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

  String _getDifficultyText(final AIDifficulty difficulty) {
    switch (difficulty) {
      case AIDifficulty.easy:
        return 'Easy';
      case AIDifficulty.medium:
        return 'Medium';
      case AIDifficulty.hard:
        return 'Hard';
    }
  }
}
