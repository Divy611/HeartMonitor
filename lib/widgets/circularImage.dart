import 'package:flutter/material.dart';
import 'package:heartmonitor/navigator/constants.dart';
import 'package:cached_network_image/cached_network_image.dart';

class CircularImage extends StatelessWidget {
  const CircularImage(
      {super.key, this.path, this.height = 50, this.isBorder = false});
  final String? path;
  final double height;
  final bool isBorder;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
      ),
      child: CircleAvatar(
        maxRadius: height / 2,
        backgroundColor: Theme.of(context).cardColor,
        backgroundImage: customAdvanceNetworkImage(path ?? Constants.profp),
      ),
    );
  }
}

class SquareImage extends StatelessWidget {
  const SquareImage(
      {super.key, this.path, this.height = 50, this.isBorder = false});
  final String? path;
  final double height;
  final bool isBorder;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(11.5)),
          image: DecorationImage(
            image: customAdvanceNetworkImage(path ?? Constants.profp),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}

ImageProvider customAdvanceNetworkImage(String? path) {
  if (path == null || path.isEmpty) {
    return AssetImage(Constants.profp);
  } else if (path.startsWith('http')) {
    return CachedNetworkImageProvider(
      path,
      cacheKey: path,
    );
  } else {
    return AssetImage(path);
  }
}
