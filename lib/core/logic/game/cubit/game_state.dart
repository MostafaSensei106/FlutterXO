// ignore_for_file: prefer_final_parameters

import '../../../config/const/app_enums.dart'
    show GameStatus, GameMode, AIDifficulty;

class GameState {
  GameState({
    required this.board,
    required this.currentPlayer,
    required this.status,
    required this.mode,
    required this.aiDifficulty,
    required this.isAITurn,
  });
  final List<String> board;
  final String currentPlayer;
  final GameStatus status;
  final GameMode mode;
  final AIDifficulty aiDifficulty;
  final bool isAITurn;
  GameState copyWith({
    List<String>? board,
    String? currentPlayer,
    GameStatus? status,
    GameMode? mode,
    AIDifficulty? aiDifficulty,
    bool? isAITurn,
  }) => GameState(
    board: board ?? this.board,
    currentPlayer: currentPlayer ?? this.currentPlayer,
    status: status ?? this.status,
    mode: mode ?? this.mode,
    aiDifficulty: aiDifficulty ?? this.aiDifficulty,
    isAITurn: isAITurn ?? this.isAITurn,
  );
}
