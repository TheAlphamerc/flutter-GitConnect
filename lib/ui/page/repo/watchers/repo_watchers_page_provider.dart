import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_github_connect/bloc/people/index.dart';
import 'package:flutter_github_connect/helper/GIcons.dart';
import 'package:flutter_github_connect/ui/page/common/no_data_page.dart';
import 'package:flutter_github_connect/ui/page/repo/watchers/repo_watchers_screen.dart';
import 'package:flutter_github_connect/ui/widgets/g_app_bar_title.dart';
import 'package:flutter_github_connect/ui/widgets/g_error_container.dart';
import 'package:flutter_github_connect/ui/widgets/g_loader.dart';

class RepoWatchersPageProvider extends StatefulWidget {
  final String name;
  final String owner;

  const RepoWatchersPageProvider({Key key, this.name,this.owner}) : super(key: key);
  static MaterialPageRoute getPageRoute(
    BuildContext context, {
    String name,
    String owner,
    int count,
  }) {
    return MaterialPageRoute(
      builder: (context) {
        return BlocProvider<PeopleBloc>(
          create: (BuildContext context) =>
              PeopleBloc()..add(LoadWatchersEvent(name:name,owner:owner,count:count)),
          child: RepoWatchersPageProvider(name: name, owner:owner),
        );
      },
    );
  }

  @override
  _RepoWatchersPageProviderState createState() =>
      _RepoWatchersPageProviderState();
}

class _RepoWatchersPageProviderState extends State<RepoWatchersPageProvider> {
  ScrollController _controller;
  void initState() {
    _controller = ScrollController()..addListener(listener);
    super.initState();
  }

  void listener() {
    if (_controller.position.pixels == _controller.position.maxScrollExtent) {
      print(widget.name);
      BlocProvider.of<PeopleBloc>(context)
          .add(LoadWatchersEvent(name:widget.name,owner:widget.owner,isLoadNextWatchers:true));
    }
  }

  @override
  Widget build(BuildContext context) {
    return RepoWatchersPage(
      controller: _controller,
      login: widget.name,
      name:widget.name,
      owner:widget.owner,
      bloc:BlocProvider.of<PeopleBloc>(context)
    );
  }
}


class RepoWatchersPage extends StatelessWidget {
  const RepoWatchersPage({Key key, this.bloc, this.owner,this.name,this.login, this.controller})
      : super(key: key);
  final PeopleBloc bloc;
  final String name;
  final String owner;
  final String login;
  final ScrollController controller;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(title: GAppBarTitle(login: login, title: "Watchers")),
      body: Container(
        color: Theme.of(context).colorScheme.surface,
        child: BlocBuilder<PeopleBloc, PeopleState>(
          cubit: bloc,
          builder: (
            BuildContext context,
            PeopleState currentState,
          ) {
            if (currentState is ErrorWatchersState) {
              return GErrorContainer(
                description: currentState.errorMessage,
                onPressed: () {
                  bloc..add(LoadWatchersEvent(name:name,owner:owner));
                },
              );
            }
            if (currentState is LoadedWatcherState) {
              if (currentState.watchers!= null &&
                  currentState.watchers.totalCount > 0)
                return WatchersScreen(
                  watchersList: currentState.watchers.userList,
                  controller: controller,
                );
              return NoDataPage(
                title: "Empty issues",
                description:
                    "No one is watching this repository yet,\n Once people started watching this repo, they will be displayed here",
                icon: GIcons.git_pull_request_24,
              );
            }
            if (currentState is LoadingWatcherState) {
              return GLoader();
            }
            return Center(
              child: Text("Unknown State"),
            );
          },
        ),
      ),
    );
  }
}


