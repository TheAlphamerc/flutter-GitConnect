import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_github_connect/helper/GIcons.dart';
import 'package:flutter_github_connect/ui/theme/images.dart';

Widget customNetworkImage(
  String path, {
  BoxFit fit = BoxFit.contain,
  Widget placeholder,
  double height,
  Widget progressIndicatorBuilder,
}) {
  // assert(path!=null);
  if (path == null || path.isEmpty) {
    return Image.asset(GImages.octocatIconDark120);
  }
  return CachedNetworkImage(
    fit: fit,
    imageUrl: path,
    height: height,
    fadeInCurve: Curves.easeInCubic,
    fadeInDuration: Duration(milliseconds: 500),
    progressIndicatorBuilder: (context, yrl, progress) {
      if (progressIndicatorBuilder != null) return progressIndicatorBuilder;
      return Center(child: Icon(GIcons.github));
    },
    placeholderFadeInDuration: Duration(milliseconds: 500),
    placeholder: (context, url) => Container(
      color: Color(0xffeeeeee),
    ),
    errorWidget: (context, url, error) =>
        placeholder != null ? placeholder : Icon(Icons.error),
  );
}
