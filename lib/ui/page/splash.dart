import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_github_connect/bloc/User/index.dart';
import 'package:flutter_github_connect/bloc/navigation/index.dart';
import 'package:flutter_github_connect/bloc/notification/index.dart' as notif;
import 'package:flutter_github_connect/bloc/search/index.dart';
import 'package:flutter_github_connect/helper/shared_prefrence_helper.dart';
import 'package:flutter_github_connect/ui/page/home/dashboard_page.dart';
import 'package:flutter_github_connect/ui/page/welcome_page.dart';
import 'package:get_it/get_it.dart';

class SplashPage extends StatefulWidget {
  SplashPage({Key key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    doAutoLogin();
    super.initState();
  }

  void doAutoLogin() async {
    final getIt = GetIt.instance;
    final prefs = getIt<SharedPrefrenceHelper>();
    final accessToken = await prefs.getAccessToken();
    if (accessToken != null) {
      print("***************** Auto Login ***********************");
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) {
            return MultiBlocProvider(
              providers: [
                BlocProvider<NavigationBloc>(
                  create: (BuildContext context) => NavigationBloc(),
                ),
                BlocProvider<UserBloc>(
                  create: (BuildContext context) => UserBloc()..add(OnLoad()),
                ),
                BlocProvider<notif.NotificationBloc>(
                  create: (BuildContext context) =>
                      notif.NotificationBloc()..add(notif.OnLoad()),
                ),
              ],
              child: DashBoardPage(),
            );
          },
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return WelcomePage();
  }
}
