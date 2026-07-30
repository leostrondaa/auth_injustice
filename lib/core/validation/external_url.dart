abstract final class ExternalUrl {
  static const maxLength = 500;

  static bool isValidOptional(String? value) {
    final trimmed = value?.trim() ?? '';
    return trimmed.isEmpty || normalize(trimmed) != null;
  }

  static String? normalize(String? value) {
    final trimmed = value?.trim() ?? '';
    if (trimmed.isEmpty || trimmed.length > maxLength) return null;

    final candidate = trimmed.contains('://') ? trimmed : 'https://$trimmed';
    final uri = Uri.tryParse(candidate);
    if (uri == null ||
        (uri.scheme != 'https' && uri.scheme != 'http') ||
        uri.host.isEmpty ||
        uri.userInfo.isNotEmpty) {
      return null;
    }

    return uri.toString();
  }
}
