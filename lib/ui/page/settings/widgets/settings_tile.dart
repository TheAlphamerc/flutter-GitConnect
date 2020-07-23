import 'package:flutter/material.dart';
import 'package:flutter_github_connect/ui/widgets/custom_text.dart';
import 'package:flutter_github_connect/ui/widgets/g_checkbox.dart';
import 'package:provider/provider.dart';

class SettingRowWidget extends StatelessWidget {
  const SettingRowWidget(
    this.title, {
    Key key,
    this.navigateTo,
    this.subtitle,
    // this.textColor = Colors.black,
    this.onPressed,
    this.vPadding = 0,
    this.showDivider = true,
    this.visibleSwitch,
    this.showCheckBox,
  }) : super(key: key);
  final bool visibleSwitch, showDivider, showCheckBox;
  final String navigateTo;
  final String subtitle, title;
  // final Color textColor;
  final Function onPressed;
  final double vPadding;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ListTile(
          contentPadding:
              EdgeInsets.symmetric(vertical: vPadding, horizontal: 18),
          onTap: () {
            if (onPressed != null) {
              onPressed();
              return;
            }
            if (navigateTo == null) {
              return;
            }
            Navigator.pushNamed(context, '/$navigateTo');
          },
          title: title == null
              ? null
              : KText(
                  title ?? '',
                  style: TextStyle(fontWeight: FontWeight.w400,height:1.2),
                ),
          subtitle: subtitle == null
              ? null
              : KText(
                  subtitle,
                  style: TextStyle(fontWeight: FontWeight.w400,height:1.4),
                ),
          trailing: CustomCheckBox(
            isChecked: showCheckBox,
            visibleSwitch: visibleSwitch,
          ),
        ),
        !showDivider ? SizedBox() : Divider(height: 0)
      ],
    );
  }
}
