import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'app_delegate.dart';
import 'locator.dart';
import 'ui/page/page.dart';
import 'ui/theme/custom_theme.dart';
import 'ui/theme/export_theme.dart';

void main() {
  Bloc.observer = AppBlocDelegate();
  setUpDependency();
  final app = GitApp(
    home: SplashPage(),
  );
  runApp(
    CustomTheme(
      initialThemeKey: ThemeType.DARK,
      child: app,
    ),
  );
}
