import 'package:auto_injector/auto_injector.dart';
import 'package:autth_injustice_app/account/domain/services/i_current_account_provider.dart';
import 'package:autth_injustice_app/authentication/data/repositories/auth_repository_impl.dart';
import 'package:autth_injustice_app/authentication/data/repositories/i_auth_repository.dart';
import 'package:autth_injustice_app/authentication/data/services/local/auth_local_session_manager.dart';
import 'package:autth_injustice_app/authentication/data/services/local/i_local_session_store.dart';
import 'package:autth_injustice_app/authentication/data/services/local/shared_pref_local_session_service.dart';
import 'package:autth_injustice_app/authentication/data/services/remote/firebase_auth_service.dart';
import 'package:autth_injustice_app/authentication/data/services/remote/i_auth_service.dart';
import 'package:autth_injustice_app/authentication/domain/facades/auth_use_case_facade_impl.dart';
import 'package:autth_injustice_app/authentication/domain/facades/i_auth_use_case_facade.dart';
import 'package:autth_injustice_app/authentication/domain/usecases/auth_usecases_impl.dart';
import 'package:autth_injustice_app/authentication/domain/usecases/i_auth_usecases.dart';
import 'package:autth_injustice_app/authentication/presentation/viewmodels/auth/auth_session_viewmodel.dart';
import 'package:autth_injustice_app/authentication/presentation/viewmodels/check_email/check_email_viewmodel.dart';
import 'package:autth_injustice_app/authentication/presentation/viewmodels/login/login_viewmodel.dart';
import 'package:autth_injustice_app/authentication/presentation/viewmodels/register/register_viewmodel.dart';
import 'package:autth_injustice_app/authorization/domain/services/authorization_service.dart';
import 'package:autth_injustice_app/complementary_hours/data/repositories/complementary_hours_repository_impl.dart';
import 'package:autth_injustice_app/complementary_hours/data/services/i_complementary_hours_service.dart';
import 'package:autth_injustice_app/complementary_hours/domain/facades/complementary_hours_use_case_facade_impl.dart';
import 'package:autth_injustice_app/complementary_hours/domain/facades/i_complementary_hours_use_case_facade.dart';
import 'package:autth_injustice_app/complementary_hours/domain/repositories/i_complementary_hours_repository.dart';
import 'package:autth_injustice_app/complementary_hours/domain/usecases/complementary_hours_usecases_impl.dart';
import 'package:autth_injustice_app/complementary_hours/domain/usecases/i_complementary_hours_usecases.dart';
import 'package:autth_injustice_app/complementary_hours/presentation/viewmodels/records/complementary_hours_records_viewmodel.dart';
import 'package:autth_injustice_app/complementary_hours/presentation/viewmodels/summary/complementary_hours_viewmodel.dart';
import 'package:autth_injustice_app/core/l10n/locale_controller.dart';
import 'package:autth_injustice_app/core/theme/theme_controller.dart';
import 'package:autth_injustice_app/account/data/repositories/account_repository_impl.dart';
import 'package:autth_injustice_app/account/data/repositories/i_account_repository.dart';
import 'package:autth_injustice_app/account/data/services/account_firestore_service.dart';
import 'package:autth_injustice_app/account/data/services/i_account_remote_storage.dart';
import 'package:autth_injustice_app/dev/demo_backend/demo_backend_store.dart';
import 'package:autth_injustice_app/dev/demo_backend/services/demo_complementary_hours_service.dart';
import 'package:autth_injustice_app/dev/demo_backend/services/demo_current_account_provider.dart';
import 'package:autth_injustice_app/dev/demo_backend/services/demo_account_security_service.dart';
import 'package:autth_injustice_app/dev/demo_backend/services/demo_events_service.dart';
import 'package:autth_injustice_app/dev/demo_backend/services/demo_notifications_service.dart';
import 'package:autth_injustice_app/account/domain/facades/account_facade_impl.dart';
import 'package:autth_injustice_app/account/domain/facades/i_account_facade.dart';
import 'package:autth_injustice_app/account/domain/usecases/account_usecases_impl.dart';
import 'package:autth_injustice_app/account/domain/usecases/i_account_usecases.dart';
import 'package:autth_injustice_app/events/data/repositories/events_repository_impl.dart';
import 'package:autth_injustice_app/events/data/repositories/i_events_repository.dart';
import 'package:autth_injustice_app/events/data/services/i_events_service.dart';
import 'package:autth_injustice_app/events/domain/facades/events_use_case_facade_impl.dart';
import 'package:autth_injustice_app/events/domain/facades/i_events_use_case_facade.dart';
import 'package:autth_injustice_app/events/domain/usecases/events_usecases_impl.dart';
import 'package:autth_injustice_app/events/domain/usecases/i_events_usecases.dart';
import 'package:autth_injustice_app/events/presentation/viewmodels/event_details/event_details_viewmodel.dart';
import 'package:autth_injustice_app/events/presentation/viewmodels/events_catalog/events_catalog_viewmodel.dart';
import 'package:autth_injustice_app/notifications/data/repositories/i_notifications_repository.dart';
import 'package:autth_injustice_app/notifications/data/repositories/notifications_repository_impl.dart';
import 'package:autth_injustice_app/notifications/data/services/i_notifications_service.dart';
import 'package:autth_injustice_app/notifications/domain/facades/i_notifications_use_case_facade.dart';
import 'package:autth_injustice_app/notifications/domain/facades/notifications_use_case_facade_impl.dart';
import 'package:autth_injustice_app/notifications/domain/usecases/i_notifications_usecases.dart';
import 'package:autth_injustice_app/notifications/domain/usecases/notifications_usecases_impl.dart';
import 'package:autth_injustice_app/notifications/presentation/viewmodels/notifications/notifications_viewmodel.dart';
import 'package:autth_injustice_app/settings/presentation/viewmodels/change_email/change_email_viewmodel.dart';
import 'package:autth_injustice_app/settings/presentation/viewmodels/change_password/change_password_viewmodel.dart';
import 'package:autth_injustice_app/settings/presentation/viewmodels/settings/settings_viewmodel.dart';
import 'package:autth_injustice_app/settings/data/repositories/account_security_repository_impl.dart';
import 'package:autth_injustice_app/settings/data/repositories/i_account_security_repository.dart';
import 'package:autth_injustice_app/settings/data/services/i_account_security_service.dart';
import 'package:autth_injustice_app/settings/domain/facades/account_security_facade_impl.dart';
import 'package:autth_injustice_app/settings/domain/facades/i_account_security_facade.dart';
import 'package:autth_injustice_app/settings/domain/usecases/account_security_usecases_impl.dart';
import 'package:autth_injustice_app/settings/domain/usecases/i_account_security_usecases.dart';

