import 'package:flutter/material.dart';
import 'package:flutter_github_connect/ui/theme/custom_theme.dart';
import 'package:flutter_github_connect/ui/theme/theme.dart';

class KText extends StatelessWidget {
  final String data;
  final TypographyVariant variant;

  final Locale locale;
  final int maxLines;
  final TextOverflow overflow;
  final String semanticsLabel;
  final bool softWrap;
  final bool isSubtitle;
  final StrutStyle strutStyle;
  final TextStyle style;
  final TextAlign textAlign;
  final TextDirection textDirection;
  final double textScaleFactor;
  final TextWidthBasis textWidthBasis;

  KText(
    this.data, {
    Key key,
    this.locale,
    this.maxLines,
    this.overflow,
    this.semanticsLabel,
    this.softWrap,
    this.strutStyle,
    this.style,
    this.textAlign,
    this.textDirection,
    this.textScaleFactor,
    this.textWidthBasis,
    this.isSubtitle ,
    this.variant = TypographyVariant.body,
  }) : super(key: key);

  static TextStyle styleForVariant(context, TypographyVariant variant,
      {TextStyle overrides = const TextStyle()}) {
    TextStyle style;
    final theme = Theme.of(context);
    switch (variant) {
      case TypographyVariant.title:
        style = TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w800,
          fontSize: 26,
          height: 1.0,
          fontFamily: 'Raleway',
        );
        break;
      case TypographyVariant.header:
        style = TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w400,
          fontSize: 24,
          height: 1,
          fontFamily: 'Raleway',
        );
        break;
      case TypographyVariant.subHeader:
        style = TextStyle(
          color: Colors.white54,
          fontWeight: FontWeight.w400,
          fontSize: 22,
          height: 0.88,
          fontFamily: 'Raleway',
        );
        break;
      case TypographyVariant.headerSmall:
        style = TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.normal,
          fontSize: 14,
          height: 1,
          fontFamily: 'Raleway',
        );
        break;
      case TypographyVariant.h1:
        style = TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 20,
          height: 1.0,
          fontFamily: 'Raleway',
        );
        break;
      case TypographyVariant.h2:
        style = TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 18,
          height: 1,
          fontFamily: 'Raleway',
        );
        break;
      case TypographyVariant.h3:
        style = TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.normal,
          fontSize: 16,
          height: 1,
          fontFamily: 'Raleway',
        );
        break;
      case TypographyVariant.h4:
        style = TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.normal,
          fontSize: 14,
          height: 1,
          fontFamily: 'Raleway',
        );
        break;
      case TypographyVariant.body:
        style = TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.normal,
          fontSize: 16,
          height: 1,
          fontFamily: 'Raleway',
        );
        break;
      case TypographyVariant.button:
        style = TextStyle(
          color: Colors.white.withOpacity(.8),
          fontWeight: FontWeight.w600,
          fontSize: 18,
          height: 1,
          fontFamily: 'Raleway',
        );
        break;
      case TypographyVariant.bodySmall:
        style = TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.normal,
          fontSize: 10,
          height: 1,
          fontFamily: 'Raleway',
        );
        break;
      case TypographyVariant.bodyLarge:
        style = TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.normal,
          fontSize: 15,
          height: 1,
          fontFamily: 'Raleway',
        );
        break;
    }
   
    return style?.merge(overrides);
  }

  @override
  Widget build(BuildContext context) {
    TextStyle style =
        KText.styleForVariant(context, this.variant).merge(this.style);
      Color text = CustomTheme.instanceOf(context).themeType == ThemeType.LIGHT ? Colors.black : Colors.white;
      Color subTitleText = CustomTheme.instanceOf(context).themeType == ThemeType.LIGHT ? Colors.black : Colors.white54;
    final theme = Theme.of(context);
    return Text(
      this.data,
      overflow: this.overflow,
      semanticsLabel: this.semanticsLabel,
      softWrap: this.softWrap,
      style: style.copyWith(color:isSubtitle != null ? subTitleText:text),//style.color),
      textAlign: this.textAlign,
      textScaleFactor: this.textScaleFactor,
      textWidthBasis: this.textWidthBasis,
      // locale: this.locale,
      maxLines: this.maxLines,
      // strutStyle: this.strutStyle,
      // textDirection: this.textDirection,
    );
  }
}

enum TypographyVariant {
  title,
  header,
  subHeader,
  headerSmall,
  h1,
  h2,
  h3,
  h4,
  body,
  bodyLarge,
  button,
  bodySmall
}
