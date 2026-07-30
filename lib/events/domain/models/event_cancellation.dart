abstract final class EventCancellationRules {
  static const reasonMinLength = 10;
  static const reasonMaxLength = 500;

  static bool isValidReason(String reason) {
    final length = reason.trim().length;
    return length >= reasonMinLength && length <= reasonMaxLength;
  }
}
