import 'package:flutter/material.dart';
import 'package:flutter_github_connect/ui/theme/export_theme.dart';
import "package:build_context/build_context.dart";
class TypograpgyWidget extends StatefulWidget {
  TypograpgyWidget({Key key}) : super(key: key);

  @override
  _TypograpgyWidgetState createState() => _TypograpgyWidgetState();
}

class _TypograpgyWidgetState extends State<TypograpgyWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Text("H1", style: context.textTheme.headline1).p(8),
          Text("H2", style: context.textTheme.headline2).p(8),
          Text("H3", style: context.textTheme.headline3).p(8),
          Text("H4", style: context.textTheme.headline4).p(8),
          Text("H5", style: context.textTheme.headline5).p(8),
          Text("H6", style: context.textTheme.headline6).p(8),
          Text("Subtitle1", style: context.textTheme.subtitle1).p(8),
          Text("Subtitle2", style: context.textTheme.subtitle2).p(8),
          Text("Body1", style: context.textTheme.bodyText1).p(8),
          Text("Body2", style: context.textTheme.bodyText2).p(8),
          Text("Button", style: context.textTheme.button).p(8),
          Text("Caption", style: context.textTheme.caption).p(8),
          Text("Overline", style: context.textTheme.overline).p(8),

        ],
      ),
    );
  }
}
