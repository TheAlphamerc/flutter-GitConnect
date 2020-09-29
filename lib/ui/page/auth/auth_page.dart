import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_github_connect/bloc/auth/index.dart';
import 'package:flutter_github_connect/ui/page/auth/web_view.dart';
import 'package:flutter_github_connect/ui/page/common/dashboard_page.dart';

import 'package:flutter_github_connect/ui/widgets/g_error_container.dart';
import 'package:flutter_github_connect/ui/widgets/g_loader.dart';

class AuthPage extends StatelessWidget {
  static route() => MaterialPageRoute(
        builder: (context) => BlocProvider(
          create: (BuildContext context) => AuthBloc()..add(LoadingWebView()),
          child: AuthPage(),
        ),
      );

  void _stateListner(BuildContext context, AuthState state) {
    if (state is SucessState) {
      if (state.isSuccess) {
        print("Navigate to Profile page");
        Navigator.of(context)
            .pushAndRemoveUntil(DashBoardPage.getPageRoute(), (_) => false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: BlocConsumer<AuthBloc, AuthState>(
          listener: _stateListner,
          builder: (
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
