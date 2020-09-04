import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_github_connect/ui/theme/export_theme.dart';

class GLoader extends StatelessWidget {
  final double stroke;

  const GLoader({Key key, this.stroke = 4}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Platform.isAndroid
          ? CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation(GColors.blue),
              strokeWidth: stroke,
            )
          : CupertinoActivityIndicator(),
    );
  }
}
