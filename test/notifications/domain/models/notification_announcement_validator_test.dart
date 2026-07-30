import 'package:autth_injustice_app/notifications/domain/models/notification_announcement_draft.dart';
import 'package:autth_injustice_app/notifications/domain/models/notification_announcement_validator.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('NotificationAnnouncementValidator', () {
    test('accepts complete content with an optional link', () {
      const draft = NotificationAnnouncementDraft(
        title: 'Manutenção programada',
        message: 'O sistema ficará indisponível durante a tarde.',
        externalUrl: 'ifpr.edu.br/avisos',
      );

      expect(
        NotificationAnnouncementValidator.validateForPublishing(draft),
        isNull,
      );
      expect(draft.toInput().externalUrl, 'https://ifpr.edu.br/avisos');
    });

    test('rejects a short title', () {
      const draft = NotificationAnnouncementDraft(
        title: 'Oi',
        message: 'Uma descrição válida para o aviso.',
      );

      expect(
        NotificationAnnouncementValidator.validateForPublishing(draft),
        NotificationAnnouncementValidationIssue.invalidTitle,
      );
    });

    test('rejects a short description', () {
      const draft = NotificationAnnouncementDraft(
        title: 'Aviso importante',
        message: 'Curta',
      );

      expect(
        NotificationAnnouncementValidator.validateForPublishing(draft),
        NotificationAnnouncementValidationIssue.invalidMessage,
      );
    });

    test('rejects a non-web external link', () {
      const draft = NotificationAnnouncementDraft(
        title: 'Aviso importante',
        message: 'Uma descrição válida para o aviso.',
        externalUrl: 'arquivo://interno',
      );

      expect(
        NotificationAnnouncementValidator.validateForPublishing(draft),
        NotificationAnnouncementValidationIssue.invalidExternalLink,
      );
    });
  });
}
