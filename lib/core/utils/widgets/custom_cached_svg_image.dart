import 'package:cached_network_image/cached_network_image.dart';
import 'package:cached_network_svg_image/cached_network_svg_image.dart';
import 'package:flutter/material.dart';
import 'package:sahab/core/const.dart';

class CustomCachedIconImage extends StatelessWidget {
  const CustomCachedIconImage({
    super.key,
    required this.imageUrl,
    this.height,
    this.width,
  });

  final String? imageUrl;
  final double? height;
  final double? width;
  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl!,
      errorWidget: (context, url, error) => Image.asset(
        Constant.knoLogoImage,
      ), // const Icon(Icons.error, color: Colors.red),
      width: width,
      height: height,
      // fadeDuration: const Duration(milliseconds: 500),
    );
  }
}

class CustomCachedSvgImage extends StatelessWidget {
  const CustomCachedSvgImage({
    super.key,
    required this.imageUrl,
    this.height,
    this.width,
  });

  final String? imageUrl;
  final double? height;
  final double? width;
  @override
  Widget build(BuildContext context) {
    return CachedNetworkSVGImage(
      imageUrl!,
      errorWidget: Image.asset(
        Constant.knoLogoImage,
      ), // const Icon(Icons.error, color: Colors.red),
      width: width,
      height: height,
      fadeDuration: const Duration(milliseconds: 500),
    );
  }
}