final injector = AutoInjector();

void setupDependencies() {
  _registerAuthentication();
  _registerCurrentAccount();
  _registerStudentFeatures();
  _registerAccountManagement();
  _registerSettings();
  injector.commit();
}

void _registerAuthentication() {
  injector.addSingleton<ILocalSessionStore>(SharedPrefLocalSessionService.new);
  injector.addSingleton<AuthLocalSessionManager>(AuthLocalSessionManager.new);
  injector.addSingleton<IAccountRemoteStorage>(AccountFirestoreService.new);
  injector.addSingleton<IAuthService>(FirebaseAuthService.new);
  injector.addSingleton<IAuthRepository>(AuthRepositoryImpl.new);

  injector.addSingleton<ISignInUseCase>(SignInUseCase.new);
  injector.addSingleton<ISignInWithGoogleUseCase>(SignInWithGoogleUseCase.new);
  injector.addSingleton<ISignOutUseCase>(SignOutUseCase.new);
  injector.addSingleton<ISignUpUseCase>(SignUpUseCase.new);
  injector.addSingleton<IAuthUseCaseFacade>(AuthUseCaseFacadeImpl.new);

  injector.addSingleton<AuthSessionViewModel>(AuthSessionViewModel.new);
  injector.addSingleton<LoginViewModel>(LoginViewModel.new);
  injector.addSingleton<RegisterViewModel>(RegisterViewModel.new);
  injector.addSingleton<CheckEmailViewModel>(CheckEmailViewModel.new);
}

void _registerCurrentAccount() {
  injector.addSingleton<DemoBackendStore>(DemoBackendStore.new);

  // Demo switch: replace only this binding with
  // AuthenticatedCurrentAccountProvider when the student backend is enabled.
  injector
      .addSingleton<ICurrentAccountProvider>(DemoCurrentAccountProvider.new);
  injector.addSingleton<AuthorizationService>(AuthorizationService.new);
}

