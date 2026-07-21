import 'package:autth_injustice_app/core/formatters/hours_minutes_formatter.dart';
import 'package:autth_injustice_app/core/formatters/app_date_time_formatter.dart';
import 'package:autth_injustice_app/core/extensions/responsive_extensions.dart';
import 'package:autth_injustice_app/core/theme/app_theme.dart';
import 'package:autth_injustice_app/events/domain/models/event_preview.dart';
import 'package:flutter/material.dart';

class EventDetailsHero extends StatelessWidget {
  final EventPreview event;
  final double? complementaryHours;
  final bool isCompact;
  final VoidCallback onBack;

  const EventDetailsHero({
    super.key,
    required this.event,
    this.complementaryHours,
    required this.isCompact,
    required this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    final horizontalPadding = context.extraPagePadding.left;

    return SizedBox.expand(
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.network(
            event.imageUrl,
            fit: BoxFit.cover,
            errorBuilder: (_, __, ___) => ColoredBox(
              color: context.colors.surfaceContainerHighest,
              child: const Icon(Icons.image_not_supported_outlined),
            ),
          ),
          DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.transparent,
                  context.tertiary.withValues(alpha: 0.42),
                  context.tertiary,
                ],
                stops: const [0.32, 0.68, 1],
              ),
            ),
          ),
          SafeArea(
            bottom: false,
            child: Padding(
              padding: EdgeInsets.only(
                left: horizontalPadding,
                top: isCompact ? 10 : 16,
              ),
              child: Align(
                alignment: Alignment.topLeft,
                child: Material(
                  color: Colors.black.withValues(alpha: 0.30),
                  shape: const CircleBorder(),
                  child: InkWell(
                    onTap: onBack,
                    customBorder: const CircleBorder(),
                    child: const SizedBox(
                      width: 44,
                      height: 44,
                      child: Icon(
                        Icons.arrow_back_rounded,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            left: horizontalPadding,
            right: horizontalPadding,
            bottom: isCompact ? 28 : 36,
            child: _HeroText(
              event: event,
              complementaryHours: complementaryHours,
            ),
          ),
        ],
      ),
    );
  }
}

class _HeroText extends StatefulWidget {
  final EventPreview event;
  final double? complementaryHours;

  const _HeroText({
    required this.event,
    required this.complementaryHours,
  });

  @override
  State<_HeroText> createState() => _HeroTextState();
}

class _HeroTextState extends State<_HeroText>
    with SingleTickerProviderStateMixin {
  late final AnimationController _contentController;
  late final Animation<Offset> _textSlide;
  late final Animation<double> _textOpacity;

  @override
  void initState() {
    super.initState();

    _contentController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 450),
    );
    _textSlide =
        Tween<Offset>(begin: const Offset(0, -0.4), end: Offset.zero).animate(
      CurvedAnimation(
        parent: _contentController,
        curve: const Interval(0.3, 1, curve: Curves.easeOutCubic),
      ),
    );
    _textOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _contentController,
        curve: const Interval(0.0, 0.9, curve: Curves.easeOut),
      ),
    );

    _contentController.forward();
  }

  @override
  void dispose() {
    _contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isCompact =
        context.isVerySmallScreen || context.screenSize.width < 360;
    final metaPills = <Widget>[
      _EventMetaPill(
        icon: Icons.calendar_today_outlined,
        label: AppDateTimeFormatter.eventDateTime(
          context,
          widget.event.startsAt,
        ),
        isCompact: isCompact,
      ),
      _EventMetaPill(
        icon: Icons.location_on_outlined,
        label: widget.event.location,
        isCompact: isCompact,
      ),
      if (widget.complementaryHours case final hours?)
        _EventMetaPill(
          icon: Icons.schedule_outlined,
          label: HoursMinutesFormatter.format(hours),
          isCompact: isCompact,
        ),
    ];

    return SlideTransition(
      position: _textSlide,
      child: FadeTransition(
        opacity: _textOpacity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.event.category.toUpperCase(),
              style: context.text.labelLarge?.copyWith(
                fontSize: isCompact
                    ? context.text.labelSmall?.fontSize
                    : context.text.labelLarge?.fontSize,
                color: context.primary,
                shadows: [
                  Shadow(
                    color: Colors.black.withValues(alpha: 0.75),
                    blurRadius: isCompact ? 6 : 9,
                  ),
                ],
              ),
            ),
            SizedBox(height: isCompact ? 6 : 8),
            Text(
              widget.event.title,
              style: context.displaySmall?.copyWith(
                fontSize: isCompact
                    ? context.text.displaySmall?.fontSize
                    : context.text.displayMedium?.fontSize,
                color: context.onTertiary,
              ),
            ),
            const SizedBox(height: 10),
            if (isCompact)
              SizedBox(
                width: double.infinity,
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  alignment: Alignment.centerLeft,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      for (var index = 0;
                          index < metaPills.length;
                          index++) ...[
                        if (index > 0) const SizedBox(width: 7),
                        metaPills[index],
                      ],
                    ],
                  ),
                ),
              )
            else
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: metaPills,
              ),
            const SizedBox(height: 8),
            Text(
              widget.event.description,
              style: context.bodySmall?.copyWith(
                color: context.onTertiary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _EventMetaPill extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isCompact;

  const _EventMetaPill({
    required this.icon,
    required this.label,
    required this.isCompact,
  });

  @override
  Widget build(BuildContext context) {
    final color = context.onTertiary;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isCompact ? 7 : 10,
        vertical: isCompact ? 5 : 7,
      ),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.10),
        borderRadius: BorderRadius.circular(isCompact ? 8 : 10),
        border: Border.all(
          color: color.withValues(alpha: 0.16),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: isCompact ? 13 : 15,
            color: color.withValues(alpha: 0.82),
          ),
          SizedBox(width: isCompact ? 4 : 6),
          Text(
            label,
            maxLines: 1,
            style: context.bodySmall?.copyWith(
              color: color.withValues(alpha: 0.88),
              fontSize: isCompact ? 10 : null,
            ),
          ),
        ],
      ),
    );
  }
}
