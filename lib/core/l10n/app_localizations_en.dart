// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get welcomeTo => 'Welcome To';

  @override
  String get whereIf => 'Where IF';

  @override
  String get continueButton => 'Continue';

  @override
  String get joinThe => 'Join the';

  @override
  String get team => 'Team';

  @override
  String get email => 'Email';

  @override
  String get password => 'Password';

  @override
  String get forgot => 'Forgot your password?';

  @override
  String get loginButton => 'Enter';

  @override
  String get dontHaveAccount => 'Don\'t have an account?';

  @override
  String get signupButton => 'Sign up';

  @override
  String get or => 'or';

  @override
  String get googleButton => 'Sign in with Google';

  @override
  String get whatYour => 'What\'s your';

  @override
  String get createPassword => 'Create a';

  @override
  String get fieldsRequired => 'Please fill in the fields';

  @override
  String get invalidFields => 'Incorrect email or password';

  @override
  String get authEmailAlreadyInUse =>
      'This email is already linked to an account.';

  @override
  String get authWeakPassword =>
      'The password does not meet the security requirements.';

  @override
  String get authNetworkError =>
      'No connection. Check your internet and try again.';

  @override
  String get authTooManyRequests =>
      'Too many attempts. Wait a moment and try again.';

  @override
  String get authAccountDisabled => 'This account is disabled.';

  @override
  String get authUnexpectedError => 'Authentication could not be completed.';

  @override
  String get authUserNotFound => 'Account not found.';

  @override
  String get authGoogleCanceled => 'Google sign-in was canceled.';

  @override
  String get emailRequired => 'Please enter a email';

  @override
  String get invalidEmail => 'Incorrect email';

  @override
  String get passwordRequired => 'Please enter a password';

  @override
  String get passwordMinLength => 'Password must be at least 8 characters long';

  @override
  String get passwordRequireLowercaseAndUppercase =>
      'Uppercase and lowercase letters';

  @override
  String get passwordRequireNumber => 'Include at least one number';

  @override
  String get passwordRequireSymbol => 'Include at least one symbol';

  @override
  String get passwordStrengthEmpty => 'Enter a password';

  @override
  String get passwordStrengthVeryWeak => 'Very weak';

  @override
  String get passwordStrengthWeak => 'Weak';

  @override
  String get passwordStrengthFair => 'Fair';

  @override
  String get passwordStrengthGood => 'Good';

  @override
  String get passwordStrengthExcellent => 'Excellent';

  @override
  String get checkEmailTitle => 'Check your email';

  @override
  String get checkEmailSentTo => 'We sent a link to:';

  @override
  String get checkEmailDescription => 'Click the link to continue.';

  @override
  String get emailConfirmedTitle => 'Email confirmed!';

  @override
  String get emailConfirmedSubtitle =>
      'All set. Now let\'s continue so you can create your new password.';

  @override
  String get accountConfirmedSubtitle =>
      'Your account has been confirmed. You can now continue.';

  @override
  String get eventsTitle => 'Events';

  @override
  String get navigationMap => 'Map';

  @override
  String get navigationEvents => 'Events';

  @override
  String get navigationNotifications => 'Notifications';

  @override
  String get navigationHours => 'Hours';

  @override
  String get featuredEvents => 'Featured';

  @override
  String get futureEvents => 'Upcoming events';

  @override
  String get addToPersonalHistory => 'Add to my history';

  @override
  String get personalHistoryAdded => 'Saved to my history';

  @override
  String get personalRecordUpdating => 'Updating my history...';

  @override
  String get personalRecordNotice =>
      'Personal record. It does not prove attendance or grant official hours.';

  @override
  String get viewOnMap => 'View on map';

  @override
  String get notificationEvent => 'Event';

  @override
  String get notificationReminder => 'Reminder';

  @override
  String get notificationUpdate => 'Update';

  @override
  String get notificationsTitle => 'Notifications';

  @override
  String get notificationsLoadErrorTitle =>
      'Notifications could not be loaded.';

  @override
  String get notificationsEmptyTitle => 'Nothing here yet.';

  @override
  String get notificationsLoadErrorMessage =>
      'Check your connection and try again.';

  @override
  String get notificationsEmptyMessage => 'Important updates will appear here.';

  @override
  String get notificationTimeNow => 'Now';

  @override
  String notificationTimeMinutesAgo(int count) {
    return '$count min ago';
  }

  @override
  String notificationTimeHoursAgo(int count) {
    return '${count}h ago';
  }

  @override
  String get notificationTimeYesterday => 'Yesterday';

  @override
  String notificationTimeDaysAgo(int count) {
    return '$count days ago';
  }

  @override
  String get notificationsFilterAll => 'All';

  @override
  String get notificationsFilterEvents => 'Events';

  @override
  String get notificationsFilterReminders => 'Reminders';

  @override
  String get notificationsFilterUpdates => 'Updates';

  @override
  String get settingsTitle => 'Settings';

  @override
  String get settingsAccountSection => 'Account';

  @override
  String get settingsEditProfile => 'Edit account';

  @override
  String get settingsDarkMode => 'Dark mode';

  @override
  String get settingsNotifications => 'Notifications';

  @override
  String get settingsLanguage => 'Language';

  @override
  String get settingsSignOut => 'Sign out';

  @override
  String get settingsSupportSection => 'Support and about';

  @override
  String get settingsHelpSupport => 'Help and support';

  @override
  String get settingsAbout => 'About';

  @override
  String get settingsComingSoon => 'This option will be available soon.';

  @override
  String get settingsSignOutTitle => 'Sign out?';

  @override
  String get settingsSignOutMessage =>
      'You will need to sign in again to access the app.';

  @override
  String get settingsCancel => 'Cancel';

  @override
  String get settingsConfirmSignOut => 'Sign out';

  @override
  String get settingsSignOutError => 'Unable to sign out.';

  @override
  String get aboutDescription =>
      'Events, navigation, and a personal history of your activities.';

  @override
  String get aboutVersion => 'Version';

  @override
  String get aboutAcademicProject =>
      'Project developed as an undergraduate final project.';

  @override
  String get aboutInstitution =>
      'Federal Institute of Paraná • Paranaguá Campus';

  @override
  String get aboutTeam => 'Developed by';

  @override
  String get aboutDeveloperRole => 'Developer';

  @override
  String get aboutLegalInformation => 'Legal information';

  @override
  String get aboutPrivacyPolicy => 'Privacy policy';

  @override
  String get aboutTermsOfUse => 'Terms of use';

  @override
  String get helpIntroTitle => 'How can we help?';

  @override
  String get helpIntroDescription =>
      'Find quick answers about the main WhereIF features.';

  @override
  String get helpTopicsTitle => 'Help topics';

  @override
  String get helpPersonalHistoryTitle =>
      'How do I record an activity in my history?';

  @override
  String get helpPersonalHistoryDescription =>
      'Open the event details and tap Add to my history. This is a personal note and does not prove attendance or replace IFPR validation.';

  @override
  String get helpHoursTitle => 'How are complementary hours calculated?';

  @override
  String get helpHoursDescription =>
      'The counter estimates the hours listed for events added to your history. It is a personal reference and does not replace IFPR\'s official records.';

  @override
  String get helpRecordsTitle => 'How do I delete a record?';

  @override
  String get helpRecordsDescription =>
      'On the hours screen, open the records drawer and swipe a card sideways. Confirm the deletion when the prompt appears.';

  @override
  String get helpNotificationsTitle => 'How do notifications work?';

  @override
  String get helpNotificationsDescription =>
      'Use the filters to find updates, events, and reminders. Tap a notification to expand or collapse its content.';

  @override
  String get helpAccountTitle => 'How do I change my email or password?';

  @override
  String get helpAccountDescription =>
      'Open Settings, select Edit account, and choose the information you want to change. Some changes require a security confirmation.';

  @override
  String get helpContactTitle => 'Still need help?';

  @override
  String get helpContactDescription =>
      'Contact the team. Tap the address below to copy it.';

  @override
  String get helpCopyEmail => 'Copy email';

  @override
  String get helpEmailCopied => 'Support email copied.';

  @override
  String get accountTitle => 'Account';

  @override
  String get accountSecuritySection => 'Security';

  @override
  String get accountChangeEmail => 'Change email';

  @override
  String get accountChangePassword => 'Change password';

  @override
  String get accountDelete => 'Delete account';

  @override
  String get accountCurrentPasswordTitle => 'Confirm your\ncurrent password';

  @override
  String get accountCurrentPassword => 'Current password';

  @override
  String get accountCurrentPasswordRequired => 'Enter your current password';

  @override
  String get accountNewPasswordTitle => 'Create a\nnew password';

  @override
  String get accountNewPassword => 'New password';

  @override
  String get accountPasswordMustDiffer =>
      'The new password must be different from the current one';

  @override
  String get accountChangePasswordButton => 'Change password';

  @override
  String get accountPasswordChanged => 'Password changed successfully.';

  @override
  String get accountNewEmailTitle => 'Enter your\nnew email';

  @override
  String get accountNewEmail => 'New email';

  @override
  String get accountEmailChangedTitle => 'Email confirmed!';

  @override
  String get accountEmailChangedSubtitle =>
      'All set. Your new email is now linked to your account.';

  @override
  String get accountEmailChanged => 'Email changed successfully.';

  @override
  String get commonRetry => 'Try again';

  @override
  String get commonCancel => 'Cancel';

  @override
  String get commonDelete => 'Delete';

  @override
  String get complementaryHoursTitle => 'My\nprogress';

  @override
  String get complementaryHoursInformalNotice =>
      'Personal estimate. It does not prove attendance or replace IFPR records.';

  @override
  String get complementaryHoursLoadError => 'Unable to load the hours counter.';

  @override
  String complementaryHoursProgressSemantics(String completed, String target) {
    return '$completed of $target';
  }

  @override
  String get complementaryHoursRecords => 'My records';

  @override
  String get complementaryHoursRecordsLoadError =>
      'Unable to load the records.';

  @override
  String get complementaryHoursRecordsEmpty => 'No records yet.';

  @override
  String get complementaryHoursNoWorkload => 'No credited hours';

  @override
  String get complementaryHoursDeleteTitle => 'Delete record?';

  @override
  String complementaryHoursDeleteMessage(String eventName) {
    return '“$eventName” will be removed from your informal counter.';
  }

  @override
  String get complementaryHoursDeleteError => 'Unable to delete the record.';

  @override
  String get complementaryHoursDeleted => 'Record deleted.';
}
