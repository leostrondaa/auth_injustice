import 'package:autth_injustice_app/domain/models/auth_entities.dart';
import '../failure/failure.dart';
import 'package:flutter/material.dart';
import '../../domain/models/account_entity.dart';
import '../../domain/models/character_entity.dart';
import '../patterns/result.dart';

// typedefs para autenticação
typedef VoidResult = Result<void, Failure>;
typedef AuthSessionResult = Result<AuthSession, Failure>;

// typedefs para parâmetros
typedef NoParams = ();
typedef SignInParams = ({String email, String password});
typedef SignUpParams = ({String? name, String email, String password});

// typedefs para tipo Result
typedef AccountResult = Result<Account, Failure>;
typedef CharacterResult = Result<Character, Failure>;
typedef ListCharacterResult = Result<List<Character>, Failure>;

// typedefs para parâmetros
typedef AccountParams = ({Account account});
typedef AccountNameParams = ({String accountName});
typedef CharacterIdParams = ({String id});
typedef CharacterParams = ({Character character});

/// typedefs para ser usados em componentes de UI
typedef FormFieldControl = ({
  GlobalKey<FormFieldState> key,
  FocusNode focus,
  TextEditingController controller,
});
