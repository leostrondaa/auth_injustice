import 'package:autth_injustice_app/events/presentation/widgets/common/event_card_visual_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('event accent palette repeats consistently', () {
    expect(
      EventCardVisualStyle.accentAt(0),
      EventCardVisualStyle.accentAt(5),
    );
  });

  testWidgets('event card elevation has visible blur below the card',
      (tester) async {
    late List<BoxShadow> shadows;

    await tester.pumpWidget(
      MaterialApp(
        home: Builder(
          builder: (context) {
            shadows = EventCardVisualStyle.shadows(
              context,
              accentColor: Colors.blue,
            );
            return const SizedBox.shrink();
          },
        ),
      ),
    );

    expect(shadows, hasLength(2));
    expect(shadows.every((shadow) => shadow.blurRadius > 0), isTrue);
    expect(shadows.every((shadow) => shadow.offset.dy > 0), isTrue);
  });
}
