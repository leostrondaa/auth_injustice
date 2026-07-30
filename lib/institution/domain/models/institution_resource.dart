import 'package:flutter/foundation.dart';

enum InstitutionResourceSource {
  bundledAsset,
  remote,
}

enum InstitutionResourceKind {
  rasterImage,
  vectorImage,
  mapBundle,
  mapMetadata,
  other,
}

@immutable
class InstitutionResource {
  final InstitutionResourceSource source;
  final InstitutionResourceKind kind;
  final String location;
  final String? checksumSha256;
  final String? contentType;

  const InstitutionResource.asset({
    required String path,
    required this.kind,
    this.checksumSha256,
    this.contentType,
  })  : source = InstitutionResourceSource.bundledAsset,
        location = path,
        assert(path != '');

  const InstitutionResource.remote({
    required String url,
    required this.kind,
    this.checksumSha256,
    this.contentType,
  })  : source = InstitutionResourceSource.remote,
        location = url,
        assert(url != '');

  bool get isBundled => source == InstitutionResourceSource.bundledAsset;

  bool get isRemote => source == InstitutionResourceSource.remote;

  bool get isVector =>
      kind == InstitutionResourceKind.vectorImage ||
      location.toLowerCase().endsWith('.svg');
}
