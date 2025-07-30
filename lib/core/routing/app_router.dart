import 'package:flutter/cupertino.dart' show CupertinoPageRoute;
import 'package:flutter/material.dart'
    show
        GlobalKey,
        NavigatorState,
        ColorScheme,
        RouteSettings,
        Route,
        Widget,
        Theme;

import '../../features/onboarding_page/ui/page/onboarding_page.dart'
    show OnboardingPage;
import '../error/no_routes.dart' show NoRoutes;
import 'routes.dart' show Routes;

class AppRouter {
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  static ColorScheme get theme {
    final context = navigatorKey.currentContext;
    if (context == null) {
      throw Exception('Navigator context is not available');
    }
    return Theme.of(context).colorScheme;
  }

  Route<dynamic> generateRoute(final RouteSettings settings) {
    Widget page;
    switch (settings.name) {
      case Routes.onBoarding:
        page = const OnboardingPage();
        break;
      default:
        page = const NoRoutes();
    }
    return CupertinoPageRoute(builder: (_) => page);
  }
}
