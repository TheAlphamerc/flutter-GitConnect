import 'package:flutter/material.dart';
import 'package:flutter_github_connect/helper/GIcons.dart';
import 'package:flutter_github_connect/ui/theme/export_theme.dart';
import 'package:flutter_github_connect/ui/widgets/custom_text.dart';
import 'package:flutter_github_connect/ui/widgets/g_card.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key key}) : super(key: key);
  Widget _getUtilRos(context, String text,
      {Function onPressed,
      Color color,
      IconData icon = GIcons.chevron_right_24,
      String selectedText = ""}) {
    return Row(
      children: <Widget>[
        SizedBox(width: 16, height: 50),
        KText(
          text,
          variant: TypographyVariant.h3,
        ),
        Spacer(),
        KText(
          selectedText,
          variant: TypographyVariant.h3,
          isSubtitle: true,
          style: TextStyle(fontWeight: FontWeight.w300, letterSpacing: .6),
        ),
        if(icon != null)
        Icon(
          icon,
          color: Theme.of(context).colorScheme.onSurface,
          size: 18,
        ),
        SizedBox(width: 8, height: 50)
      ],
    ).ripple(onPressed);
  }

  Widget _section1(context) {
    return GCard(
      color:Theme.of(context).colorScheme.surface,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _getUtilRos(context, "Appearence",
              color: GColors.green, selectedText: "Automaic"),
          Divider(height: 0),
          _getUtilRos(context, "App Icon",
              color: GColors.blue, selectedText: "  "),
          Divider(height: 0),
          _getUtilRos(context, "Push Notifications",
              color: GColors.purple,
              selectedText: "Direct mention", onPressed: () {
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(
            //     builder: (_) => RepositoryListScreen(
            //       list1: widget.model.repositories.nodes,
            //     ),
            //   ),
            // );
          }),
          Divider(height: 0),
          _getUtilRos(context, "Swipe Options", color: GColors.orange),
        ],
      ),
    );
  }

  Widget _section2(context) {
    return GCard(
      color:Theme.of(context).colorScheme.surface,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _getUtilRos(
            context,
            "Share Feedback",
            color: GColors.green,
            icon: GIcons.pencil_24,
          ),
        ],
      ),
    );
  }

  Widget _section3(context) {
    return GCard(
      color:Theme.of(context).colorScheme.surface,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _getUtilRos(context, "Privacy Policy", color: GColors.green),
          Divider(height: 0),
          _getUtilRos(context, "Terms of Service", color: GColors.blue),
        ],
      ),
    );
  }

  Widget _section4(context) {
    return GCard(
      color:Theme.of(context).colorScheme.surface,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _getUtilRos(context, "Sign out", color: GColors.green,icon:null),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        elevation: 0,
        title: Text("Settings"),
        backgroundColor: Theme.of(context).colorScheme.surface,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Column(
          children: <Widget>[
            _section1(context),
            SizedBox(height: 20),
            _section2(context),
            SizedBox(height: 20),
            _section3(context),
            SizedBox(height: 20),
            _section4(context),
          ],
        ),
      ),
    );
  }
}
