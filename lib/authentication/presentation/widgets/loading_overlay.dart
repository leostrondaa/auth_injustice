import 'package:flutter/material.dart';
import 'package:signals_flutter/signals_flutter.dart';

class LoadingOverlay extends StatelessWidget {
  final ReadonlySignal<bool> loading;
  final Widget child;

  const LoadingOverlay({
    super.key,
    required this.loading,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        Watch((context) {
          if (!loading.value) {
            return const SizedBox.shrink();
          }

          return ColoredBox(
            color: Colors.black45,
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          );
        }),
      ],
    );
  }
}
