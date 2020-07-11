import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_github_connect/bloc/User/index.dart';
import 'package:flutter_github_connect/helper/shared_prefrence_helper.dart';
import 'package:flutter_github_connect/ui/page/user/User_page.dart';
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
        MaterialPageRoute<UserPage>(
          builder: (context) {
            return BlocProvider.value(
              value: UserBloc()..add(OnLoad()),
              child: UserPage(),
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
