import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_github_connect/bloc/bloc/repo_bloc.dart';
import 'package:flutter_github_connect/ui/page/repo/repo_detail_screen.dart';
import 'package:flutter_github_connect/ui/theme/export_theme.dart';

class RepoDetailPage extends StatelessWidget {
  const RepoDetailPage({Key key, this.name, this.owner}) : super(key: key);
  final String name;
  final String owner;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        title: Title(
          title: "Repository",
          color: Colors.black,
          child:
              Text("Repository", style: Theme.of(context).textTheme.headline6),
        ),
      ),
      body: BlocBuilder<RepoBloc, RepoState>(
        builder: (context, currentState) {
          if (currentState is ErrorRepoState) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(currentState.errorMessage ?? 'Error').hP30,
                  Padding(
                    padding: const EdgeInsets.only(top: 32.0),
                    child: RaisedButton(
                      color: Colors.blue,
                      child: Text('reload'),
                      onPressed: () {
                        BlocProvider.of<RepoBloc>(context)
                          ..add(LoadRepoEvent(name: name, owner: owner));
                      },
                    ),
                  ),
                ],
              ),
            );
          }
          if (currentState is LoadingRepoState) {
            return Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(GColors.blue),
              ),
            );
          } else if (currentState is LoadedRepoState) {
            return RepoDetailScreen(model:currentState.model);
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
