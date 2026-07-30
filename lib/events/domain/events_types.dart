import 'package:autth_injustice_app/core/failure/failure.dart';
import 'package:autth_injustice_app/core/patterns/result.dart';
import 'package:autth_injustice_app/events/domain/models/event_details.dart';
import 'package:autth_injustice_app/events/domain/models/event_editor_draft.dart';
import 'package:autth_injustice_app/events/domain/models/events_catalog.dart';

typedef EventsCatalogResult = Result<EventsCatalog, Failure>;
typedef EventDetailsResult = Result<EventDetails, Failure>;
typedef EventCreationResult = Result<EventDetails, Failure>;
typedef EventUpdateResult = Result<EventDetails, Failure>;
typedef EventPersonalRecordResult = Result<bool, Failure>;
typedef EventDeletionResult = Result<bool, Failure>;
typedef EventCancellationResult = Result<bool, Failure>;
typedef EventEndResult = Result<bool, Failure>;

typedef EventsNoParams = ();
typedef EventIdParams = ({String eventId});
typedef CreateEventParams = ({EventEditorDraft draft});
typedef UpdateEventParams = ({
  String eventId,
  EventEditorDraft draft,
});
typedef DeleteEventParams = ({String eventId});
typedef CancelEventParams = ({
  String eventId,
  String reason,
});
typedef EndEventParams = ({String eventId});
typedef EventPersonalRecordParams = ({
  String eventId,
  bool addedToPersonalHistory,
});
