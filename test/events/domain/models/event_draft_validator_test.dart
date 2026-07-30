import 'package:autth_injustice_app/events/domain/models/event_draft_validator.dart';
import 'package:autth_injustice_app/events/domain/models/event_editor_draft.dart';
import 'package:autth_injustice_app/events/domain/models/event_timing.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../support/test_event_categories.dart';

void main() {
  group('EventDraftValidator', () {
    final now = DateTime(2026, 8, 1, 10);

    test('accepts a complete draft with optional location omitted', () {
      final draft = _validDraft(now).copyWith(location: null);

      expect(
        EventDraftValidator.validateForCreation(draft, now: now),
        isNull,
      );
    });

    test('rejects automatic end before the event start', () {
      final draft = _validDraft(now).copyWith(
        endsAt: now.add(const Duration(minutes: 30)),
      );

      expect(
        EventDraftValidator.validateForCreation(draft, now: now),
        EventDraftValidationIssue.invalidEnd,
      );
    });

    test('rejects scheduled publication at or after the event start', () {
      final draft = _validDraft(now);
      final invalid = draft.copyWith(publishAt: draft.startsAt);

      expect(
        EventDraftValidator.validateForCreation(invalid, now: now),
        EventDraftValidationIssue.publicationAfterStart,
      );
    });

    test('rejects zero workload when complementary hours are enabled', () {
      final draft = _validDraft(now).copyWith(complementaryMinutes: 0);

      expect(
        EventDraftValidator.validateForCreation(draft, now: now),
        EventDraftValidationIssue.invalidComplementaryHours,
      );
    });

    test('creates a trimmed backend input only after validation', () {
      final draft = _validDraft(now).copyWith(
        title: '  Feira de projetos  ',
        location: '  Auditório  ',
        description: '  Exposição dos projetos desenvolvidos no campus.  ',
      );

      expect(
        EventDraftValidator.validateForCreation(draft, now: now),
        isNull,
      );

      final input = draft.toCreationInput();
      expect(input.title, 'Feira de projetos');
      expect(input.locationLabel, 'Auditório');
      expect(
        input.description,
        'Exposição dos projetos desenvolvidos no campus.',
      );
    });
  });
}

EventEditorDraft _validDraft(DateTime now) {
  final startsAt = now.add(const Duration(days: 2));
  return EventEditorDraft(
    title: 'Feira de projetos',
    category: TestEventCategories.academic,
    startsAt: startsAt,
    endMode: EventEndMode.automatic,
    endsAt: startsAt.add(const Duration(hours: 3)),
    description: 'Exposição dos projetos desenvolvidos no campus.',
    complementaryMinutes: 90,
    selectedImageSource: 'C:/tmp/event.jpg',
    publishAt: now.add(const Duration(hours: 1)),
  );
}
