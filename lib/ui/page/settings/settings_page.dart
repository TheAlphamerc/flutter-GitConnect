import 'package:flutter/material.dart';
import 'package:flutter_github_connect/helper/GIcons.dart';
import 'package:flutter_github_connect/helper/config.dart';
import 'package:flutter_github_connect/helper/shared_prefrence_helper.dart';
import 'package:flutter_github_connect/helper/utility.dart';
import 'package:flutter_github_connect/ui/page/common/under_development.dart';
import 'package:flutter_github_connect/ui/page/settings/about_us.dart';
import 'package:flutter_github_connect/ui/page/splash.dart';
import 'package:flutter_github_connect/ui/theme/custom_theme.dart';
import 'package:flutter_github_connect/ui/theme/export_theme.dart';
import 'package:flutter_github_connect/ui/widgets/g_app_bar_title.dart';
import 'package:flutter_github_connect/ui/widgets/g_card.dart';
import 'package:get_it/get_it.dart';

class SettingsPage extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  SettingsPage({Key key}) : super(key: key);
  Widget _getUtilRos(context, String text, {Function onPressed, IconData icon = GIcons.chevron_right_24, String selectedText = ""}) {
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
          _getUtilRos(context, "About us", onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (_) => AboutUsPage()));
          }),
          Divider(height: 0),
          _getUtilRos(context, "Share App", selectedText: "  ",onPressed: (){
            Utility.share(Config.appLink);
          }),
          Divider(height: 0),
          _getUtilRos(context, "Appearence", selectedText: CustomTheme.instanceOf(context).isDarkMode ? "Dark Mode" : "Light Mode",
              onPressed: () {
            _changeTheme(context, CustomTheme.instanceOf(context).toggle);
          }),
          Divider(height: 0),
          _getUtilRos(context, "Push Notifications", selectedText: "Direct mention"),
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
          _getUtilRos(context, "Share Feedback", icon: GIcons.pencil_24, onPressed: () {
            final Uri _emailLaunchUri = Uri(
              scheme: 'mailto',
              path: 'sonu.sharma045@gmail.com',
              queryParameters: {'subject': 'Feedback for Git connect app'},
            );

            Utility.launchTo(_emailLaunchUri.toString());
          }),
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
          _getUtilRos(context, "Privacy Policy"),
          Divider(height: 0),
          _getUtilRos(context, "Terms of Service"),
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
          _getUtilRos(context, "Sign out", icon: null, onPressed: () {
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
        title: GAppBarTitle(
          title: "Settings",
        ),
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
