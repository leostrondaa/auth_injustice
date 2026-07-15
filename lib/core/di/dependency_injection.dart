import 'package:auto_injector/auto_injector.dart';

// ── Auth local session ─────────────────────────────────────────────────────
import 'package:autth_injustice_app/authentication/data/services/local/i_local_session_store.dart';
import 'package:autth_injustice_app/authentication/data/services/local/shared_pref_local_session_service.dart';
import 'package:autth_injustice_app/authentication/data/services/local/auth_local_session_manager.dart';

// ── Auth remote service ────────────────────────────────────────────────────
import 'package:autth_injustice_app/authentication/data/services/remote/i_auth_service.dart';
import 'package:autth_injustice_app/authentication/data/services/remote/firebase_auth_service.dart';

// ── Auth repository ────────────────────────────────────────────────────────
import 'package:autth_injustice_app/authentication/data/repositories/i_auth_repository.dart';
import 'package:autth_injustice_app/authentication/data/repositories/auth_repository_impl.dart';

// ── Auth use cases ─────────────────────────────────────────────────────────
import 'package:autth_injustice_app/authentication/domain/usecases/i_auth_usecases.dart';
import 'package:autth_injustice_app/authentication/domain/usecases/auth_usecases_impl.dart';

// ── Auth facade ────────────────────────────────────────────────────────────
import 'package:autth_injustice_app/authentication/domain/facades/i_auth_use_case_facade.dart';
import 'package:autth_injustice_app/authentication/domain/facades/auth_use_case_facade_impl.dart';

// ── Auth ViewModel ─────────────────────────────────────────────────────────
import 'package:autth_injustice_app/authentication/presentation/controllers/auth/auth_session_viewmodel.dart';
import 'package:autth_injustice_app/authentication/presentation/controllers/login/login_viewmodel.dart';
import 'package:autth_injustice_app/authentication/presentation/controllers/register/register_viewmodel.dart';

// ── Account remote storage ─────────────────────────────────────────────────
import 'package:autth_injustice_app/data/services/remote/account_remote_storage_interface.dart';
import 'package:autth_injustice_app/data/services/remote/account_firestore_service.dart';

// ── Character remote storage ───────────────────────────────────────────────
import 'package:autth_injustice_app/data/services/remote/character_remote_storage_interface.dart';
import 'package:autth_injustice_app/data/services/remote/character_firestore_service.dart';

// ── Account repository ─────────────────────────────────────────────────────
import 'package:autth_injustice_app/data/repositories/account_repository_interface.dart';
import 'package:autth_injustice_app/data/repositories/account_repository_impl.dart';

// ── Character repository ───────────────────────────────────────────────────
import 'package:autth_injustice_app/data/repositories/character_repository_interface.dart';
import 'package:autth_injustice_app/data/repositories/character_repository_impl.dart';

// ── Account use cases ──────────────────────────────────────────────────────
import 'package:autth_injustice_app/domain/usecases/account_usecases_interfaces.dart';
import 'package:autth_injustice_app/domain/usecases/account_usecases_impl.dart';

// ── Account facade ─────────────────────────────────────────────────────────
import 'package:autth_injustice_app/domain/facades/account_facade_usecases_interface.dart';
import 'package:autth_injustice_app/domain/facades/account_facade_usecases_impl.dart';

// ── Character use cases ────────────────────────────────────────────────────
import 'package:autth_injustice_app/domain/usecases/character_usecases_interfaces.dart';
import 'package:autth_injustice_app/domain/usecases/character_usecases_impl.dart';

// ── Character facade ───────────────────────────────────────────────────────
import 'package:autth_injustice_app/domain/facades/character_facade_usecases_interface.dart';
import 'package:autth_injustice_app/domain/facades/character_facade_usecases_impl.dart';

// ── Theme ──────────────────────────────────────────────────────────────────
import 'package:autth_injustice_app/core/theme/theme_controller.dart';

final injector = AutoInjector();

