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
  String get authEmailAlreadyInUse =>
      'Este correo ya está vinculado a una cuenta.';

  @override
  String get authWeakPassword =>
      'La contraseña no cumple los requisitos de seguridad.';

  @override
  String get authNetworkError =>
      'Sin conexión. Comprueba tu internet e inténtalo de nuevo.';

  @override
  String get authTooManyRequests =>
      'Demasiados intentos. Espera un momento e inténtalo de nuevo.';

  @override
  String get authAccountDisabled => 'Esta cuenta está desactivada.';

  @override
  String get authUnexpectedError => 'No se pudo completar la autenticación.';

  @override
  String get authUserNotFound => 'Cuenta no encontrada.';

  @override
  String get authGoogleCanceled => 'Se canceló el inicio de sesión con Google.';

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

  @override
  String get eventsTitle => 'Eventos';

  @override
  String get navigationMap => 'Mapa';

  @override
  String get navigationEvents => 'Eventos';

  @override
  String get navigationNotifications => 'Notificaciones';

  @override
  String get navigationHours => 'Horas';

  @override
  String get featuredEvents => 'Destacados';

  @override
  String get futureEvents => 'Próximos eventos';

  @override
  String get addToPersonalHistory => 'Añadir a mi historial';

  @override
  String get personalHistoryAdded => 'Guardado en mi historial';

  @override
  String get personalRecordUpdating => 'Actualizando mi historial...';

  @override
  String get personalRecordNotice =>
      'Registro personal. No acredita asistencia ni concede horas oficiales.';

  @override
  String get viewOnMap => 'Ver en el mapa';

  @override
  String get notificationEvent => 'Evento';

  @override
  String get notificationReminder => 'Recordatorio';

  @override
  String get notificationUpdate => 'Actualización';

  @override
  String get notificationsTitle => 'Notificaciones';

  @override
  String get notificationsLoadErrorTitle =>
      'No se pudieron cargar las notificaciones.';

  @override
  String get notificationsEmptyTitle => 'Aún no hay nada aquí.';

  @override
  String get notificationsLoadErrorMessage =>
      'Comprueba tu conexión e inténtalo de nuevo.';

  @override
  String get notificationsEmptyMessage =>
      'Las novedades importantes aparecerán aquí.';

  @override
  String get notificationTimeNow => 'Ahora';

  @override
  String notificationTimeMinutesAgo(int count) {
    return 'Hace $count min';
  }

  @override
  String notificationTimeHoursAgo(int count) {
    return 'Hace $count h';
  }

  @override
  String get notificationTimeYesterday => 'Ayer';

  @override
  String notificationTimeDaysAgo(int count) {
    return 'Hace $count días';
  }

  @override
  String get notificationsFilterAll => 'Todas';

  @override
  String get notificationsFilterEvents => 'Eventos';

  @override
  String get notificationsFilterReminders => 'Recordatorios';

  @override
  String get notificationsFilterUpdates => 'Actualizaciones';

  @override
  String get settingsTitle => 'Configuración';

  @override
  String get settingsAccountSection => 'Cuenta';

  @override
  String get settingsEditProfile => 'Editar cuenta';

  @override
  String get settingsDarkMode => 'Modo oscuro';

  @override
  String get settingsNotifications => 'Notificaciones';

  @override
  String get settingsLanguage => 'Idioma';

  @override
  String get settingsSignOut => 'Cerrar sesión';

  @override
  String get settingsSupportSection => 'Soporte y acerca de';

  @override
  String get settingsHelpSupport => 'Ayuda y soporte';

  @override
  String get settingsAbout => 'Acerca de';

  @override
  String get settingsComingSoon =>
      'Esta opción estará disponible próximamente.';

  @override
  String get settingsSignOutTitle => '¿Cerrar sesión?';

  @override
  String get settingsSignOutMessage =>
      'Tendrás que iniciar sesión nuevamente para acceder a la aplicación.';

  @override
  String get settingsCancel => 'Cancelar';

  @override
  String get settingsConfirmSignOut => 'Cerrar sesión';

  @override
  String get settingsSignOutError => 'No se pudo cerrar la sesión.';

  @override
  String get aboutDescription =>
      'Eventos, orientación y un historial personal de tus actividades.';

  @override
  String get aboutVersion => 'Versión';

  @override
  String get aboutAcademicProject =>
      'Proyecto desarrollado como trabajo final de grado.';

  @override
  String get aboutInstitution =>
      'Instituto Federal de Paraná • Campus Paranaguá';

  @override
  String get aboutTeam => 'Desarrollado por';

  @override
  String get aboutDeveloperRole => 'Desarrollador';

  @override
  String get aboutLegalInformation => 'Información legal';

  @override
  String get aboutPrivacyPolicy => 'Política de privacidad';

  @override
  String get aboutTermsOfUse => 'Términos de uso';

  @override
  String get helpIntroTitle => '¿Cómo podemos ayudarte?';

  @override
  String get helpIntroDescription =>
      'Encuentra respuestas rápidas sobre las funciones principales de WhereIF.';

  @override
  String get helpTopicsTitle => 'Temas de ayuda';

  @override
  String get helpPersonalHistoryTitle =>
      '¿Cómo registrar una actividad en mi historial?';

  @override
  String get helpPersonalHistoryDescription =>
      'Abre los detalles del evento y toca Añadir a mi historial. Este registro es una anotación personal y no acredita asistencia ni sustituye la validación del IFPR.';

  @override
  String get helpHoursTitle => '¿Cómo se calculan las horas complementarias?';

  @override
  String get helpHoursDescription =>
      'El contador estima las horas informadas en los eventos añadidos a tu historial. Es una referencia personal y no sustituye los registros oficiales del IFPR.';

  @override
  String get helpRecordsTitle => '¿Cómo eliminar un registro?';

  @override
  String get helpRecordsDescription =>
      'En la pantalla de horas, abre el panel de registros y desliza una tarjeta hacia un lado. Confirma la eliminación cuando aparezca el aviso.';

  @override
  String get helpNotificationsTitle => '¿Cómo funcionan las notificaciones?';

  @override
  String get helpNotificationsDescription =>
      'Usa los filtros para encontrar actualizaciones, eventos y recordatorios. Toca una notificación para expandir o contraer su contenido.';

  @override
  String get helpAccountTitle => '¿Cómo cambiar el correo o la contraseña?';

  @override
  String get helpAccountDescription =>
      'Abre Configuración, entra en Editar cuenta y elige la información que deseas cambiar. Algunos cambios requieren una confirmación de seguridad.';

  @override
  String get helpContactTitle => '¿Aún necesitas ayuda?';

  @override
  String get helpContactDescription =>
      'Ponte en contacto con el equipo. Toca la dirección para copiarla.';

  @override
  String get helpCopyEmail => 'Copiar correo';

  @override
  String get helpEmailCopied => 'Correo de soporte copiado.';

  @override
  String get accountTitle => 'Cuenta';

  @override
  String get accountSecuritySection => 'Seguridad';

  @override
  String get accountChangeEmail => 'Cambiar correo electrónico';

  @override
  String get accountChangePassword => 'Cambiar contraseña';

  @override
  String get accountDelete => 'Eliminar cuenta';

  @override
  String get accountCurrentPasswordTitle => 'Confirma tu\ncontraseña actual';

  @override
  String get accountCurrentPassword => 'Contraseña actual';

  @override
  String get accountCurrentPasswordRequired => 'Ingresa tu contraseña actual';

  @override
  String get accountNewPasswordTitle => 'Crea una\nnueva contraseña';

  @override
  String get accountNewPassword => 'Nueva contraseña';

  @override
  String get accountPasswordMustDiffer =>
      'La nueva contraseña debe ser diferente de la actual';

  @override
  String get accountChangePasswordButton => 'Cambiar contraseña';

  @override
  String get accountPasswordChanged => 'Contraseña cambiada correctamente.';

  @override
  String get accountNewEmailTitle => 'Ingresa tu\nnuevo correo';

  @override
  String get accountNewEmail => 'Nuevo correo electrónico';

  @override
  String get accountEmailChangedTitle => '¡Correo confirmado!';

  @override
  String get accountEmailChangedSubtitle =>
      'Todo listo. Tu nuevo correo ya está vinculado a tu cuenta.';

  @override
  String get accountEmailChanged =>
      'Correo electrónico cambiado correctamente.';

  @override
  String get commonRetry => 'Intentar de nuevo';

  @override
  String get commonCancel => 'Cancelar';

  @override
  String get commonDelete => 'Eliminar';

  @override
  String get complementaryHoursTitle => 'Mi\nprogreso';

  @override
  String get complementaryHoursInformalNotice =>
      'Estimación personal. No acredita asistencia ni sustituye los registros del IFPR.';

  @override
  String get complementaryHoursLoadError =>
      'No se pudo cargar el contador de horas.';

  @override
  String complementaryHoursProgressSemantics(String completed, String target) {
    return '$completed de $target';
  }

  @override
  String get complementaryHoursRecords => 'Mis registros';

  @override
  String get complementaryHoursRecordsLoadError =>
      'No se pudieron cargar los registros.';

  @override
  String get complementaryHoursRecordsEmpty => 'Aún no hay registros.';

  @override
  String get complementaryHoursNoWorkload => 'Sin carga horaria';

  @override
  String get complementaryHoursDeleteTitle => '¿Eliminar registro?';

  @override
  String complementaryHoursDeleteMessage(String eventName) {
    return '“$eventName” se eliminará de tu contador informal.';
  }

  @override
  String get complementaryHoursDeleteError =>
      'No se pudo eliminar el registro.';

  @override
  String get complementaryHoursDeleted => 'Registro eliminado.';
}
