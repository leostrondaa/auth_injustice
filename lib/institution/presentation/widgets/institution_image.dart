import 'package:autth_injustice_app/institution/domain/models/institution_resource.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class InstitutionImage extends StatelessWidget {
  final InstitutionResource resource;
  final double? width;
  final double? height;
  final BoxFit fit;
  final Widget Function(BuildContext, Object, StackTrace?)? errorBuilder;

  const InstitutionImage({
    super.key,
    required this.resource,
    this.width,
    this.height,
    this.fit = BoxFit.contain,
    this.errorBuilder,
  });

  @override
  Widget build(BuildContext context) {
    if (resource.isVector) {
      return resource.isBundled
          ? SvgPicture.asset(
              resource.location,
              width: width,
              height: height,
              fit: fit,
            )
          : SvgPicture.network(
              resource.location,
              width: width,
              height: height,
              fit: fit,
            );
    }

    return resource.isBundled
        ? Image.asset(
            resource.location,
            width: width,
            height: height,
            fit: fit,
            errorBuilder: errorBuilder,
          )
        : Image.network(
            resource.location,
            width: width,
            height: height,
            fit: fit,
            errorBuilder: errorBuilder,
          );
  }
}
