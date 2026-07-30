import 'package:autth_injustice_app/events/domain/events_types.dart';
import 'package:autth_injustice_app/events/domain/models/event_creation_input.dart';
import 'package:autth_injustice_app/events/domain/models/event_update_input.dart';

abstract interface class IEventsService {
  Future<EventsCatalogResult> getCatalog();

  Future<EventsCatalogResult> getManagementCatalog({
    required String actorUid,
  });

  Future<EventDetailsResult> getEventDetails({
    String? uid,
    required String eventId,
  });

  Future<EventPersonalRecordResult> setPersonalRecord({
    required String uid,
    required String eventId,
    required bool addedToPersonalHistory,
  });

  /// Creates an event as an authorized event manager.
  ///
  /// A production adapter stores bundled and remote sources as-is. A source
  /// selected from the device must be uploaded first and replaced by its URL.
  Future<EventCreationResult> createEvent({
    required String actorUid,
    required EventCreationInput input,
  });

  /// Replaces the editable event data as an authorized event manager.
  ///
  /// When [input.replacementImageSource] is present, a production adapter
  /// stores bundled and remote sources as-is or uploads a device file first.
  /// Without a replacement, the existing image must be preserved.
  Future<EventUpdateResult> updateEvent({
    required String actorUid,
    required String eventId,
    required EventUpdateInput input,
  });

  /// Deletes an event as an authorized event manager.
  ///
  /// The production adapter must enforce the same permission server-side.
  Future<EventDeletionResult> deleteEvent({
    required String actorUid,
    required String eventId,
  });

  /// Cancels a published event and emits its campus-wide notification.
  ///
  /// The production adapter must persist the cancellation and notification
  /// atomically so the catalog and feed cannot disagree.
  Future<EventCancellationResult> cancelEvent({
    required String actorUid,
    required String eventId,
    required String reason,
  });

  /// Ends an ongoing event before its automatic end or closes a manual event.
  ///
  /// A production adapter must write the server timestamp to `endedAt`.
  Future<EventEndResult> endEvent({
    required String actorUid,
    required String eventId,
  });
}
