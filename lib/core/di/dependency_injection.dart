import 'package:auto_injector/auto_injector.dart';

// ── Auth - local session (authentication/) ─────────────────────────────────
import 'package:autth_injustice_app/authentication/data/services/local/i_local_session_store.dart';
import 'package:autth_injustice_app/authentication/data/services/local/shared_pref_local_session_service.dart';
import 'package:autth_injustice_app/authentication/data/services/local/auth_local_session_manager.dart';

// ── Auth - remote service (authentication/) ────────────────────────────────
import 'package:autth_injustice_app/authentication/data/services/remote/i_auth_service.dart';
import 'package:autth_injustice_app/authentication/data/services/remote/firebase_auth_service.dart';

// ── Auth - repository (authentication/) ───────────────────────────────────
import 'package:autth_injustice_app/authentication/data/repositories/i_auth_repository.dart';
import 'package:autth_injustice_app/authentication/data/repositories/auth_repository_impl.dart';

// ── Auth - use cases (authentication/) ────────────────────────────────────
import 'package:autth_injustice_app/authentication/domain/usecases/i_auth_usecases.dart';
import 'package:autth_injustice_app/authentication/domain/usecases/auth_usecases_impl.dart';

// ── Auth - facade (authentication/) ───────────────────────────────────────
import 'package:autth_injustice_app/authentication/domain/facades/i_auth_use_case_facade.dart';
import 'package:autth_injustice_app/authentication/domain/facades/auth_use_case_facade_impl.dart';

// ── Auth - ViewModel (authentication/) ────────────────────────────────────
import 'package:autth_injustice_app/authentication/presentation/controllers/auth_session_viewmodel.dart';

// ── Account & Character - remote storage (data/) ──────────────────────────
import 'package:autth_injustice_app/data/services/remote/account_remote_storage_interface.dart';
import 'package:autth_injustice_app/data/services/remote/account_firestore_service.dart';
import 'package:autth_injustice_app/data/services/remote/character_remote_storage_interface.dart';
import 'package:autth_injustice_app/data/services/remote/character_firestore_service.dart';

// ── Account & Character - repositories (data/) ────────────────────────────
import 'package:autth_injustice_app/data/repositories/account_repository_interface.dart';
import 'package:autth_injustice_app/data/repositories/account_repository_impl.dart';
import 'package:autth_injustice_app/data/repositories/character_repository_interface.dart';
import 'package:autth_injustice_app/data/repositories/character_repository_impl.dart';

// ── Account - use cases ────────────────────────────────────────────────────
import 'package:autth_injustice_app/domain/usecases/account_usecases_interfaces.dart';
import 'package:autth_injustice_app/domain/usecases/account_usecases_impl.dart';

// ── Account - facade ───────────────────────────────────────────────────────
import 'package:autth_injustice_app/domain/facades/account_facade_usecases_interface.dart';
import 'package:autth_injustice_app/domain/facades/account_facade_usecases_impl.dart';

// ── Account - ViewModel ────────────────────────────────────────────────────
import 'package:autth_injustice_app/presentation/controllers/account_viewmodel.dart';

// ── Character - use cases ──────────────────────────────────────────────────
import 'package:autth_injustice_app/domain/usecases/character_usecases_interfaces.dart';
import 'package:autth_injustice_app/domain/usecases/character_usecases_impl.dart';

// ── Character - facade ─────────────────────────────────────────────────────
import 'package:autth_injustice_app/domain/facades/character_facade_usecases_interface.dart';
import 'package:autth_injustice_app/domain/facades/character_facade_usecases_impl.dart';

// ── Character - ViewModel ──────────────────────────────────────────────────
import 'package:autth_injustice_app/presentation/controllers/characters_view_model.dart';

// ── Theme ──────────────────────────────────────────────────────────────────
import 'package:autth_injustice_app/core/theme/theme_controller.dart';

final injector = AutoInjector();

void setupDependencies() {
  // ── Auth local session ───────────────────────────
  injector.addSingleton<ILocalSessionStore>(
    SharedPrefLocalSessionService.new,
  );
  injector.addSingleton<AuthLocalSessionManager>(
    AuthLocalSessionManager.new,
  );

  // ── Auth remote service ──────────────────────────
  injector.addSingleton<IAuthService>(
    FirebaseAuthService.new,
  );

  // ── Auth repository ──────────────────────────────
  injector.addSingleton<IAuthRepository>(
    AuthRepositoryImpl.new,
  );

  // ── Auth use cases ───────────────────────────────
  injector.addSingleton<ISignInUseCase>(SignInUseCase.new);
  injector.addSingleton<ISignInWithGoogleUseCase>(SignInWithGoogleUseCase.new);
  injector.addSingleton<ISignOutUseCase>(SignOutUseCase.new);
  injector.addSingleton<ISignUpUseCase>(SignUpUseCase.new);

  // ── Auth facade ──────────────────────────────────
  injector.addSingleton<IAuthUseCaseFacade>(AuthUseCaseFacadeImpl.new);

  // ── Auth ViewModel ───────────────────────────────
  injector.addSingleton<AuthViewModel>(AuthViewModel.new);

  // ── Account remote storage ───────────────────────
  injector.addSingleton<IAccountRemoteStorage>(AccountFirestoreService.new);

  // ── Character remote storage ─────────────────────
  injector.addSingleton<ICharacterRemoteStorage>(CharacterFirestoreService.new);

  // ── Account repository ───────────────────────────
  injector.addSingleton<IAccountRepository>(AccountRepositoryImpl.new);

  // ── Character repository ─────────────────────────
  injector.addSingleton<ICharacterRepository>(CharacterRepositoryImpl.new);

  // ── Account use cases ────────────────────────────
  injector.addSingleton<IGetAccountUseCase>(GetAccountUseCaseImpl.new);
  injector.addSingleton<ISaveAccountUseCase>(SaveAccountUseCaseImpl.new);
  injector.addSingleton<IUpdateAccountUseCase>(UpdateAccountUseCaseImpl.new);
  injector.addSingleton<IDeleteAccountUseCase>(DeleteAccountUseCaseImpl.new);

  // ── Account facade ───────────────────────────────
  injector.addSingleton<IAccountFacadeUseCases>(AccountFacadeUsecasesImpl.new);

  // ── Account ViewModel ────────────────────────────
  injector.addSingleton<AccountViewModel>(AccountViewModel.new);

  // ── Character use cases ──────────────────────────
  injector.addSingleton<IGetCharacterByIdUseCase>(GetCharacterByIdUseCaseImpl.new);
  injector.addSingleton<IGetAllCharactersUseCase>(GetAllCharactersUseCaseImpl.new);
  injector.addSingleton<ISaveCharacterUseCase>(SaveCharacterUseCaseImpl.new);
  injector.addSingleton<IDeleteCharacterUseCase>(DeleteCharacterUseCaseImpl.new);
  injector.addSingleton<IUpdateCharacterUseCase>(UpdateCharacterUseCaseImpl.new);

  // ── Character facade ─────────────────────────────
  injector.addSingleton<ICharacterFacadeUseCases>(CharacterFacadeUseCasesImpl.new);

  // ── Character ViewModel ──────────────────────────
  injector.addSingleton<CharactersViewModel>(CharactersViewModel.new);

  // ── Theme ────────────────────────────────────────
  injector.addSingleton<ThemeController>(ThemeController.new);

  injector.commit();
}
