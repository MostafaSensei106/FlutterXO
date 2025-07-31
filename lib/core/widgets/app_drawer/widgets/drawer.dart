import 'package:flutter/material.dart'
    show Icons, Theme, Drawer, ThemeMode, Switch;
import 'package:flutter/widgets.dart'
    show
        StatelessWidget,
        WidgetStateProperty,
        BuildContext,
        Icon,
        WidgetState,
        Widget,
        ContinuousRectangleBorder,
        SizedBox,
        BorderRadius,
        Radius,
        EdgeInsets,
        Column,
        AnimatedSize,
        ListView,
        ValueKey,
        Navigator;
import 'package:flutter_bloc/flutter_bloc.dart' show BlocBuilder, ReadContext;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../config/const/app_enums.dart' show ListTileGroupType;
import '../../../config/const/sensei_const.dart' show SenseiConst;
import '../../../config/theme/colors/logic/cubit/theme_cubit.dart'
    show ThemeCubit;
import '../../../config/theme/colors/logic/cubit/theme_state.dart'
    show ThemeState;
import '../../../config/theme/colors/logic/helper/theme_toggle_helper.dart'
    show toggleTheme;
import '../../../routing/routes.dart' show Routes;
import '../../../services/url_services/url_services.dart' show launchURL;
import '../../list_tile_components/list_tile_icon_component.dart'
    show ListTileIconComponent;
import 'drawer_header.dart' show DrawerHeaderWidget;

class SettingsDrawer extends StatelessWidget {
  const SettingsDrawer({super.key});

  /// Creates an [Icon] that is conditionally styled based on the presence of
  /// [WidgetState.selected] in the given [Set] of [WidgetState]s.
  ///
  /// If the set contains [WidgetState.selected], the icon is an [Icons.check]
  /// with the primary color of the current [Theme].  Otherwise, the icon is an
  /// [Icons.close].
  WidgetStateProperty<Icon> thumbIcon(final BuildContext context) =>
      WidgetStateProperty.resolveWith<Icon>((final Set<WidgetState> states) {
        if (states.contains(WidgetState.selected)) {
          return Icon(
            Icons.check,
            color: Theme.of(context).colorScheme.primary,
          );
        }
        return const Icon(Icons.close);
      });

