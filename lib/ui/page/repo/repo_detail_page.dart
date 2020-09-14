import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_github_connect/bloc/bloc/repo_bloc.dart';
import 'package:flutter_github_connect/ui/page/repo/repo_detail_screen.dart';
import 'package:flutter_github_connect/ui/widgets/g_error_container.dart';
import 'package:flutter_github_connect/ui/widgets/g_loader.dart';

class RepoDetailPage extends StatelessWidget {
  const RepoDetailPage({Key key, this.name, this.owner}) : super(key: key);
  final String name;
  final String owner;
  static MaterialPageRoute getPageRoute(
    BuildContext context, {
    String name,
    String owner,
  }) {
    return MaterialPageRoute(
      builder: (context) {
        return BlocProvider<RepoBloc>(
          create: (BuildContext context) => RepoBloc()
            ..add(
              LoadRepoEvent(
                name: name,
                owner: owner,
              ),
            ),
          child: RepoDetailPage(
            name: name,
            owner: owner,
          ),
        );
      },
    );
  }

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
            return GErrorContainer(
              description: currentState.errorMessage,
              onPressed: () {
                BlocProvider.of<RepoBloc>(context)
                  ..add(LoadRepoEvent(name: name, owner: owner));
              },
            );
          }
          if (currentState is LoadingRepoState) {
            return GLoader();
          } else if (currentState is LoadedRepoState) {
            return RepoDetailScreen(model: currentState.model);
          }
          return GLoader();
        },
      ),
    );
  }
}
