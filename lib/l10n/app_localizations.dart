import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en'),
  ];

  /// App name
  ///
  /// In en, this message translates to:
  /// **'Tadamon'**
  String get appName;

  /// App description
  ///
  /// In en, this message translates to:
  /// **'O Allah, have mercy on our brothers, steady their feet, grant them victory, and honor those who support them, and humiliate by Your power those who abandoned them.'**
  String get appDescription;

  /// Tadamon app error
  ///
  /// In en, this message translates to:
  /// **'An error occurred'**
  String get errorHandle;

  /// Page not found
  ///
  /// In en, this message translates to:
  /// **'Page not found'**
  String get noPage;

  /// Page not found
  ///
  /// In en, this message translates to:
  /// **'Page not found'**
  String get noRoutes;

  /// Back button
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get back;

  /// Main app title
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// Search button
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get search;

  /// Logs page
  ///
  /// In en, this message translates to:
  /// **'Logs'**
  String get logs;

  /// Scan barcode button
  ///
  /// In en, this message translates to:
  /// **'Scan Barcode'**
  String get scanBarcode;

  /// Image analysis
  ///
  /// In en, this message translates to:
  /// **'Image Analysis'**
  String get imageAnalysis;

  /// Text editing
  ///
  /// In en, this message translates to:
  /// **'Edit Text'**
  String get editText;

  /// Palestine map
  ///
  /// In en, this message translates to:
  /// **'Palestine Map'**
  String get palatineMap;

  /// Donate to Gaza button
  ///
  /// In en, this message translates to:
  /// **'Donate to Gaza'**
  String get donate;

  /// Reviewed products count
  ///
  /// In en, this message translates to:
  /// **'Reviewed Products'**
  String get scanedProducts;

  /// Supported products count
  ///
  /// In en, this message translates to:
  /// **'Supported Products'**
  String get supportedProducts;

  /// App theme settings
  ///
  /// In en, this message translates to:
  /// **'App Theme'**
  String get systemTheme;

  /// Match system theme
  ///
  /// In en, this message translates to:
  /// **'Follow System Theme'**
  String get followSystemTheme;

  /// Dark mode
  ///
  /// In en, this message translates to:
  /// **'Dark Mode'**
  String get darkTheme;

  /// Light mode
  ///
  /// In en, this message translates to:
  /// **'Light Mode'**
  String get lightTheme;

  /// Switch to dark mode
  ///
  /// In en, this message translates to:
  /// **'Switch to Dark Mode'**
  String get switchToDarkTheme;

  /// Switch to light mode
  ///
  /// In en, this message translates to:
  /// **'Switch to Light Mode'**
  String get switchToLightTheme;

  /// App offline status
  ///
  /// In en, this message translates to:
  /// **'Tadamon Offline'**
  String get appOffLine;

  /// Offline message
  ///
  /// In en, this message translates to:
  /// **'The app is not connected.'**
  String get appOffLineMassageDontRunning;

  /// App running message
  ///
  /// In en, this message translates to:
  /// **'The app is running successfully.'**
  String get appOnLineMassageRunning;

  /// Offline loading
  ///
  /// In en, this message translates to:
  /// **'Please wait...'**
  String get appOflineLoading;

  /// Load product list
  ///
  /// In en, this message translates to:
  /// **'Load Product List'**
  String get enableOnline;

  /// Message when app runs without internet
  ///
  /// In en, this message translates to:
  /// **'Running the app offline.'**
  String get enableOnlineMassage;

  /// Clear logs
  ///
  /// In en, this message translates to:
  /// **'Clear Logs'**
  String get clearLogs;

  /// Clear product logs
  ///
  /// In en, this message translates to:
  /// **'Clearing product logs.'**
  String get clearLogsMassage;

  /// FAQ section
  ///
  /// In en, this message translates to:
  /// **'FAQ'**
  String get howToUse;

  /// How to use the app
  ///
  /// In en, this message translates to:
  /// **'Learn how to use the app.'**
  String get howToUseMassage;

  /// Report a product
  ///
  /// In en, this message translates to:
  /// **'Report Product'**
  String get reportProduct;

  /// Help improve the app
  ///
  /// In en, this message translates to:
  /// **'Help us improve the app.'**
  String get reportProductMassage;

  /// Test label
  ///
  /// In en, this message translates to:
  /// **'Test'**
  String get test;

  /// Product info sheet title
  ///
  /// In en, this message translates to:
  /// **'Product Details'**
  String get sheetTitleProductInfo;

  /// Developer name
  ///
  /// In en, this message translates to:
  /// **'Developer'**
  String get developer;

  /// Full developer name
  ///
  /// In en, this message translates to:
  /// **'Mostafa Mahmoud'**
  String get mostafaMahmoud;

  /// ReadMe button
  ///
  /// In en, this message translates to:
  /// **'ReadMe'**
  String get readMe;

  /// Link to GitHub repo
  ///
  /// In en, this message translates to:
  /// **'Link to the GitHub repository.'**
  String get readMeMassage;

  /// Latest updates
  ///
  /// In en, this message translates to:
  /// **'Latest Updates'**
  String get letastUpdate;

  /// Details of latest update
  ///
  /// In en, this message translates to:
  /// **'See what\'s new and the changelog.'**
  String get letestUpdateMassage;

  /// Create GitHub issue
  ///
  /// In en, this message translates to:
  /// **'GitHub Issue'**
  String get githubTiket;

  /// Report bug or suggest feature
  ///
  /// In en, this message translates to:
  /// **'Report a bug or suggest a new feature.'**
  String get githubTiketMassage;

  /// Telegram channel
  ///
  /// In en, this message translates to:
  /// **'Telegram Channel'**
  String get telegramChannel;

  /// Link to Telegram channel
  ///
  /// In en, this message translates to:
  /// **'Link to the Telegram channel.'**
  String get telegramChannelMassage;

  /// About page
  ///
  /// In en, this message translates to:
  /// **'About the App'**
  String get about;

  /// About Tadamon
  ///
  /// In en, this message translates to:
  /// **'About Tadamon App.'**
  String get aboutTadamon;

  /// Contact developer button
  ///
  /// In en, this message translates to:
  /// **'Message from Developer'**
  String get contactDev;

  /// Developer's message
  ///
  /// In en, this message translates to:
  /// **'No message currently.'**
  String get devMassage;

  /// Thanks from developer
  ///
  /// In en, this message translates to:
  /// **'Thank you for using Tadamon.'**
  String get devThx;

  /// Donate to the developer
  ///
  /// In en, this message translates to:
  /// **'Support the Developer.'**
  String get devDonate;

  /// Ways to contact developer
  ///
  /// In en, this message translates to:
  /// **'Follow me on social media.'**
  String get contactDevMassage;

  /// Close button
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get close;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['ar', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
