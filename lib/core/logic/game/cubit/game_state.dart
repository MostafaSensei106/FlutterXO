// ignore_for_file: prefer_final_parameters

import '../../../config/const/app_enums.dart'
    show GameStatus, GameMode, AIDifficulty, TimeMode;

class GameState {
  GameState({
    required this.board,
    required this.currentPlayer,
    required this.status,
    required this.mode,
    required this.aiDifficulty,
    required this.isAITurn,
    required this.timeMode,
    required this.player1TimeLeft,
    required this.player2TimeLeft,
    required this.isTimerActive,
  });
  final List<String> board;
  final String currentPlayer;
  final GameStatus status;
  final GameMode mode;
  final AIDifficulty aiDifficulty;
  final bool isAITurn;
  final TimeMode timeMode;
  final int player1TimeLeft;
  final int player2TimeLeft;
  final bool isTimerActive;

  GameState copyWith({
    List<String>? board,
    String? currentPlayer,
    GameStatus? status,
    GameMode? mode,
    AIDifficulty? aiDifficulty,
    bool? isAITurn,
    TimeMode? timeMode,
    int? player1TimeLeft,
    int? player2TimeLeft,
    bool? isTimerActive,
  }) => GameState(
    board: board ?? this.board,
    currentPlayer: currentPlayer ?? this.currentPlayer,
    status: status ?? this.status,
    mode: mode ?? this.mode,
    aiDifficulty: aiDifficulty ?? this.aiDifficulty,
    isAITurn: isAITurn ?? this.isAITurn,
    timeMode: timeMode ?? this.timeMode,
    player1TimeLeft: player1TimeLeft ?? this.player1TimeLeft,
    player2TimeLeft: player2TimeLeft ?? this.player2TimeLeft,
    isTimerActive: isTimerActive ?? this.isTimerActive,
  );
}
