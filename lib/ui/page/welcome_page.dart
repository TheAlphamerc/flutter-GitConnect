import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_github_connect/bloc/User/index.dart';
import 'package:flutter_github_connect/helper/GIcons.dart';
import 'package:flutter_github_connect/helper/shared_prefrence_helper.dart';
import 'package:flutter_github_connect/ui/page/auth/auth_page.dart';
import 'package:flutter_github_connect/ui/page/user/User_page.dart';
import 'package:flutter_github_connect/ui/widgets/custom_text.dart';
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
            height: 350,//MediaQuery.of(context).size.height * .5,
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            decoration: BoxDecoration(
                color: theme.colorScheme.surface,
                borderRadius: BorderRadius.circular(10)),
            alignment: Alignment.center,
            child: ListView(
              physics: NeverScrollableScrollPhysics(),
              // mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Icon(GIcons.github,
                    size: 120, color: theme.colorScheme.onPrimary),
                SizedBox(height: 30),
                KText(
                  "Signin to Github\nto continue with Github Connect",
                  variant: TypographyVariant.header,
                  textAlign: TextAlign.center,
                  style: TextStyle(letterSpacing: 1.1)
                ),
                SizedBox(height: 20),
                Divider(),
                SizedBox(height: 8),
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