void setupDependencies() {
  // ── 1. Auth: local session ───────────────────────────────────────────────
  // Ordem importa: dependências antes dos que as consomem.
  injector.addSingleton<ILocalSessionStore>(SharedPrefLocalSessionService.new);
  injector.addSingleton<AuthLocalSessionManager>(AuthLocalSessionManager.new);

  // ── 2. Account remote storage ────────────────────────────────────────────
  // Registrado ANTES do FirebaseAuthService, pois ele depende disso.
  injector.addSingleton<IAccountRemoteStorage>(AccountFirestoreService.new);

  // ── 3. Auth remote service ───────────────────────────────────────────────
  // FirebaseAuthService depende de AuthLocalSessionManager + IAccountRemoteStorage.
  injector.addSingleton<IAuthService>(FirebaseAuthService.new);

  // ── 4. Auth repository ───────────────────────────────────────────────────
  injector.addSingleton<IAuthRepository>(AuthRepositoryImpl.new);

  // ── 5. Auth use cases ────────────────────────────────────────────────────
  injector.addSingleton<ISignInUseCase>(SignInUseCase.new);
  injector.addSingleton<ISignInWithGoogleUseCase>(SignInWithGoogleUseCase.new);
  injector.addSingleton<ISignOutUseCase>(SignOutUseCase.new);
  injector.addSingleton<ISignUpUseCase>(SignUpUseCase.new);

  // ── 6. Auth facade ───────────────────────────────────────────────────────
  injector.addSingleton<IAuthUseCaseFacade>(AuthUseCaseFacadeImpl.new);

  // ── 7. Auth ViewModel ────────────────────────────────────────────────────
  injector.addSingleton<AuthSessionViewModel>(
    AuthSessionViewModel.new,
  );

  // ── 7.1. Login ViewModel ────────────────────────────────────────────────────
  injector.addSingleton<LoginViewModel>(
    LoginViewModel.new,
  );

  // ── 7.2. Sign up ViewModel ────────────────────────────────────────────────────
  injector.addSingleton<RegisterViewModel>(
    RegisterViewModel.new,
  );

  // ── 8. Character remote storage ──────────────────────────────────────────
  injector.addSingleton<ICharacterRemoteStorage>(CharacterFirestoreService.new);

  // ── 9. Account repository ────────────────────────────────────────────────
  // Depende de IAccountRemoteStorage + IAuthRepository (já registrados).
  injector.addSingleton<IAccountRepository>(AccountRepositoryImpl.new);

  // ── 10. Character repository ─────────────────────────────────────────────
  // Depende de ICharacterRemoteStorage + IAuthRepository.
  injector.addSingleton<ICharacterRepository>(CharacterRepositoryImpl.new);

  // ── 11. Account use cases ────────────────────────────────────────────────
  injector.addSingleton<IGetAccountUseCase>(GetAccountUseCaseImpl.new);
  injector.addSingleton<ISaveAccountUseCase>(SaveAccountUseCaseImpl.new);
  injector.addSingleton<IUpdateAccountUseCase>(UpdateAccountUseCaseImpl.new);
  injector.addSingleton<IDeleteAccountUseCase>(DeleteAccountUseCaseImpl.new);

  // ── 12. Account facade ───────────────────────────────────────────────────
  injector.addSingleton<IAccountFacadeUseCases>(AccountFacadeUsecasesImpl.new);

  // ── 14. Character use cases ──────────────────────────────────────────────
  injector
      .addSingleton<IGetCharacterByIdUseCase>(GetCharacterByIdUseCaseImpl.new);
  injector
      .addSingleton<IGetAllCharactersUseCase>(GetAllCharactersUseCaseImpl.new);
  injector.addSingleton<ISaveCharacterUseCase>(SaveCharacterUseCaseImpl.new);
  injector
      .addSingleton<IDeleteCharacterUseCase>(DeleteCharacterUseCaseImpl.new);
  injector
      .addSingleton<IUpdateCharacterUseCase>(UpdateCharacterUseCaseImpl.new);

  // ── 15. Character facade ─────────────────────────────────────────────────
  injector
      .addSingleton<ICharacterFacadeUseCases>(CharacterFacadeUseCasesImpl.new);

  // ── 17. Theme ────────────────────────────────────────────────────────────
  injector.addSingleton<ThemeController>(ThemeController.new);

  injector.commit();
}
