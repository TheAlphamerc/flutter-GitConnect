import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_github_connect/bloc/User/index.dart';
import 'package:flutter_github_connect/ui/page/pullRequest/pull_request_screen.dart';

class PullRequestPage extends StatelessWidget {
  const PullRequestPage({Key key, this.bloc}) : super(key: key);
  final UserBloc bloc;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Title(
            title: "Pull Request",
            color: Colors.black,
            child: Text("Pull Request",
                style: Theme.of(context).textTheme.headline6),
          ),
        ),
        body: Container(
          color: Theme.of(context).colorScheme.surface,
          child: BlocBuilder<UserBloc, UserState>(
            cubit: bloc,
            builder: (
              BuildContext context,
              UserState currentState,
            ) {
              if (currentState is ErrorUserState) {
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
                        onPressed: () {
                          BlocProvider.of<UserBloc>(context)..add(OnLoad());
                          print("Load Notification");
                        },
                      ),
                    ),
                  ],
                ));
              }
              if (currentState is LoadedPullRequestState) {
                return PullRequestScreen(
                    pullRequest: currentState.pullRequestsList);
              }
              if(currentState is OnPullRequestLoad){
                return Center(child: Text("Loading"),);
              }
              return Center(
                child: CircularProgressIndicator(),
              );
            },
          ),
        ));
  }
}
