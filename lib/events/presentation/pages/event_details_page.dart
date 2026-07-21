import 'dart:async';

import 'package:autth_injustice_app/authentication/presentation/navigation/auth_routes.dart';
import 'package:autth_injustice_app/core/di/dependency_injection.dart';
import 'package:autth_injustice_app/core/extensions/responsive_extensions.dart';
import 'package:autth_injustice_app/core/theme/app_theme.dart';
import 'package:autth_injustice_app/events/presentation/viewmodels/event_details/event_details_viewmodel.dart';
import 'package:autth_injustice_app/events/presentation/widgets/event_details/event_details_actions.dart';
import 'package:autth_injustice_app/events/presentation/widgets/event_details/event_details_hero.dart';
import 'package:autth_injustice_app/events/presentation/widgets/event_details/event_details_status.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:signals_flutter/signals_flutter.dart';

class EventDetailsPage extends StatefulWidget {
  final String eventId;

  const EventDetailsPage({
    super.key,
    required this.eventId,
  });

  @override
  State<EventDetailsPage> createState() => _EventDetailsPageState();
}

class _EventDetailsPageState extends State<EventDetailsPage> {
  late final EventDetailsViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = injector.get<EventDetailsViewModel>();
    unawaited(_viewModel.commands.loadEvent(widget.eventId));
  }

  void _openMap() {
    context.goNamed(AuthRouteNames.initial);
    //context.goNamed(MapRouteNames.map);
  }

  @override
  Widget build(BuildContext context) {
    final isCompact =
        context.isVerySmallScreen || context.screenSize.width < 360;

    return Scaffold(
      backgroundColor: context.tertiary,
      body: Watch(
        (_) {
          final state = _viewModel.state;
          final event = state.event.value;
          final errorMessage = state.errorMessage.value;

          if (state.loading.value && event == null) {
            return const EventDetailsStatus.loading();
          }

          if (event == null) {
            return EventDetailsStatus.error(
              message: errorMessage ?? 'Evento não encontrado.',
              onBack: context.pop,
              onRetry: () => unawaited(
                _viewModel.commands.loadEvent(widget.eventId),
              ),
            );
          }

          return Column(
            children: [
              Expanded(
                child: EventDetailsHero(
                  event: event,
                  complementaryHours: state.complementaryHours.value,
                  isCompact: isCompact,
                  onBack: context.pop,
                ),
              ),
              SafeArea(
                top: false,
                minimum: EdgeInsets.only(bottom: isCompact ? 88 : 102),
                child: Padding(
                  padding: context.extraPagePadding.copyWith(top: 12),
                  child: EventDetailsActions(
                    addedToPersonalHistory: state.addedToPersonalHistory.value,
                    personalRecordUpdating: state.updatingPersonalRecord.value,
                    onPersonalRecordTap:
                        _viewModel.commands.togglePersonalRecord,
                    onMapTap: _openMap,
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
