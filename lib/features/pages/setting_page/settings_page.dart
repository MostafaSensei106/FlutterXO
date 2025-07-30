lass SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: BlocBuilder<SettingsCubit, SettingsState>(
        builder: (context, state) {
          return Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Player Names',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 20),
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Player 1 Name (X)',
                    border: OutlineInputBorder(),
                  ),
                  controller: TextEditingController(text: state.player1Name),
                  onChanged: (value) {
                    context.read<SettingsCubit>().updatePlayer1Name(value);
                  },
                ),
                SizedBox(height: 15),
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Player 2 Name (O)',
                    border: OutlineInputBorder(),
                  ),
                  controller: TextEditingController(text: state.player2Name),
                  onChanged: (value) {
                    context.read<SettingsCubit>().updatePlayer2Name(value);
                  },
                ),
                SizedBox(height: 30),
                Text(
                  'AI Difficulty',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 20),
                Column(
                  children: AIDifficulty.values.map((difficulty) {
                    return RadioListTile<AIDifficulty>(
                      title: Text(_getDifficultyDescription(difficulty)),
                      value: difficulty,
                      groupValue: state.aiDifficulty,
                      onChanged: (AIDifficulty? value) {
                        if (value != null) {
                          context.read<SettingsCubit>().updateAIDifficulty(value);
                        }
                      },
                    );
                  }).toList(),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  String _getDifficultyDescription(AIDifficulty difficulty) {
    switch (difficulty) {
      case AIDifficulty.easy:
        return 'Easy - Random moves';
      case AIDifficulty.medium:
        return 'Medium - Sometimes smart';
      case AIDifficulty.hard:
        return 'Hard - Always optimal';
    }
  }
}