# Backend integration guide

The presentation layer must keep depending on repositories, use cases and
facades. Firebase-specific code belongs only in data service implementations.

## Current development bindings

`lib/core/di/dependency_injection.dart` currently binds these demo adapters:

- `DemoCurrentAccountProvider`
- `DemoEventsService`
- `DemoNotificationsService`
- `DemoComplementaryHoursService`
- `DemoAccountSecurityService`

For production, replace those bindings with Firebase implementations of the
same interfaces. Pages, commands and viewmodels should not change.

## Suggested Firestore shape

```text
accounts/{uid}
  email
  displayName
  createdAt
  updatedAt
  isProfileConfigured
  role: student | eventManager | administrator

events/{eventId}
  title
  category
  description
  location
  imageUrl
  startsAt: Timestamp
  workloadMinutes: int | null

accounts/{uid}/eventRecords/{eventId}
  eventName
  eventDate: Timestamp
  workloadMinutes: int | null
  createdAt: Timestamp

accounts/{uid}/notifications/{notificationId}
  type
  title
  message
  createdAt: Timestamp
  isRead
```

Titles, descriptions and notification bodies are creator-authored content and
must be stored as entered. Dates, relative times, filters and application
labels are localized by the client.

## Workload

Store workload as integer minutes. An admin form with separate hour and minute
fields converts with:

```dart
final totalMinutes = (hours * 60) + minutes;
```

The app already treats minutes as the source of truth and derives decimal
hours only for the existing visual gauge.

## Roles and security

- `student`: consumes events and manages only their own history.
- `eventManager`: may create, edit, publish and archive events.
- `administrator`: has event permissions and may manage accounts and roles.

`AuthorizationService` controls what the client displays. It is not a security
boundary. Firestore rules or privileged server functions must repeat every
authorization check.

Users may read their own `role`, but normal profile updates must never write
it. `AccountFirestoreMapper.toProfileUpdateMap` intentionally omits the role.
Role assignment should be performed only by a privileged backend operation or
the Firebase Admin SDK.

## Identity scope

Catalog data may be public. Event personalization, notifications and hour
records always receive an authenticated `uid` through
`ICurrentAccountProvider`. Never accept a user-selected uid for those writes.
