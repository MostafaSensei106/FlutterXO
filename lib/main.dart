import 'package:flutter/material.dart' show runApp;
import 'package:flutter_bloc/flutter_bloc.dart' show BlocProvider;

import 'core/config/theme/colors/logic/cubit/theme_cubit.dart' show ThemeCubit;
import 'core/config/theme/colors/logic/cubit/theme_shared_preferences.dart'
    show ThemeSharedPreferences;
import 'core/routing/app_router.dart';
import 'xo_app.dart' show XOApp;

void main() {
  final themeCubit = ThemeCubit(
    themeSharedPreferences: ThemeSharedPreferences(),
  );

  runApp(BlocProvider.value(value: themeCubit, child: XOApp(AppRouter())));
}
