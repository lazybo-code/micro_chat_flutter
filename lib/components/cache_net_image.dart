import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CacheNetImage extends StatelessWidget {
  final String image;
  final String errorSvg;
  final String placeholderAccess;
  final Color loadingBackgroundColor;
  final double width;
  final double height;
  final BoxFit fit;
  final bool access;

  const CacheNetImage({
    Key key,
    this.image,
    this.errorSvg = 'svg/image_error.svg',
    this.placeholderAccess = 'images/style.png',
    this.loadingBackgroundColor = const Color(0xffffffff),
    this.width = 40,
    this.height = 40,
    this.fit = BoxFit.fitWidth,
    this.access = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (access == true) {
      return Container(
        color: loadingBackgroundColor,
        child: Image.asset(
          image,
          width: width,
          height: height,
          fit: fit,
        ),
      );
    }
    return CachedNetworkImage(
      width: width,
      height: height,
      imageUrl: image,
      fit: fit,
      placeholder: (context, url) => _imagePlaceholder(),
      errorWidget: (context, url, error) => _imagePlaceholder(),
    );
  }

  Widget _imagePlaceholder() {
    return Container(
      alignment: Alignment.center,
      color: loadingBackgroundColor,
      width: width,
      height: height,
      child: Image.asset(
        placeholderAccess,
        width: width,
        height: height,
        fit: fit,
      ),
    );
  }

  Widget _imageError() {
    return Container(
      alignment: Alignment.center,
      color: loadingBackgroundColor,
      width: width,
      height: height,
      child: SvgPicture.asset(
        errorSvg,
        width: width,
        height: height,
        fit: fit,
      ),
    );
  }
}
