import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_github_connect/bloc/User/index.dart';
import 'package:flutter_github_connect/helper/shared_prefrence_helper.dart';
import 'package:flutter_github_connect/ui/page/auth/auth_page.dart';
import 'package:flutter_github_connect/ui/page/user/User_page.dart';
import 'package:flutter_github_connect/ui/theme/images.dart';
import 'package:flutter_github_connect/ui/widgets/flat_button.dart';
import 'package:get_it/get_it.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: <Widget>[
              Spacer(),
              Image.asset(
                GImages.octocatIconDark120,
                height: 100,
              ),
              SizedBox(
                height: 50,
              ),
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
              Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
