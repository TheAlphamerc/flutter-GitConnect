import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_github_connect/bloc/repo/index.dart';
import 'package:flutter_github_connect/ui/page/auth/repo/repo_list_screen.dart';

class RepositoryListPage extends StatefulWidget {
  static const String routeName = '/repo';

  @override
  _RepositoryListPageState createState() => _RepositoryListPageState();
}

class _RepositoryListPageState extends State<RepositoryListPage> {
  final _repoBloc = RepoBloc();

  @override
  void initState() {
    super.initState();
    _load();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        title: Text("Profile"),
      ),
      body: BlocBuilder<RepoBloc, RepoState>(
        bloc: _repoBloc,
        builder: (
          BuildContext context,
          RepoState currentState,
        ) {
          if (currentState is ErrorRepoState) {
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
                    onPressed: _load,
                  ),
                ),
              ],
            ));
          }
          if (currentState is LoadedRepositoriesState) {
            return RepositoryListScreen(
              list: currentState.list,
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }

  void _load([bool isError = false]) {
    _repoBloc.add(LoadRepoEvent(isError));
  }
}
