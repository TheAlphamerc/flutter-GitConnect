import 'package:flutter/material.dart';
import 'package:flutter_github_connect/ui/theme/app_theme_provider.dart';
import 'package:flutter_github_connect/ui/theme/export_theme.dart';

class CustomTheme extends StatefulWidget {
  final Widget child;
  final ThemeType initialThemeKey;

  const CustomTheme({
    Key key,
    this.initialThemeKey,
    @required this.child,
  }) : super(key: key);

  @override
  CustomThemeState createState() => new CustomThemeState();

  static ThemeData of(BuildContext context) {
    ThemeProvider inherited =
        (context.dependOnInheritedWidgetOfExactType<ThemeProvider>());
    return inherited.data.theme;
  }

  static CustomThemeState instanceOf(BuildContext context) {
    ThemeProvider inherited =
        (context.dependOnInheritedWidgetOfExactType<ThemeProvider>());
    return inherited.data;
  }
}

class CustomThemeState extends State<CustomTheme> {
  ThemeData _theme;
  ThemeType  _themeType;
  ThemeType get themeType => _themeType;
  ThemeData get theme => _theme;
  ThemeType get toggle => _themeType == ThemeType.LIGHT ? ThemeType.DARK : ThemeType.LIGHT;
  bool get isDarkMode => _themeType == ThemeType.DARK;

  @override
  void initState() {
    _theme = AppTheme.getThemeFromKey(widget.initialThemeKey);
    _themeType = ThemeType.DARK;
    super.initState();
  }

  void changeTheme(ThemeType themeKey) {
    setState(() {
      _themeType = themeKey;
      _theme = AppTheme.getThemeFromKey(themeKey);
    });
  }

  @override
  Widget build(BuildContext context) {
    return ThemeProvider(
      data: this,
      child: widget.child,
    );
  }
}
