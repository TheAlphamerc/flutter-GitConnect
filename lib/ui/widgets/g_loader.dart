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


class GCLoader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: 60,
      child: SizedBox(
        height: 30,
        width: 30,
        child: GLoader(stroke: 1),
      ),
    );
  }
}
