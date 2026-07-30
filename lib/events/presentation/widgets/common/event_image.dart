import 'dart:io';

import 'package:flutter/material.dart';

class EventImage extends StatelessWidget {
  final String source;
  final BoxFit fit;
  final Widget error;

  const EventImage({
    super.key,
    required this.source,
    required this.error,
    this.fit = BoxFit.cover,
  });

  @override
  Widget build(BuildContext context) {
    if (source.trim().isEmpty) return error;

    if (source.startsWith('assets/')) {
      return Image.asset(
        source,
        fit: fit,
        gaplessPlayback: true,
        errorBuilder: (_, __, ___) => error,
      );
    }

    final uri = Uri.tryParse(source);
    final isRemote = uri != null &&
        (uri.scheme.toLowerCase() == 'http' ||
            uri.scheme.toLowerCase() == 'https');

    if (isRemote) {
      return Image.network(
        source,
        fit: fit,
        errorBuilder: (_, __, ___) => error,
      );
    }

    return Image.file(
      File(source),
      fit: fit,
      errorBuilder: (_, __, ___) => error,
    );
  }
}
