import 'dart:async';

import 'package:autth_injustice_app/core/di/dependency_injection.dart';
import 'package:autth_injustice_app/core/extensions/responsive_extensions.dart';
import 'package:autth_injustice_app/core/l10n/l10n_extensions.dart';
import 'package:autth_injustice_app/core/theme/app_theme.dart';
import 'package:autth_injustice_app/core/widgets/app_entrance_transition.dart';
import 'package:autth_injustice_app/events/domain/models/event_preview.dart';
import 'package:autth_injustice_app/events/presentation/navigation/events_routes.dart';
import 'package:autth_injustice_app/events/presentation/viewmodels/events_catalog/events_catalog_viewmodel.dart';
import 'package:autth_injustice_app/events/presentation/widgets/events_catalog/event_banner_rail.dart';
import 'package:autth_injustice_app/events/presentation/widgets/events_catalog/events_catalog_status.dart';
import 'package:autth_injustice_app/events/presentation/widgets/events_catalog/events_section_title.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:signals_flutter/signals_flutter.dart';

class EventsCatalogPage extends StatefulWidget {
  const EventsCatalogPage({super.key});

  @override
  State<EventsCatalogPage> createState() => _EventsCatalogPageState();
}

class _EventsCatalogPageState extends State<EventsCatalogPage> {
  late final EventsCatalogViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = injector.get<EventsCatalogViewModel>();
    unawaited(_viewModel.commands.loadCatalog(forceRefresh: true));
  }

  void _openEvent(BuildContext context, EventPreview event) {
    context.pushNamed(
      EventsRouteNames.details,
      pathParameters: {'eventId': event.id},
    );
  }

  @override
  Widget build(BuildContext context) {
    final isCompact =
        context.isVerySmallScreen || context.screenSize.width < 360;

    return Scaffold(
      backgroundColor: context.tertiary,
      body: SafeArea(
        bottom: false,
        child: Watch(
          (_) {
            final state = _viewModel.state;
            final featuredEvents = state.featuredEvents.value;
            final futureEvents = state.futureEvents.value;
            final errorMessage = state.errorMessage.value;

            if (state.loading.value && !state.hasEvents) {
              return const EventsCatalogStatus.loading();
            }

            if (errorMessage != null && !state.hasEvents) {
              return EventsCatalogStatus.error(
                message: errorMessage,
                onRetry: () => unawaited(
                  _viewModel.commands.loadCatalog(forceRefresh: true),
                ),
              );
            }

            return LayoutBuilder(builder: (context, constraints) {
              final headerSpace = isCompact ? 130.0 : 161.0;
              final secondSectionSpace = isCompact ? 70.0 : 85.0;
              final navigationClearance = isCompact ? 88.0 : 102.0;
              final railSpace = (constraints.maxHeight -
                      headerSpace -
                      secondSectionSpace -
                      navigationClearance)
                  .clamp(220.0, 520.0)
                  .toDouble();

              final featuredHeight = railSpace * 0.56;
              final futureHeight = railSpace * 0.44;

              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  AppEntranceTransition(
                    child: Padding(
                      padding: context.extraPagePadding.copyWith(
                        top: isCompact ? 24 : 34,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            context.l10n.eventsTitle,
                            style: context.displayLarge?.copyWith(
                              color: context.onTertiary,
                              fontSize: isCompact ? 40 : 48,
                            ),
                          ),
                          SizedBox(height: isCompact ? 28 : 36),
                          EventsSectionTitle(
                            title: context.l10n.featuredEvents,
                          ),
                          const SizedBox(height: 14),
                        ],
                      ),
                    ),
                  ),
                  AppEntranceTransition(
                    delay: const Duration(milliseconds: 50),
                    child: EventBannerRail(
                      events: featuredEvents,
                      isCompact: isCompact,
                      large: true,
                      height: featuredHeight,
                      onEventTap: (event) => _openEvent(context, event),
                    ),
                  ),
                  AppEntranceTransition(
                    delay: const Duration(milliseconds: 110),
                    child: Padding(
                      padding: context.extraPagePadding.copyWith(
                        top: isCompact ? 32 : 42,
                        bottom: 14,
                      ),
                      child: EventsSectionTitle(
                        title: context.l10n.futureEvents,
                      ),
                    ),
                  ),
                  AppEntranceTransition(
                    delay: const Duration(milliseconds: 160),
                    child: EventBannerRail(
                      events: futureEvents,
                      isCompact: isCompact,
                      large: false,
                      height: futureHeight,
                      onEventTap: (event) => _openEvent(context, event),
                    ),
                  ),
                  SizedBox(height: navigationClearance),
                ],
              );
            });
          },
        ),
      ),
    );
  }
}
