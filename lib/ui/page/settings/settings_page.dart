import 'package:flutter/material.dart';
import 'package:flutter_github_connect/helper/GIcons.dart';
import 'package:flutter_github_connect/helper/shared_prefrence_helper.dart';
import 'package:flutter_github_connect/ui/page/common/under_development.dart';
import 'package:flutter_github_connect/ui/page/splash.dart';
import 'package:flutter_github_connect/ui/theme/custom_theme.dart';
import 'package:flutter_github_connect/ui/theme/export_theme.dart';
import 'package:flutter_github_connect/ui/widgets/g_card.dart';
import 'package:flutter_github_connect/ui/widgets/markdown/markdown_viewer.dart';
import 'package:get_it/get_it.dart';

class SettingsPage extends StatelessWidget {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  SettingsPage({Key key}) : super(key: key);
  Widget _getUtilRos(context, String text,
      {Function onPressed,
      Color color,
      IconData icon = GIcons.chevron_right_24,
      String selectedText = ""}) {
    return Row(
      children: <Widget>[
        SizedBox(width: 16, height: 50),
        Text(
          text,
          style: Theme.of(context).textTheme.bodyText1,
        ),
        Spacer(),
        Text(
          selectedText,
          style: Theme.of(context).textTheme.subtitle2,
        ),
        if (icon != null)
          Icon(
            icon,
            color: Theme.of(context).colorScheme.onSurface,
            size: 18,
          ),
        SizedBox(width: 8, height: 50)
      ],
    ).ripple(onPressed ??
        () {
          Underdevelopment.displaySnackbar(context, key: scaffoldKey);
        });
  }

  Widget _section1(context) {
    return GCard(
      color: Theme.of(context).colorScheme.surface,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _getUtilRos(context, "Appearence",
              color: GColors.green, selectedText: "Automatic", onPressed: () {
            _changeTheme(
                context,
                CustomTheme.instanceOf(context).toggle);
          }),
          Divider(height: 0),
          _getUtilRos(context, "App Icon",
              color: GColors.blue, selectedText: "  "),
          Divider(height: 0),
          _getUtilRos(context, "Push Notifications",
              color: GColors.purple,
              selectedText: "Direct mention",
              onPressed: () {}),
          Divider(height: 0),
          _getUtilRos(context, "Swipe Options", color: GColors.orange),
        ],
      ),
    );
  }

  Widget _section2(context) {
    return GCard(
      color: Theme.of(context).colorScheme.surface,
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
      color: Theme.of(context).colorScheme.surface,
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
      color: Theme.of(context).colorScheme.surface,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _getUtilRos(context, "Sign out", color: GColors.green, icon: null,
              onPressed: () {
            /// [Todo] Temprary workaround for logout
            final getIt = GetIt.instance;
            final prefs = getIt<SharedPrefrenceHelper>();
            prefs.cleaPrefrenceValues();
            Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
              builder: (context) {
                return SplashPage();
              },
            ), (_) => false);
          }),
        ],
      ),
    );
  }

  void _changeTheme(BuildContext buildContext, ThemeType key) {
    CustomTheme.instanceOf(buildContext).changeTheme(key);
    print("$key theme set");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
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
