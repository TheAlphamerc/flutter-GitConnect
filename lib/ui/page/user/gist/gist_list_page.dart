import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_github_connect/bloc/User/index.dart';
import 'package:flutter_github_connect/ui/page/pullRequest/pull_request_screen.dart';
import 'package:flutter_github_connect/ui/page/user/gist/gist_list_screen.dart';

class GistlistPage extends StatelessWidget {
  const GistlistPage({Key key, this.bloc}) : super(key: key);
  final UserBloc bloc;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Title(
            title: "Gist",
            color: Colors.black,
            child: Text("Gist",
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
              if (currentState is ErrorGitState) {
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
                          bloc..add(OnGistLoad());
                          print("Load Notification");
                        },
                      ),
                    ),
                  ],
                ));
              }
              if (currentState is LoadedGitState) {
                return GistListScreen(
                    gist: currentState.gist);
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
