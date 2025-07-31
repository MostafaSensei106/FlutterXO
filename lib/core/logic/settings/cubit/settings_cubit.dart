import 'package:flutter_bloc/flutter_bloc.dart' show Cubit;
import 'package:shared_preferences/shared_preferences.dart'
    show SharedPreferences;

import '../../../config/const/app_enums.dart' show AIDifficulty, TimeMode;
import 'settings_state.dart' show SettingsState;

class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit()
    : super(
        SettingsState(
          player1Name: 'Player 1',
          player2Name: 'Player 2',
          aiDifficulty: AIDifficulty.medium,
          timeMode: TimeMode.classic,
        ),
      );

  void updatePlayer1Name(final String name) {
    emit(state.copyWith(player1Name: name));
    _saveSettings();
  }

  void updatePlayer2Name(final String name) {
    emit(state.copyWith(player2Name: name));
    _saveSettings();
  }

  void updateAIDifficulty(final AIDifficulty difficulty) {
    emit(state.copyWith(aiDifficulty: difficulty));
    _saveSettings();
  }

  void updateTimeMode(final TimeMode timeMode) {
    emit(state.copyWith(timeMode: timeMode));
    _saveSettings();
  }

  void loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    final player1Name = prefs.getString('player1Name') ?? 'Player 1';
    final player2Name = prefs.getString('player2Name') ?? 'Player 2';
    final difficultyIndex = prefs.getInt('aiDifficulty') ?? 1;
    final timeModeIndex = prefs.getInt('timeMode') ?? 0;
    final aiDifficulty = AIDifficulty.values[difficultyIndex];
    final timeMode = TimeMode.values[timeModeIndex];

    emit(
      SettingsState(
        player1Name: player1Name,
        player2Name: player2Name,
        aiDifficulty: aiDifficulty,
        timeMode: timeMode,
      ),
    );
  }

  void _saveSettings() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('player1Name', state.player1Name);
    await prefs.setString('player2Name', state.player2Name);
    await prefs.setInt('aiDifficulty', state.aiDifficulty.index);
    await prefs.setInt('timeMode', state.timeMode.index);
  }
}
