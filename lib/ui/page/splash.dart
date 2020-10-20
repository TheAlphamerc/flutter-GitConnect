import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_github_connect/bloc/User/index.dart';
import 'package:flutter_github_connect/bloc/navigation/index.dart';
import 'package:flutter_github_connect/bloc/notification/index.dart' as notif;
import 'package:flutter_github_connect/helper/GIcons.dart';
import 'package:flutter_github_connect/helper/shared_prefrence_helper.dart';
import 'package:flutter_github_connect/ui/page/common/dashboard_page.dart';
import 'package:flutter_github_connect/ui/page/welcome_page.dart';
import 'package:flutter_github_connect/ui/theme/export_theme.dart';
import 'package:flutter_github_connect/ui/theme/images.dart';
import 'package:get_it/get_it.dart';

class SplashPage extends StatefulWidget {
  SplashPage({Key key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    Future.delayed(Duration(
      seconds: 2,
    )).then((value) => doAutoLogin());
    super.initState();
  }

  void doAutoLogin() async {
    final getIt = GetIt.instance;
    final prefs = getIt<SharedPrefrenceHelper>();
    final accessToken = await prefs.getAccessToken();
    if (accessToken != null) {
      print("***************** Auto Login ***********************");
      Navigator.of(context).pushAndRemoveUntil(DashBoardPage.getPageRoute(), (_) => false);
    } else {
      Navigator.push(context, WelcomePage.getPageRoute(context));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: Container(
        alignment: Alignment.center,
        height: AppTheme.fullHeight(context),
        child: Container(
          height: 150,
          width: 150,
          child: Stack(
            fit: StackFit.expand,
            alignment: Alignment.center,
            children: [
              Icon(GIcons.github, size: 120),
              CircularProgressIndicator(valueColor: AlwaysStoppedAnimation(GColors.blue)),
            ],
          ),
        ),
      ),
    );
  }
}
