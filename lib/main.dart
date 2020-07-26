import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_github_connect/app_delegate.dart';
import 'package:flutter_github_connect/locator.dart';
import 'package:flutter_github_connect/ui/page/app.dart';
import 'package:flutter_github_connect/ui/page/splash.dart';
import 'package:flutter_github_connect/ui/theme/custom_theme.dart';

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
