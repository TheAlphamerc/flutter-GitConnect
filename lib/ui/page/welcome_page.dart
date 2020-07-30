import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_github_connect/bloc/User/index.dart';
import 'package:flutter_github_connect/helper/GIcons.dart';
import 'package:flutter_github_connect/helper/shared_prefrence_helper.dart';
import 'package:flutter_github_connect/ui/page/auth/auth_page.dart';
import 'package:flutter_github_connect/ui/page/user/User_page.dart';
import 'package:flutter_github_connect/ui/widgets/flat_button.dart';
import 'package:get_it/get_it.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: SafeArea(
        child: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: Container(
            height: 320,
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            decoration: BoxDecoration(
                color: theme.colorScheme.surface,
                borderRadius: BorderRadius.circular(10)),
            alignment: Alignment.center,
            child: ListView(
              physics: NeverScrollableScrollPhysics(),
              children: <Widget>[
                SizedBox(height: 8),
                Icon(GIcons.github,
                    size: 100, color: theme.colorScheme.onPrimary),
                SizedBox(height: 30),
                Text(
                  "Signin to Github\nto continue with GitConnect",
                  style: Theme.of(context).textTheme.headline6,
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 16),
                Divider(),
                SizedBox(height: 12),
                GFlatButton(
                  label: "Sign in",
                  onPressed: () async {
                    final getIt = GetIt.instance;
                    final prefs = getIt<SharedPrefrenceHelper>();
                    final accessToken = await prefs.getAccessToken();
                    if (accessToken == null) {
                      await Navigator.push(context, AuthPage.route());
                    } else {
                      print(
                          "***************** Auto Login ***********************");
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
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
