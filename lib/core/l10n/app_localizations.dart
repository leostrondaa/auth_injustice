import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_es.dart';
import 'app_localizations_pt.dart';

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
    Locale('en'),
    Locale('es'),
    Locale('pt')
  ];

  /// No description provided for @welcomeTo.
  ///
  /// In en, this message translates to:
  /// **'Welcome To'**
  String get welcomeTo;

  /// No description provided for @whereIf.
  ///
  /// In en, this message translates to:
  /// **'Where IF'**
  String get whereIf;

  /// No description provided for @continueButton.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get continueButton;

  /// No description provided for @joinThe.
  ///
  /// In en, this message translates to:
  /// **'Join the'**
  String get joinThe;

  /// No description provided for @team.
  ///
  /// In en, this message translates to:
  /// **'Team'**
  String get team;

  /// No description provided for @email.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @forgot.
  ///
  /// In en, this message translates to:
  /// **'Forgot your password?'**
  String get forgot;

  /// No description provided for @loginButton.
  ///
  /// In en, this message translates to:
  /// **'Enter'**
  String get loginButton;

  /// No description provided for @dontHaveAccount.
  ///
  /// In en, this message translates to:
  /// **'Don\'t have an account?'**
  String get dontHaveAccount;

  /// No description provided for @signupButton.
  ///
  /// In en, this message translates to:
  /// **'Sign up'**
  String get signupButton;

  /// No description provided for @or.
  ///
  /// In en, this message translates to:
  /// **'or'**
  String get or;

  /// No description provided for @googleButton.
  ///
  /// In en, this message translates to:
  /// **'Sign in with Google'**
  String get googleButton;

  /// No description provided for @whatYour.
  ///
  /// In en, this message translates to:
  /// **'What\'s your'**
  String get whatYour;

  /// No description provided for @createPassword.
  ///
  /// In en, this message translates to:
  /// **'Create a'**
  String get createPassword;

  /// No description provided for @fieldsRequired.
  ///
  /// In en, this message translates to:
  /// **'Please fill in the fields'**
  String get fieldsRequired;

  /// No description provided for @invalidFields.
  ///
  /// In en, this message translates to:
  /// **'Incorrect email or password'**
  String get invalidFields;

  /// No description provided for @authEmailAlreadyInUse.
  ///
  /// In en, this message translates to:
  /// **'This email is already linked to an account.'**
  String get authEmailAlreadyInUse;

  /// No description provided for @authWeakPassword.
  ///
  /// In en, this message translates to:
  /// **'The password does not meet the security requirements.'**
  String get authWeakPassword;

  /// No description provided for @authNetworkError.
  ///
  /// In en, this message translates to:
  /// **'No connection. Check your internet and try again.'**
  String get authNetworkError;

  /// No description provided for @authTooManyRequests.
  ///
  /// In en, this message translates to:
  /// **'Too many attempts. Wait a moment and try again.'**
  String get authTooManyRequests;

  /// No description provided for @authAccountDisabled.
  ///
  /// In en, this message translates to:
  /// **'This account is disabled.'**
  String get authAccountDisabled;

  /// No description provided for @authUnexpectedError.
  ///
  /// In en, this message translates to:
  /// **'Authentication could not be completed.'**
  String get authUnexpectedError;

  /// No description provided for @authUserNotFound.
  ///
  /// In en, this message translates to:
  /// **'Account not found.'**
  String get authUserNotFound;

  /// No description provided for @authGoogleCanceled.
  ///
  /// In en, this message translates to:
  /// **'Google sign-in was canceled.'**
  String get authGoogleCanceled;

  /// No description provided for @emailRequired.
  ///
  /// In en, this message translates to:
  /// **'Please enter a email'**
  String get emailRequired;

  /// No description provided for @invalidEmail.
  ///
  /// In en, this message translates to:
  /// **'Incorrect email'**
  String get invalidEmail;

  /// No description provided for @passwordRequired.
  ///
  /// In en, this message translates to:
  /// **'Please enter a password'**
  String get passwordRequired;

  /// No description provided for @passwordMinLength.
  ///
  /// In en, this message translates to:
  /// **'Password must be at least 8 characters long'**
  String get passwordMinLength;

  /// No description provided for @passwordRequireLowercaseAndUppercase.
  ///
  /// In en, this message translates to:
  /// **'Uppercase and lowercase letters'**
  String get passwordRequireLowercaseAndUppercase;

  /// No description provided for @passwordRequireNumber.
  ///
  /// In en, this message translates to:
  /// **'Include at least one number'**
  String get passwordRequireNumber;

  /// No description provided for @passwordRequireSymbol.
  ///
  /// In en, this message translates to:
  /// **'Include at least one symbol'**
  String get passwordRequireSymbol;

  /// No description provided for @passwordStrengthEmpty.
  ///
  /// In en, this message translates to:
  /// **'Enter a password'**
  String get passwordStrengthEmpty;

  /// No description provided for @passwordStrengthVeryWeak.
  ///
  /// In en, this message translates to:
  /// **'Very weak'**
  String get passwordStrengthVeryWeak;

  /// No description provided for @passwordStrengthWeak.
  ///
  /// In en, this message translates to:
  /// **'Weak'**
  String get passwordStrengthWeak;

  /// No description provided for @passwordStrengthFair.
  ///
  /// In en, this message translates to:
  /// **'Fair'**
  String get passwordStrengthFair;

  /// No description provided for @passwordStrengthGood.
  ///
  /// In en, this message translates to:
  /// **'Good'**
  String get passwordStrengthGood;

  /// No description provided for @passwordStrengthExcellent.
  ///
  /// In en, this message translates to:
  /// **'Excellent'**
  String get passwordStrengthExcellent;

  /// No description provided for @checkEmailTitle.
  ///
  /// In en, this message translates to:
  /// **'Check your email'**
  String get checkEmailTitle;

  /// No description provided for @checkEmailSentTo.
  ///
  /// In en, this message translates to:
  /// **'We sent a link to:'**
  String get checkEmailSentTo;

  /// No description provided for @checkEmailDescription.
  ///
  /// In en, this message translates to:
  /// **'Click the link to continue.'**
  String get checkEmailDescription;

  /// No description provided for @emailConfirmedTitle.
  ///
  /// In en, this message translates to:
  /// **'Email confirmed!'**
  String get emailConfirmedTitle;

  /// No description provided for @emailConfirmedSubtitle.
  ///
  /// In en, this message translates to:
  /// **'All set. Now let\'s continue so you can create your new password.'**
  String get emailConfirmedSubtitle;

  /// No description provided for @accountConfirmedSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Your account has been confirmed. You can now continue.'**
  String get accountConfirmedSubtitle;

  /// No description provided for @eventsTitle.
  ///
  /// In en, this message translates to:
  /// **'Events'**
  String get eventsTitle;

  /// No description provided for @navigationMap.
  ///
  /// In en, this message translates to:
  /// **'Map'**
  String get navigationMap;

  /// No description provided for @navigationEvents.
  ///
  /// In en, this message translates to:
  /// **'Events'**
  String get navigationEvents;

  /// No description provided for @navigationNotifications.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get navigationNotifications;

  /// No description provided for @navigationHours.
  ///
  /// In en, this message translates to:
  /// **'Hours'**
  String get navigationHours;

  /// No description provided for @featuredEvents.
  ///
  /// In en, this message translates to:
  /// **'Featured'**
  String get featuredEvents;

  /// No description provided for @futureEvents.
  ///
  /// In en, this message translates to:
  /// **'Upcoming events'**
  String get futureEvents;

  /// No description provided for @addToPersonalHistory.
  ///
  /// In en, this message translates to:
  /// **'Add to my history'**
  String get addToPersonalHistory;

  /// No description provided for @personalHistoryAdded.
  ///
  /// In en, this message translates to:
  /// **'Saved to my history'**
  String get personalHistoryAdded;

  /// No description provided for @personalRecordUpdating.
  ///
  /// In en, this message translates to:
  /// **'Updating my history...'**
  String get personalRecordUpdating;

  /// No description provided for @personalRecordNotice.
  ///
  /// In en, this message translates to:
  /// **'Personal record. It does not prove attendance or grant official hours.'**
  String get personalRecordNotice;

  /// No description provided for @viewOnMap.
  ///
  /// In en, this message translates to:
  /// **'View on map'**
  String get viewOnMap;

  /// No description provided for @notificationEvent.
  ///
  /// In en, this message translates to:
  /// **'Event'**
  String get notificationEvent;

  /// No description provided for @notificationReminder.
  ///
  /// In en, this message translates to:
  /// **'Reminder'**
  String get notificationReminder;

  /// No description provided for @notificationUpdate.
  ///
  /// In en, this message translates to:
  /// **'Update'**
  String get notificationUpdate;

  /// No description provided for @notificationsTitle.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get notificationsTitle;

  /// No description provided for @notificationsLoadErrorTitle.
  ///
  /// In en, this message translates to:
  /// **'Notifications could not be loaded.'**
  String get notificationsLoadErrorTitle;

  /// No description provided for @notificationsEmptyTitle.
  ///
  /// In en, this message translates to:
  /// **'Nothing here yet.'**
  String get notificationsEmptyTitle;

  /// No description provided for @notificationsLoadErrorMessage.
  ///
  /// In en, this message translates to:
  /// **'Check your connection and try again.'**
  String get notificationsLoadErrorMessage;

  /// No description provided for @notificationsEmptyMessage.
  ///
  /// In en, this message translates to:
  /// **'Important updates will appear here.'**
  String get notificationsEmptyMessage;

  /// No description provided for @notificationTimeNow.
  ///
  /// In en, this message translates to:
  /// **'Now'**
  String get notificationTimeNow;

  /// No description provided for @notificationTimeMinutesAgo.
  ///
  /// In en, this message translates to:
  /// **'{count} min ago'**
  String notificationTimeMinutesAgo(int count);

  /// No description provided for @notificationTimeHoursAgo.
  ///
  /// In en, this message translates to:
  /// **'{count}h ago'**
  String notificationTimeHoursAgo(int count);

  /// No description provided for @notificationTimeYesterday.
  ///
  /// In en, this message translates to:
  /// **'Yesterday'**
  String get notificationTimeYesterday;

  /// No description provided for @notificationTimeDaysAgo.
  ///
  /// In en, this message translates to:
  /// **'{count} days ago'**
  String notificationTimeDaysAgo(int count);

  /// No description provided for @notificationsFilterAll.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get notificationsFilterAll;

  /// No description provided for @notificationsFilterEvents.
  ///
  /// In en, this message translates to:
  /// **'Events'**
  String get notificationsFilterEvents;

  /// No description provided for @notificationsFilterReminders.
  ///
  /// In en, this message translates to:
  /// **'Reminders'**
  String get notificationsFilterReminders;

  /// No description provided for @notificationsFilterUpdates.
  ///
  /// In en, this message translates to:
  /// **'Updates'**
  String get notificationsFilterUpdates;

  /// No description provided for @settingsTitle.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settingsTitle;

  /// No description provided for @settingsAccountSection.
  ///
  /// In en, this message translates to:
  /// **'Account'**
  String get settingsAccountSection;

  /// No description provided for @settingsEditProfile.
  ///
  /// In en, this message translates to:
  /// **'Edit account'**
  String get settingsEditProfile;

  /// No description provided for @settingsDarkMode.
  ///
  /// In en, this message translates to:
  /// **'Dark mode'**
  String get settingsDarkMode;

  /// No description provided for @settingsNotifications.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get settingsNotifications;

  /// No description provided for @settingsLanguage.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get settingsLanguage;

  /// No description provided for @settingsSignOut.
  ///
  /// In en, this message translates to:
  /// **'Sign out'**
  String get settingsSignOut;

  /// No description provided for @settingsSupportSection.
  ///
  /// In en, this message translates to:
  /// **'Support and about'**
  String get settingsSupportSection;

  /// No description provided for @settingsHelpSupport.
  ///
  /// In en, this message translates to:
  /// **'Help and support'**
  String get settingsHelpSupport;

  /// No description provided for @settingsAbout.
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get settingsAbout;

  /// No description provided for @settingsComingSoon.
  ///
  /// In en, this message translates to:
  /// **'This option will be available soon.'**
  String get settingsComingSoon;

  /// No description provided for @settingsSignOutTitle.
  ///
  /// In en, this message translates to:
  /// **'Sign out?'**
  String get settingsSignOutTitle;

  /// No description provided for @settingsSignOutMessage.
  ///
  /// In en, this message translates to:
  /// **'You will need to sign in again to access the app.'**
  String get settingsSignOutMessage;

  /// No description provided for @settingsCancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get settingsCancel;

  /// No description provided for @settingsConfirmSignOut.
  ///
  /// In en, this message translates to:
  /// **'Sign out'**
  String get settingsConfirmSignOut;

  /// No description provided for @settingsSignOutError.
  ///
  /// In en, this message translates to:
  /// **'Unable to sign out.'**
  String get settingsSignOutError;

  /// No description provided for @aboutDescription.
  ///
  /// In en, this message translates to:
  /// **'Events, navigation, and a personal history of your activities.'**
  String get aboutDescription;

  /// No description provided for @aboutVersion.
  ///
  /// In en, this message translates to:
  /// **'Version'**
  String get aboutVersion;

  /// No description provided for @aboutAcademicProject.
  ///
  /// In en, this message translates to:
  /// **'Project developed as an undergraduate final project.'**
  String get aboutAcademicProject;

  /// No description provided for @aboutInstitution.
  ///
  /// In en, this message translates to:
  /// **'Federal Institute of Paraná • Paranaguá Campus'**
  String get aboutInstitution;

  /// No description provided for @aboutTeam.
  ///
  /// In en, this message translates to:
  /// **'Developed by'**
  String get aboutTeam;

  /// No description provided for @aboutDeveloperRole.
  ///
  /// In en, this message translates to:
  /// **'Developer'**
  String get aboutDeveloperRole;

  /// No description provided for @aboutLegalInformation.
  ///
  /// In en, this message translates to:
  /// **'Legal information'**
  String get aboutLegalInformation;

  /// No description provided for @aboutPrivacyPolicy.
  ///
  /// In en, this message translates to:
  /// **'Privacy policy'**
  String get aboutPrivacyPolicy;

  /// No description provided for @aboutTermsOfUse.
  ///
  /// In en, this message translates to:
  /// **'Terms of use'**
  String get aboutTermsOfUse;

  /// No description provided for @helpIntroTitle.
  ///
  /// In en, this message translates to:
  /// **'How can we help?'**
  String get helpIntroTitle;

  /// No description provided for @helpIntroDescription.
  ///
  /// In en, this message translates to:
  /// **'Find quick answers about the main WhereIF features.'**
  String get helpIntroDescription;

  /// No description provided for @helpTopicsTitle.
  ///
  /// In en, this message translates to:
  /// **'Help topics'**
  String get helpTopicsTitle;

  /// No description provided for @helpPersonalHistoryTitle.
  ///
  /// In en, this message translates to:
  /// **'How do I record an activity in my history?'**
  String get helpPersonalHistoryTitle;

  /// No description provided for @helpPersonalHistoryDescription.
  ///
  /// In en, this message translates to:
  /// **'Open the event details and tap Add to my history. This is a personal note and does not prove attendance or replace IFPR validation.'**
  String get helpPersonalHistoryDescription;

  /// No description provided for @helpHoursTitle.
  ///
  /// In en, this message translates to:
  /// **'How are complementary hours calculated?'**
  String get helpHoursTitle;

  /// No description provided for @helpHoursDescription.
  ///
  /// In en, this message translates to:
  /// **'The counter estimates the hours listed for events added to your history. It is a personal reference and does not replace IFPR\'s official records.'**
  String get helpHoursDescription;

  /// No description provided for @helpRecordsTitle.
  ///
  /// In en, this message translates to:
  /// **'How do I delete a record?'**
  String get helpRecordsTitle;

  /// No description provided for @helpRecordsDescription.
  ///
  /// In en, this message translates to:
  /// **'On the hours screen, open the records drawer and swipe a card sideways. Confirm the deletion when the prompt appears.'**
  String get helpRecordsDescription;

  /// No description provided for @helpNotificationsTitle.
  ///
  /// In en, this message translates to:
  /// **'How do notifications work?'**
  String get helpNotificationsTitle;

  /// No description provided for @helpNotificationsDescription.
  ///
  /// In en, this message translates to:
  /// **'Use the filters to find updates, events, and reminders. Tap a notification to expand or collapse its content.'**
  String get helpNotificationsDescription;

  /// No description provided for @helpAccountTitle.
  ///
  /// In en, this message translates to:
  /// **'How do I change my email or password?'**
  String get helpAccountTitle;

  /// No description provided for @helpAccountDescription.
  ///
  /// In en, this message translates to:
  /// **'Open Settings, select Edit account, and choose the information you want to change. Some changes require a security confirmation.'**
  String get helpAccountDescription;

  /// No description provided for @helpContactTitle.
  ///
  /// In en, this message translates to:
  /// **'Still need help?'**
  String get helpContactTitle;

  /// No description provided for @helpContactDescription.
  ///
  /// In en, this message translates to:
  /// **'Contact the team. Tap the address below to copy it.'**
  String get helpContactDescription;

  /// No description provided for @helpCopyEmail.
  ///
  /// In en, this message translates to:
  /// **'Copy email'**
  String get helpCopyEmail;

  /// No description provided for @helpEmailCopied.
  ///
  /// In en, this message translates to:
  /// **'Support email copied.'**
  String get helpEmailCopied;

  /// No description provided for @accountTitle.
  ///
  /// In en, this message translates to:
  /// **'Account'**
  String get accountTitle;

  /// No description provided for @accountSecuritySection.
  ///
  /// In en, this message translates to:
  /// **'Security'**
  String get accountSecuritySection;

  /// No description provided for @accountChangeEmail.
  ///
  /// In en, this message translates to:
  /// **'Change email'**
  String get accountChangeEmail;

  /// No description provided for @accountChangePassword.
  ///
  /// In en, this message translates to:
  /// **'Change password'**
  String get accountChangePassword;

  /// No description provided for @accountDelete.
  ///
  /// In en, this message translates to:
  /// **'Delete account'**
  String get accountDelete;

  /// No description provided for @accountCurrentPasswordTitle.
  ///
  /// In en, this message translates to:
  /// **'Confirm your\ncurrent password'**
  String get accountCurrentPasswordTitle;

  /// No description provided for @accountCurrentPassword.
  ///
  /// In en, this message translates to:
  /// **'Current password'**
  String get accountCurrentPassword;

  /// No description provided for @accountCurrentPasswordRequired.
  ///
  /// In en, this message translates to:
  /// **'Enter your current password'**
  String get accountCurrentPasswordRequired;

  /// No description provided for @accountNewPasswordTitle.
  ///
  /// In en, this message translates to:
  /// **'Create a\nnew password'**
  String get accountNewPasswordTitle;

  /// No description provided for @accountNewPassword.
  ///
  /// In en, this message translates to:
  /// **'New password'**
  String get accountNewPassword;

  /// No description provided for @accountPasswordMustDiffer.
  ///
  /// In en, this message translates to:
  /// **'The new password must be different from the current one'**
  String get accountPasswordMustDiffer;

  /// No description provided for @accountChangePasswordButton.
  ///
  /// In en, this message translates to:
  /// **'Change password'**
  String get accountChangePasswordButton;

  /// No description provided for @accountPasswordChanged.
  ///
  /// In en, this message translates to:
  /// **'Password changed successfully.'**
  String get accountPasswordChanged;

  /// No description provided for @accountNewEmailTitle.
  ///
  /// In en, this message translates to:
  /// **'Enter your\nnew email'**
  String get accountNewEmailTitle;

  /// No description provided for @accountNewEmail.
  ///
  /// In en, this message translates to:
  /// **'New email'**
  String get accountNewEmail;

  /// No description provided for @accountEmailChangedTitle.
  ///
  /// In en, this message translates to:
  /// **'Email confirmed!'**
  String get accountEmailChangedTitle;

  /// No description provided for @accountEmailChangedSubtitle.
  ///
  /// In en, this message translates to:
  /// **'All set. Your new email is now linked to your account.'**
  String get accountEmailChangedSubtitle;

  /// No description provided for @accountEmailChanged.
  ///
  /// In en, this message translates to:
  /// **'Email changed successfully.'**
  String get accountEmailChanged;

  /// No description provided for @commonRetry.
  ///
  /// In en, this message translates to:
  /// **'Try again'**
  String get commonRetry;

  /// No description provided for @commonCancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get commonCancel;

  /// No description provided for @commonDelete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get commonDelete;

  /// No description provided for @complementaryHoursTitle.
  ///
  /// In en, this message translates to:
  /// **'My\nprogress'**
  String get complementaryHoursTitle;

  /// No description provided for @complementaryHoursInformalNotice.
  ///
  /// In en, this message translates to:
  /// **'Personal estimate. It does not prove attendance or replace IFPR records.'**
  String get complementaryHoursInformalNotice;

  /// No description provided for @complementaryHoursLoadError.
  ///
  /// In en, this message translates to:
  /// **'Unable to load the hours counter.'**
  String get complementaryHoursLoadError;

  /// No description provided for @complementaryHoursProgressSemantics.
  ///
  /// In en, this message translates to:
  /// **'{completed} of {target}'**
  String complementaryHoursProgressSemantics(String completed, String target);

  /// No description provided for @complementaryHoursRecords.
  ///
  /// In en, this message translates to:
  /// **'My records'**
  String get complementaryHoursRecords;

  /// No description provided for @complementaryHoursRecordsLoadError.
  ///
  /// In en, this message translates to:
  /// **'Unable to load the records.'**
  String get complementaryHoursRecordsLoadError;

  /// No description provided for @complementaryHoursRecordsEmpty.
  ///
  /// In en, this message translates to:
  /// **'No records yet.'**
  String get complementaryHoursRecordsEmpty;

  /// No description provided for @complementaryHoursNoWorkload.
  ///
  /// In en, this message translates to:
  /// **'No credited hours'**
  String get complementaryHoursNoWorkload;

  /// No description provided for @complementaryHoursDeleteTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete record?'**
  String get complementaryHoursDeleteTitle;

  /// No description provided for @complementaryHoursDeleteMessage.
  ///
  /// In en, this message translates to:
  /// **'“{eventName}” will be removed from your informal counter.'**
  String complementaryHoursDeleteMessage(String eventName);

  /// No description provided for @complementaryHoursDeleteError.
  ///
  /// In en, this message translates to:
  /// **'Unable to delete the record.'**
  String get complementaryHoursDeleteError;

  /// No description provided for @complementaryHoursDeleted.
  ///
  /// In en, this message translates to:
  /// **'Record deleted.'**
  String get complementaryHoursDeleted;
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
      <String>['en', 'es', 'pt'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
    case 'pt':
      return AppLocalizationsPt();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
