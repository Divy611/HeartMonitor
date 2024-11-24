import 'package:flutter/material.dart';
import 'package:heartmonitor/navigator/constants.dart';
import 'package:cached_network_image/cached_network_image.dart';

class CacheImage extends StatelessWidget {
  const CacheImage({
    super.key,
    this.path,
    this.fit = BoxFit.contain,
    this.errorWidget,
  });
  final String? path;
  final BoxFit fit;
  final Widget? errorWidget;

  Widget customNetworkImage(String? path, {BoxFit fit = BoxFit.contain}) {
    return CachedNetworkImage(
      fit: fit,
      imageUrl: path ?? Constants.profp,
      imageBuilder: (context, imageProvider) => Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: imageProvider,
            fit: fit,
          ),
        ),
      ),
      placeholderFadeInDuration: Duration(milliseconds: 500),
      placeholder: (context, url) => Container(
        color: Color(0xffeeeeee),
      ),
      cacheKey: path,
      errorWidget: (context, url, error) =>
          errorWidget ??
          Container(
            color: Color(0xffeeeeee),
            child: Icon(
              Icons.error,
              color: Colors.grey[700],
            ),
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return customNetworkImage(path, fit: fit);
  }
}
