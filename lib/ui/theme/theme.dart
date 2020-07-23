import 'package:flutter/material.dart';
import 'package:flutter_github_connect/ui/theme/color/dark_color.dart';
import 'package:flutter_github_connect/ui/theme/colors.dart';

enum ThemeType { LIGHT, DARK }

class AppTheme {
  static ThemeData get darkTheme => ThemeData.dark().copyWith(
        brightness: Brightness.dark,
        buttonColor: Colors.black,
        backgroundColor:DarkColor.background,
        cardColor: DarkColor.cardColor,
        colorScheme: ThemeData.dark().colorScheme.copyWith(
          surface: DarkColor.surfaceColor,
          onSurface: DarkColor.onSurfaceDarkColor,
          onBackground: DarkColor.onSurfaceLightColor
        ),
        textTheme:ThemeData.dark().textTheme.copyWith(bodyText1: TextStyle(color:GColors.white) )
      );

  // Return a scaling factor between 0.0 and 1.0 for screens heights ranging
  // from a fixed short to tall range.
  double contentScale(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    const tall = 896.0;
    const short = 480.0;
    return ((height - short) / (tall - short)).clamp(0.0, 1.0);
  }

  // Return a value between low and high for screens heights ranging
  // from a fixed short to tall range.
  double contentScaleFrom(BuildContext context, double low, double high) {
    return low + contentScale(context) * (high - low);
  }

   static double fullWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  static double fullHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

  static ThemeData getThemeFromKey(ThemeType themeKey) {
    switch (themeKey) {
      case ThemeType.LIGHT:
        return darkTheme;
      case ThemeType.DARK:
        return darkTheme;
      default:
        return darkTheme;
    }
  }
}
