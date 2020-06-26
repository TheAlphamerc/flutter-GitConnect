import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_github_connect/bloc/auth/index.dart';
import 'package:flutter_github_connect/ui/page/auth/web_view.dart';

class AuthPage extends StatefulWidget {
  static const String routeName = '/auth';

  static route() => MaterialPageRoute(
      builder: (context) => MultiBlocProvider(
            providers: [
              BlocProvider<AuthBloc>(
                create: (BuildContext context) => AuthBloc(),
              ),
            ],
            child: AuthPage(),
          ));

  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  // final _authBloc = AuthBloc();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Auth'),
      ),
      body: WebViewPage(),
    );
  }
}
