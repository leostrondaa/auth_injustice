import 'package:autth_injustice_app/institution/domain/models/institution_resource.dart';
import 'package:flutter/foundation.dart';

enum InstitutionMapFormat {
  glb,
  gltf,
  tiles3d,
  custom,
}

@immutable
class InstitutionMapManifest {
  final String mapId;
  final int version;
  final String rendererKey;
  final InstitutionMapFormat format;
  final InstitutionResource? primaryResource;
  final InstitutionResource? metadataResource;
  final List<InstitutionResource> supportingResources;

  const InstitutionMapManifest({
    required this.mapId,
    required this.version,
    required this.rendererKey,
    required this.format,
    required this.primaryResource,
    this.metadataResource,
    this.supportingResources = const [],
  });

  const InstitutionMapManifest.unconfigured({
    required this.mapId,
    required this.rendererKey,
    this.format = InstitutionMapFormat.glb,
  })  : version = 0,
        primaryResource = null,
        metadataResource = null,
        supportingResources = const [];

  bool get isConfigured => primaryResource != null;

  Iterable<InstitutionResource> get allResources sync* {
    final primary = primaryResource;
    final metadata = metadataResource;

    if (primary != null) yield primary;
    if (metadata != null) yield metadata;
    yield* supportingResources;
  }
}
