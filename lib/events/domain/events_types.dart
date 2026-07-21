import 'package:autth_injustice_app/core/failure/failure.dart';
import 'package:autth_injustice_app/core/patterns/result.dart';
import 'package:autth_injustice_app/events/domain/models/event_details.dart';
import 'package:autth_injustice_app/events/domain/models/events_catalog.dart';

typedef EventsCatalogResult = Result<EventsCatalog, Failure>;
typedef EventDetailsResult = Result<EventDetails, Failure>;
typedef EventPersonalRecordResult = Result<bool, Failure>;

typedef EventsNoParams = ();
typedef EventIdParams = ({String eventId});
typedef EventPersonalRecordParams = ({
  String eventId,
  bool addedToPersonalHistory,
});
