import 'package:flutter/material.dart';

class GAppBarTitle extends StatelessWidget {
  const GAppBarTitle({Key key, this.login, this.title}) : assert(title != null);
  final String login;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        if (login != null) SizedBox(height: 4),
        if (login != null)
          Text("$login", style: Theme.of(context).textTheme.subtitle2),
        Text(title),
      ],
    );
  }
}
