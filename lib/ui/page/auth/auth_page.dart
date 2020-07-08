import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_github_connect/bloc/User/User_bloc.dart';
import 'package:flutter_github_connect/bloc/User/index.dart';
import 'package:flutter_github_connect/bloc/auth/index.dart';
import 'package:flutter_github_connect/ui/page/auth/web_view.dart';
import 'package:flutter_github_connect/ui/page/user/User_page.dart';

class AuthPage extends StatefulWidget {
  static const String routeName = '/auth';

  static route() => MaterialPageRoute(
      builder: (context) => BlocProvider(
            create: (BuildContext context) => AuthBloc()..add(LoadingWebView()),
            child: AuthPage(),
          ));

  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  AuthBloc _bloc(BuildContext context) => BlocProvider.of<AuthBloc>(context);
  StreamSubscription<AuthState> _subscription;

  @override
  void initState() {
    super.initState();
    _subscription = _bloc(context).listen((state) {
      if (state is SucessState) {
        if (state.isSuccess) {
          print("Navigate to Profile page");
          // Navigator.of(context).pushReplacement(UserPage.route());
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
    });
  }

  // @override
  // void dispose() {
  //   _subscription.cancel();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<AuthBloc, AuthState>(
          builder: (
        BuildContext context,
        AuthState currentState,
      ) {
        if (currentState is LoadingWebViewState) {
          return WebViewPage();
        } else if (currentState is ErrorAuthState) {
          return Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(currentState.errorMessage ?? 'Error'),
              Padding(
                padding: const EdgeInsets.only(top: 32.0),
                child: RaisedButton(
                  color: Colors.blue,
                  child: Text('reload'),
                  onPressed: () {},
                ),
              ),
            ],
          ));
        }
        return Center(
          child: CircularProgressIndicator(),
        );
      }),
    );
  }
}
