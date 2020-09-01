import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_github_connect/bloc/User/index.dart';
import 'package:flutter_github_connect/bloc/User/model/event_model.dart';
import 'package:flutter_github_connect/helper/GIcons.dart';
import 'package:flutter_github_connect/ui/page/home/widgets/home_page_screen.dart';
import 'package:flutter_github_connect/ui/widgets/flat_button.dart';

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
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  alignment: Alignment.center,
                  height: MediaQuery.of(context).size.height - 280,
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(GIcons.github_1, size: 120),
                      SizedBox(height: 16),
                      Text(
                        "Seems like into trouble",
                        style: Theme.of(context).textTheme.headline5,
                      ),
                      SizedBox(height: 8),
                      Text(
                        currentState.errorMessage,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                      SizedBox(
                        height: 24,
                      ),
                      GFlatButton(
                        isLoading: ValueNotifier(false),
                        label: "Reload",
                        onPressed: () {
                          BlocProvider.of<UserBloc>(context).add(OnLoad());
                        },
                        isWraped: true,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        } else if (currentState is LoadedUserState) {
          return HomePageScreen(
            model: currentState.user,
            bloc: BlocProvider.of<UserBloc>(context),
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
