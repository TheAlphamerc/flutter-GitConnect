import 'package:flutter/material.dart';
import 'package:flutter_github_connect/ui/theme/custom_theme.dart';

class GitApp extends StatefulWidget {
  final Widget home;

  const GitApp({
    Key key,
    @required this.home,
  }) : super(key: key);

  static void setLocale(BuildContext context, Locale newLocale) {
    _AppState state = context.findAncestorStateOfType<_AppState>();
    state.setLocale(newLocale);
  }

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<GitApp> {


  Locale _locale;
  setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

 

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateTitle: (BuildContext context) => "",
      locale: _locale,
      supportedLocales: [
        const Locale('en'),
        const Locale('ar'),
      ],
      theme: CustomTheme.of(context),
      home:  widget.home
    );
  }
}
