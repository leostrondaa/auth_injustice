import 'package:autth_injustice_app/core/validation/external_url.dart';

abstract final class EventExternalLink {
  static const maxLength = ExternalUrl.maxLength;

  static bool isValidOptional(String? value) =>
      ExternalUrl.isValidOptional(value);

  static String? normalize(String? value) => ExternalUrl.normalize(value);
}
