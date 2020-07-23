import 'package:flutter/material.dart';
import 'package:flutter_github_connect/ui/theme/colors.dart';
import 'package:flutter_github_connect/ui/widgets/custom_text.dart';

class HeaderWidget extends StatelessWidget {
  final String title;
  final bool secondHeader;
  const HeaderWidget(this.title, {Key key, this.secondHeader = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: secondHeader
          ? EdgeInsets.only(left: 18, right: 18, bottom: 10, top: 35)
          : EdgeInsets.symmetric(horizontal: 18, vertical: 12),
      alignment: Alignment.centerLeft,
      child: KText(
        title,
        variant: TypographyVariant.h3,
        style: TextStyle(
          color: GColors.blue,
        ),
      ),
    );
  }
}
