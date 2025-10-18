import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CustomSvgPictureWidget extends StatelessWidget {
  CustomSvgPictureWidget({
    super.key,
    required this.path,
    this.withColorFilter = true,
    this.height,
    this.width,
  });
  final String? path;
  bool withColorFilter;
  double? height;
  double? width;
  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      path!,
      colorFilter: withColorFilter
          ? ColorFilter.mode(
              Theme.of(context).colorScheme.secondary,
              BlendMode.srcIn,
            )
          : null,
    );
  }
}
