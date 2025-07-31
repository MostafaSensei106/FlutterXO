import 'dart:async' show Timer;
import 'dart:math' show Random;

import 'package:flutter_bloc/flutter_bloc.dart' show Cubit;

import '../../../config/const/app_enums.dart'
    show GameStatus, GameMode, TimeMode, AIDifficulty;
import 'game_state.dart' show GameState;

class GameCubit extends Cubit<GameState> {
  GameCubit()
    : super(
        GameState(
          board: List.filled(9, ''),
          currentPlayer: 'X',
          status: GameStatus.playing,
          mode: GameMode.vsAI,
          aiDifficulty: AIDifficulty.medium,
          isAITurn: false,
          timeMode: TimeMode.classic,
          player1TimeLeft: 0,
          player2TimeLeft: 0,
          isTimerActive: false,
        ),
      );

  final Random _random = Random();
  Timer? _gameTimer;

  @override
  Future<void> close() {
    _gameTimer?.cancel();
    return super.close();
  }

  int _getTimeForMode(final TimeMode mode) {
    switch (mode) {
      case TimeMode.classic:
        return 0;
      case TimeMode.rapid5:
        return 5 * 60;
      case TimeMode.rapid10:
        return 10 * 60;
      case TimeMode.rapid15:
        return 15 * 60;
      case TimeMode.rapid30:
        return 30 * 60;
      case TimeMode.blitz:
        return 3 * 60;
      case TimeMode.bullet:
        return 60;
    }
  }

  void startNewGame({
    final GameMode? mode,
    final AIDifficulty? difficulty,
    final TimeMode? timeMode,
  }) {
    emit(
      state.copyWith(
        board: List.filled(9, ''),
        currentPlayer: 'X',
        status: GameStatus.playing,
        mode: mode ?? state.mode,
        aiDifficulty: difficulty ?? state.aiDifficulty,
        isAITurn: false,
        player1TimeLeft: _getTimeForMode(timeMode ?? state.timeMode),
        player2TimeLeft: _getTimeForMode(timeMode ?? state.timeMode),
        isTimerActive: false,
      ),
    );
  }

  void _startTimer() {
    _gameTimer?.cancel();
    _gameTimer = Timer.periodic(const Duration(seconds: 1), (final timer) {
      if (state.status != GameStatus.playing || !state.isTimerActive) {
        timer.cancel();
        return;
      }

      if (state.currentPlayer == 'X' && !state.isAITurn) {
        final newTime = state.player1TimeLeft - 1;
        if (newTime <= 0) {
          emit(
            state.copyWith(
              player1TimeLeft: 0,
              status: GameStatus.oWins,
              isTimerActive: false,
            ),
          );
          timer.cancel();
        } else {
          emit(state.copyWith(player1TimeLeft: newTime));
        }
      } else if (state.currentPlayer == 'O' &&
          state.mode == GameMode.vsFriend) {
        final newTime = state.player2TimeLeft - 1;
        if (newTime <= 0) {
          emit(
            state.copyWith(
              player2TimeLeft: 0,
              status: GameStatus.xWins,
              isTimerActive: false,
            ),
          );
          timer.cancel();
        } else {
          emit(state.copyWith(player2TimeLeft: newTime));
        }
      }
    });
  }

  void pauseTimer() {
    emit(state.copyWith(isTimerActive: false));
  }

  void resumeTimer() {
    if (state.timeMode != TimeMode.classic &&
        state.status == GameStatus.playing) {
      emit(state.copyWith(isTimerActive: true));
      _startTimer();
    }
  }

  void makeMove(final int index) {
    if (state.board[index] != '' ||
        state.status != GameStatus.playing ||
        state.isAITurn) {
      return;
    }

    final newBoard = List<String>.from(state.board);
    newBoard[index] = state.currentPlayer;

    final newStatus = _checkGameStatus(newBoard);
    final nextPlayer = state.currentPlayer == 'X' ? 'O' : 'X';

    emit(
      state.copyWith(
        board: newBoard,
        currentPlayer: nextPlayer,
        status: newStatus,
        isAITurn:
            state.mode == GameMode.vsAI &&
            nextPlayer == 'O' &&
            newStatus == GameStatus.playing,
      ),
    );

    // Make AI move if it's AI's turn
    if (state.isAITurn && state.status == GameStatus.playing) {
      Future.delayed(const Duration(milliseconds: 500), () {
        _makeAIMove();
      });
    }
  }

  void _makeAIMove() {
    if (state.status != GameStatus.playing || !state.isAITurn) {
      return;
    }

    final aiMove = _getAIMove();
    if (aiMove != -1) {
      final newBoard = List<String>.from(state.board);
      newBoard[aiMove] = 'O';

      final newStatus = _checkGameStatus(newBoard);

      emit(
        state.copyWith(
          board: newBoard,
          currentPlayer: 'X',
          status: newStatus,
          isAITurn: false,
        ),
      );
    }
  }

  int _getAIMove() {
    switch (state.aiDifficulty) {
      case AIDifficulty.easy:
        return _getRandomMove();
      case AIDifficulty.medium:
        return _getMediumMove();
      case AIDifficulty.hard:
        return _getHardMove();
    }
  }

  int _getRandomMove() {
    final availableMoves = <int>[];
    for (var i = 0; i < 9; i++) {
      if (state.board[i] == '') {
        availableMoves.add(i);
      }
    }
    return availableMoves.isEmpty
        ? -1
        : availableMoves[_random.nextInt(availableMoves.length)];
  }

  int _getMediumMove() {
    // 70% chance to make smart move, 30% random
    if (_random.nextDouble() < 0.7) {
      return _getHardMove();
    } else {
      return _getRandomMove();
    }
  }

  int _getHardMove() {
    // Check for winning move
    for (var i = 0; i < 9; i++) {
      if (state.board[i] == '') {
        final testBoard = List<String>.from(state.board);
        testBoard[i] = 'O';
        if (_checkWinner(testBoard) == 'O') {
          return i;
        }
      }
    }

    // Block player's winning move
    for (var i = 0; i < 9; i++) {
      if (state.board[i] == '') {
        final testBoard = List<String>.from(state.board);
        testBoard[i] = 'X';
        if (_checkWinner(testBoard) == 'X') {
          return i;
        }
      }
    }

    // Take center if available
    if (state.board[4] == '') {
      return 4;
    }

    // Take corners
    final corners = <int>[0, 2, 6, 8];
    for (var corner in corners) {
      if (state.board[corner] == '') {
        return corner;
      }
    }

    // Take any available move
    return _getRandomMove();
  }

  GameStatus _checkGameStatus(final List<String> board) {
    final winner = _checkWinner(board);
    if (winner == 'X') {
      return GameStatus.xWins;
    }
    if (winner == 'O') {
      return GameStatus.oWins;
    }
    if (board.every((final cell) => cell != '')) {
      return GameStatus.draw;
    }
    return GameStatus.playing;
  }

  String? _checkWinner(final List<String> board) {
    const winningCombinations = <List<int>>[
      [0, 1, 2], [3, 4, 5], [6, 7, 8], // Rows
      [0, 3, 6], [1, 4, 7], [2, 5, 8], // Columns
      [0, 4, 8], [2, 4, 6], // Diagonals
    ];

    for (var combination in winningCombinations) {
      if (board[combination[0]] != '' &&
          board[combination[0]] == board[combination[1]] &&
          board[combination[1]] == board[combination[2]]) {
        return board[combination[0]];
      }
    }
    return null;
  }
}
