import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_github_connect/bloc/User/User_bloc.dart';
import 'package:flutter_github_connect/bloc/User/index.dart';
import 'package:flutter_github_connect/bloc/auth/index.dart';
import 'package:flutter_github_connect/bloc/navigation/index.dart';
import 'package:flutter_github_connect/ui/page/auth/web_view.dart';
import 'package:flutter_github_connect/ui/page/common/dashboard_page.dart';
import 'package:flutter_github_connect/bloc/notification/index.dart' as notif;
import 'package:flutter_github_connect/ui/widgets/g_error_container.dart';
import 'package:flutter_github_connect/ui/widgets/g_loader.dart';

class AuthPage extends StatefulWidget {
  static const String routeName = '/auth';

  static route() => MaterialPageRoute(
        builder: (context) => BlocProvider(
          create: (BuildContext context) => AuthBloc()..add(LoadingWebView()),
          child: AuthPage(),
        ),
      );

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
          Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
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
          ), (_) => false);
        }
      }
    });
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: BlocBuilder<AuthBloc, AuthState>(builder: (
        BuildContext context,
        AuthState currentState,
      ) {
        if (currentState is LoadingWebViewState) {
          return WebViewPage();
        } else if (currentState is ErrorAuthState) {
          return GErrorContainer(
            description: currentState.errorMessage,
            onPressed: () {
              BlocProvider.of<AuthBloc>(context).add(LoadingWebView());
            },
          );
        }
        return GLoader(stroke: 4);
      }),
    );
  }
}