  @override
  /// Builds the main drawer widget for the application.
  ///
  /// This method returns a [SizedBox] containing a [Drawer] widget with a
  /// specified shape and border radius. The drawer contains a [ListView] that
  /// includes a fixed-size [DrawerHeaderWidget] and a padded [AnimatedSize]
  /// widget wrapping a [Column] of various drawer options including theme
  /// switch, mode switch, offline/online toggles, database actions, usage
  /// instructions, reporting, logging, and developer information.
  ///
  /// The width of the drawer scales with the screen size, utilizing 90% of
  /// the screen width. The padding and radius values are defined in the
  /// [SenseiConst] class to ensure consistency with the app's theme.
  Widget build(final BuildContext context) => SizedBox(
    width: 0.90.sw,
    child: Drawer(
      backgroundColor: Theme.of(context).colorScheme.surface,
      shape: const ContinuousRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(SenseiConst.outBorderRadius),
        ),
      ),
      child: ListView(
        padding: const EdgeInsets.only(
          left: SenseiConst.padding,
          right: SenseiConst.padding,
          bottom: SenseiConst.padding,
        ),
        children: const [
          SizedBox(width: double.infinity, child: DrawerHeaderWidget()),
          AnimatedSize(duration: Duration(milliseconds: 250), child: Column()),
        ],
      ),
    ),
  );

  Widget _buildThemeSwitch(final BuildContext context) =>
      BlocBuilder<ThemeCubit, ThemeState>(
        buildWhen: (final previous, final current) =>
            previous.themeMode != current.themeMode,
        builder: (final context, final state) => ListTileIconComponent(
          groupType: state.themeMode != ThemeMode.system
              ? ListTileGroupType.top
              : ListTileGroupType.single,
          iconLeading: Icons.brightness_auto_outlined,
          title: AppLocalizations.of(context)!.systemTheme,
          subtitle: AppLocalizations.of(context)!.followSystemTheme,
          trailing: Switch(
            thumbIcon: thumbIcon(context),
            value: state.themeMode == ThemeMode.system,
            onChanged: (final bool value) {
              toggleTheme(isSystemTheme: value, context: context);
            },
          ),
          onTap: () {
            final newValue = !(state.themeMode == ThemeMode.system);
            toggleTheme(isSystemTheme: newValue, context: context);
          },
        ),
      );

  Widget _buildModeSwitch(final BuildContext context) =>
      BlocBuilder<ThemeCubit, ThemeState>(
        buildWhen: (final previous, final current) =>
            previous.isDark != current.isDark ||
            previous.themeMode != current.themeMode,
        builder: (final context, final state) =>
            state.themeMode == ThemeMode.system
            ? const SizedBox.shrink()
            : ListTileIconComponent(
                key: ValueKey(state.isDark),
                groupType: ListTileGroupType.bottom,
                iconLeading: state.isDark
                    ? Icons.light_mode_outlined
                    : Icons.dark_mode_outlined,
                title: state.isDark
                    ? AppLocalizations.of(context)!.darkTheme
                    : AppLocalizations.of(context)!.lightTheme,
                subtitle: state.isDark
                    ? AppLocalizations.of(context)!.switchToLightTheme
                    : AppLocalizations.of(context)!.switchToDarkTheme,
                trailing: Switch(
                  thumbIcon: thumbIcon(context),
                  value: state.isDark,
                  onChanged: (final bool value) {
                    context.read<ThemeCubit>().toggleTheme(isDark: value);
                  },
                ),
                onTap: () {
                  context.read<ThemeCubit>().toggleTheme(isDark: !state.isDark);
                },
              ),
      );

  Widget _buildReadMe(final BuildContext context) => ListTileIconComponent(
    groupType: ListTileGroupType.top,
    iconLeading: Icons.description_outlined,
    title: AppLocalizations.of(context)!.readMe,
    subtitle: AppLocalizations.of(context)!.readMeMassage,
    trailing: Icon(
      Icons.link_rounded,
      color: Theme.of(context).colorScheme.onSurface.withAlpha(0x80),
    ),
    onTap: () {
      Navigator.pop(context);
      launchURL(SenseiConst.devReadMeLink);
    },
  );

  Widget _buildLetestUpdate(final BuildContext context) =>
      ListTileIconComponent(
        groupType: ListTileGroupType.middle,
        iconLeading: Icons.update_outlined,
        title: AppLocalizations.of(context)!.letastUpdate,
        subtitle: AppLocalizations.of(context)!.letestUpdateMassage,
        trailing: Icon(
          Icons.link_rounded,
          color: Theme.of(context).colorScheme.onSurface.withAlpha(0x80),
        ),
        onTap: () {
          Navigator.pop(context);

          launchURL(SenseiConst.devReleaseAppLink);
        },
      );

  Widget _buildGithubToken(final BuildContext context) => ListTileIconComponent(
    groupType: ListTileGroupType.middle,
    iconLeading: Icons.live_help_outlined,
    title: AppLocalizations.of(context)!.githubTiket,
    subtitle: AppLocalizations.of(context)!.githubTiketMassage,
    trailing: Icon(
      Icons.link_rounded,
      color: Theme.of(context).colorScheme.onSurface.withAlpha(0x80),
    ),
    onTap: () {
      Navigator.pop(context);

      launchURL(SenseiConst.devGitHubIssuesLink);
    },
  );

  Widget _buildTelegramChannel(final BuildContext context) =>
      ListTileIconComponent(
        groupType: ListTileGroupType.bottom,
        iconLeading: Icons.telegram_rounded,
        title: AppLocalizations.of(context)!.telegramChannel,
        subtitle: AppLocalizations.of(context)!.telegramChannelMassage,
        trailing: Icon(
          Icons.link_rounded,
          color: Theme.of(context).colorScheme.onSurface.withAlpha(0x80),
        ),
        onTap: () {
          Navigator.pop(context);

          launchURL(SenseiConst.tadamonTelegramLink);
        },
      );

  Widget _buildDeveloper(final BuildContext context) => ListTileIconComponent(
    groupType: ListTileGroupType.top,
    iconLeading: Icons.verified_outlined,
    title: AppLocalizations.of(context)!.developer,
    subtitle: AppLocalizations.of(context)!.mostafaMahmoud,
    trailing: Icon(
      Icons.arrow_forward_ios_rounded,
      color: Theme.of(context).colorScheme.onSurface.withAlpha(0x80),
    ),
    onTap: () => {
      Navigator.pop(context),
      Navigator.pushNamed(context, Routes.chatWithDev),
    },
  );

  Widget _buildAbout(final BuildContext context) => ListTileIconComponent(
    groupType: ListTileGroupType.bottom,
    iconLeading: Icons.info_outline,
    trailing: Icon(
      Icons.arrow_forward_ios_rounded,
      color: Theme.of(context).colorScheme.onSurface.withAlpha(0x80),
    ),
    title: AppLocalizations.of(context)!.about,
    subtitle: AppLocalizations.of(context)!.about,
    onTap: () => {
      Navigator.pop(context),
      Navigator.pushNamed(context, Routes.appInfo),
    },
  );
}
