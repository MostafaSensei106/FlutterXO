import 'package:flutter/material.dart'
    show
        BuildContext,
        Widget,
        StatelessWidget,
        MaterialApp,
        Size,
        Locale,
        SafeArea;
import 'package:flutter_bloc/flutter_bloc.dart'
    show BlocBuilder, BlocProvider, MultiBlocProvider;
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'core/config/theme/colors/dark_theme.dart' show darkTheme;
import 'core/config/theme/colors/light_theme.dart' show lightTheme;
import 'core/config/theme/colors/logic/cubit/theme_cubit.dart' show ThemeCubit;
import 'core/config/theme/colors/logic/cubit/theme_shared_preferences.dart';
import 'core/config/theme/colors/logic/cubit/theme_state.dart' show ThemeState;
import 'core/logic/game/cubit/game_cubit.dart';
import 'core/logic/settings/cubit/settings_cubit.dart';
import 'core/routing/app_router.dart' show AppRouter;
import 'core/routing/routes.dart' show Routes;
import 'l10n/app_localizations.dart' show AppLocalizations;

class XOApp extends StatelessWidget {
  // ignore: avoid_unused_constructor_parameters, prefer_final_parameters
  XOApp(AppRouter appRouter, {super.key});
  final AppRouter appRouter = AppRouter();

  @override
  // ignore: prefer_final_parameters
  Widget build(BuildContext context) => ScreenUtilInit(
    designSize: const Size(375, 812),
    minTextAdapt: true,
    child: MultiBlocProvider(
      providers: [
        BlocProvider(create: (final context) => GameCubit()),
        BlocProvider(
          create: (final context) => SettingsCubit()..loadSettings(),
        ),
        BlocProvider(
          create: (final context) =>
              ThemeCubit(themeSharedPreferences: ThemeSharedPreferences())
                ..initializeTheme(),
        ),
      ],
      child: BlocBuilder<ThemeCubit, ThemeState>(
        builder: (final context, final themeState) => MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'XO App',
          theme: lightTheme,
          darkTheme: darkTheme,
          navigatorKey: AppRouter.navigatorKey,
          themeMode: themeState.themeMode,
          initialRoute: Routes.onBoarding,
          onGenerateRoute: appRouter.generateRoute,
          supportedLocales: const [
            Locale('ar', 'EG'), // Arabic
            Locale('en', 'UK'), // English
            Locale('fr', 'FR'), // French
            Locale('es', 'ES'), // Spanish
            Locale('de', 'DE'), // German
            Locale('zh', 'CN'), // Chinese
            Locale('ja', 'JP'), // Japanese
            Locale('ru', 'RU'), // Russian
          ],
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
          ],
          localeListResolutionCallback:
              (final locales, final supportedLocales) => locales?.firstWhere(
                (final locale) => supportedLocales.contains(locale),
                orElse: () => const Locale('en', 'UK'),
              ),
          builder: (final context, final child) =>
              SafeArea(top: false, left: false, right: false, child: child!),
        ),
      ),
    ),
  );
}