void _registerStudentFeatures() {
  injector.addSingleton<IEventsService>(DemoEventsService.new);
  injector.addSingleton<IEventsRepository>(EventsRepositoryImpl.new);
  injector.addSingleton<IGetEventsCatalogUseCase>(GetEventsCatalogUseCase.new);
  injector.addSingleton<IGetEventDetailsUseCase>(GetEventDetailsUseCase.new);
  injector.addSingleton<ISetEventPersonalRecordUseCase>(
    SetEventPersonalRecordUseCase.new,
  );
  injector.addSingleton<IEventsUseCaseFacade>(EventsUseCaseFacadeImpl.new);
  injector.addSingleton<EventsCatalogViewModel>(EventsCatalogViewModel.new);
  injector.addSingleton<EventDetailsViewModel>(EventDetailsViewModel.new);

  injector.addSingleton<INotificationsService>(DemoNotificationsService.new);
  injector.addSingleton<INotificationsRepository>(
    NotificationsRepositoryImpl.new,
  );
  injector.addSingleton<IGetNotificationsUseCase>(GetNotificationsUseCase.new);
  injector.addSingleton<IMarkNotificationAsReadUseCase>(
    MarkNotificationAsReadUseCase.new,
  );
  injector.addSingleton<IMarkAllNotificationsAsReadUseCase>(
    MarkAllNotificationsAsReadUseCase.new,
  );
  injector.addSingleton<INotificationsUseCaseFacade>(
    NotificationsUseCaseFacadeImpl.new,
  );
  injector.addSingleton<NotificationsViewModel>(NotificationsViewModel.new);

  injector.addSingleton<IComplementaryHoursService>(
    DemoComplementaryHoursService.new,
  );
  injector.addSingleton<IComplementaryHoursRepository>(
    ComplementaryHoursRepositoryImpl.new,
  );
  injector.addSingleton<IGetComplementaryHoursSummaryUseCase>(
    GetComplementaryHoursSummaryUseCase.new,
  );
  injector.addSingleton<IGetComplementaryHoursRecordsUseCase>(
    GetComplementaryHoursRecordsUseCase.new,
  );
  injector.addSingleton<IDeleteComplementaryHoursRecordUseCase>(
    DeleteComplementaryHoursRecordUseCase.new,
  );
  injector.addSingleton<IComplementaryHoursUseCaseFacade>(
    ComplementaryHoursUseCaseFacadeImpl.new,
  );
  injector.addSingleton<ComplementaryHoursViewModel>(
    ComplementaryHoursViewModel.new,
  );
  injector.addSingleton<ComplementaryHoursRecordsViewModel>(
    ComplementaryHoursRecordsViewModel.new,
  );
}

void _registerAccountManagement() {
  injector.addSingleton<IAccountRepository>(AccountRepositoryImpl.new);
  injector.addSingleton<IGetAccountUseCase>(GetAccountUseCaseImpl.new);
  injector.addSingleton<ISaveAccountUseCase>(SaveAccountUseCaseImpl.new);
  injector.addSingleton<IUpdateAccountUseCase>(UpdateAccountUseCaseImpl.new);
  injector.addSingleton<IDeleteAccountUseCase>(DeleteAccountUseCaseImpl.new);
  injector.addSingleton<IAccountFacade>(AccountFacadeImpl.new);
}

void _registerSettings() {
  injector.addSingleton<ThemeController>(ThemeController.new);
  injector.addSingleton<LocaleController>(LocaleController.new);
  injector.addSingleton<SettingsViewModel>(SettingsViewModel.new);

  // Replace this demo service with a Firebase implementation. The pages,
  // repository, use cases and viewmodels remain unchanged.
  injector.addSingleton<IAccountSecurityService>(
    DemoAccountSecurityService.new,
  );
  injector.addSingleton<IAccountSecurityRepository>(
    AccountSecurityRepositoryImpl.new,
  );
  injector.addSingleton<IChangePasswordUseCase>(ChangePasswordUseCase.new);
  injector.addSingleton<IRequestEmailChangeUseCase>(
    RequestEmailChangeUseCase.new,
  );
  injector.addSingleton<IAccountSecurityFacade>(
    AccountSecurityFacadeImpl.new,
  );
  injector.addSingleton<ChangeEmailViewModel>(ChangeEmailViewModel.new);
  injector.addSingleton<ChangePasswordViewModel>(ChangePasswordViewModel.new);
}
