import 'package:flutter/material.dart';
import 'package:flutter_github_connect/helper/GIcons.dart';
import 'package:flutter_github_connect/helper/utility.dart';
import 'package:flutter_github_connect/ui/theme/custom_theme.dart';
import 'package:flutter_github_connect/ui/theme/export_theme.dart';
import 'package:flutter_github_connect/ui/page/common/under_development.dart';
import 'package:flutter_github_connect/ui/widgets/g_app_bar_title.dart';
import 'package:flutter_github_connect/ui/widgets/g_card.dart';

class AboutUsPage extends StatelessWidget {
  const AboutUsPage({Key key}) : super(key: key);
  Widget _getUtilRos(context, String text,
      {Function onPressed,
      IconData icon = GIcons.chevron_right_24,
      String selectedText = ""}) {
    return Row(
      children: <Widget>[
        SizedBox(width: 16, height: 50),
        if (icon != null)
          Icon(
            icon,
            color: Theme.of(context).colorScheme.onSurface,
            size: 18,
          ),
        SizedBox(width: 14),
        Text(
          text,
          style: Theme.of(context).textTheme.bodyText1,
        ),
        Text(
          selectedText,
          style: Theme.of(context).textTheme.subtitle2,
        ),
        Spacer(),
        Icon(
          GIcons.chevron_right_24,
          color: Theme.of(context).colorScheme.onSurface,
          size: 18,
        ),
        SizedBox(width: 8, height: 50)
      ],
    ).ripple(onPressed ??
        () {
          // Underdevelopment.displaySnackbar(context, key: scaffoldKey);
        });
  }

  Widget _section2(context) {
    return GCard(
      margin: EdgeInsets.symmetric(horizontal: 16),
      color: Theme.of(context).colorScheme.surface,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _getUtilRos(context, "Twitter", icon: GIcons.twitter, onPressed: () {
            launch("https://twitter.com/TheAlphamerc");
          }),
          Divider(height: 0),
          _getUtilRos(context, "LinkedIn", icon: GIcons.linkedin,
              onPressed: () {
            launch("https://www.linkedin.com/in/thealphamerc/");
          }),
          Divider(height: 0),
          _getUtilRos(context, "Facebook", icon: GIcons.facebook,
              onPressed: () {
            launch("https://facebook.com/TheAlphaMerc");
          }),
          Divider(height: 0),
          _getUtilRos(context, "Github", icon: GIcons.github_2, onPressed: () {
            launch("https://github.com/TheAlphamerc");
          }),
          Divider(height: 0),
          _getUtilRos(context, "Youtube", icon: GIcons.youtube_play,
              onPressed: () {
            launch("https://www.youtube.com/user/sonusharma045sonu");
          }),
          Divider(height: 0),
          _getUtilRos(context, "Blog", icon: GIcons.link_external_24,
              onPressed: () {
            launch("https://dev.to/thealphamerc");
          }),
        ],
      ),
    );
  }

  Widget _section1(context) {
    return GCard(
      margin: EdgeInsets.symmetric(horizontal: 16),
      color: Theme.of(context).colorScheme.surface,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _getUtilRos(context, "App", icon: GIcons.link_external_24,
              onPressed: () {
            launch("www.play.google.com/store/apps/details?id=com.thealphamerc.flutter_github_connect");
          }),
          Divider(height: 0),
          _getUtilRos(context, "Project", icon: GIcons.link_external_24,
              onPressed: () {
            launch("https://github.com/TheAlphamerc/flutter-GitConnect");
          }),
        ],
      ),
    );
  }

  void launch(String url) {
    Utility.launchTo(url);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        title: GAppBarTitle(
          title: "About us",
        ),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 0, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "Git Connect ",
              style: Theme.of(context).textTheme.headline6,
            ).hP16,
            SizedBox(height: 8),
            _section1(context),
            SizedBox(height: 20),
            Text(
              "Social Connect ",
              style: Theme.of(context).textTheme.headline6,
            ).hP16,
            SizedBox(height: 8),
            _section2(context),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
