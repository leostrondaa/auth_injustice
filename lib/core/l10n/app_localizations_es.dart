// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get welcomeTo => 'Bienvenido a';

  @override
  String get whereIf => 'Where IF';

  @override
  String get continueButton => 'Continuar';

  @override
  String get joinThe => 'Únete al';

  @override
  String get team => 'Equipo';

  @override
  String get email => 'Correo electrónico';

  @override
  String get password => 'Contraseña';

  @override
  String get forgot => '¿Olvidaste tu contraseña?';

  @override
  String get loginButton => 'Entrar';

  @override
  String get dontHaveAccount => '¿No tienes una cuenta?';

  @override
  String get signupButton => 'Regístrarse';

  @override
  String get or => 'o';

  @override
  String get googleButton => 'Iniciar sesión con Google';

  @override
  String get whatYour => '¿Cuál es tu';

  @override
  String get createPassword => 'Crea una';

  @override
  String get fieldsRequired => 'Por favor, complete los campos';

  @override
  String get invalidFields => 'Correo electrónico o contraseña incorrectos';

  @override
  String get emailRequired => 'Introduce un correo electrónico';

  @override
  String get invalidEmail => 'Correo electrónico incorrecto';

  @override
  String get passwordRequired => 'Introduce una contraseña';

  @override
  String get passwordMinLength =>
      'La contraseña debe tener al menos 8 caracteres';

  @override
  String get passwordRequireLowercaseAndUppercase =>
      'Letras mayúsculas y minúsculas';

  @override
  String get passwordRequireNumber => 'Incluye al menos un número';

  @override
  String get passwordRequireSymbol => 'Incluye al menos un símbolo';

  @override
  String get passwordStrengthEmpty => 'Introduce una contraseña';

  @override
  String get passwordStrengthVeryWeak => 'Muy débil';

  @override
  String get passwordStrengthWeak => 'Débil';

  @override
  String get passwordStrengthFair => 'Aceptable';

  @override
  String get passwordStrengthGood => 'Buena';

  @override
  String get passwordStrengthExcellent => 'Excelente';

  @override
  String get checkEmailTitle => 'Verifica tu correo electrónico';

  @override
  String get checkEmailSentTo => 'Enviamos un enlace a:';

  @override
  String get checkEmailDescription => 'Haz clic en el enlace para continuar.';

  @override
  String get emailConfirmedTitle => '¡Email confirmado!';

  @override
  String get emailConfirmedSubtitle =>
      'Todo listo. Ahora continuemos para crear tu nueva contraseña.';

  @override
  String get accountConfirmedSubtitle =>
      'Tu cuenta ha sido confirmada. Ahora puedes continuar.';
}
