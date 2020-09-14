import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_github_connect/bloc/User/index.dart';
import 'package:flutter_github_connect/ui/page/home/widgets/home_page_screen.dart';
import 'package:flutter_github_connect/ui/widgets/g_error_container.dart';
import 'package:flutter_github_connect/ui/widgets/g_loader.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
      buildWhen: (oldState, newState) {
        return (oldState != newState);
      },
      builder: (
        BuildContext context,
        UserState currentState,
      ) {
        if (currentState is ErrorUserState) {
          return GErrorContainer(
            description: currentState.errorMessage,
            onPressed: () {
              BlocProvider.of<UserBloc>(context).add(OnLoad());
            },
          );
        } else if (currentState is LoadedUserState) {
          return HomePageScreen(
            model: currentState.user,
            bloc: BlocProvider.of<UserBloc>(context),
          );
        } else {
          return GLoader(stroke: 4);
        }
      },
    );
  }
}
