// ignore_for_file: prefer_final_parameters

import '../../../config/const/app_enums.dart' show AIDifficulty, TimeMode;

class SettingsState {
  SettingsState({
    required this.player1Name,
    required this.player2Name,
    required this.aiDifficulty,
    required this.timeMode,
  });
  final String player1Name;
  final String player2Name;
  final AIDifficulty aiDifficulty;
  final TimeMode timeMode;

  SettingsState copyWith({
    String? player1Name,
    String? player2Name,
    AIDifficulty? aiDifficulty,
    TimeMode? timeMode,
  }) => SettingsState(
    player1Name: player1Name ?? this.player1Name,
    player2Name: player2Name ?? this.player2Name,
    aiDifficulty: aiDifficulty ?? this.aiDifficulty,
    timeMode: timeMode ?? this.timeMode,
  );
}
