import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_github_connect/bloc/people/index.dart';
import 'package:flutter_github_connect/helper/GIcons.dart';
import 'package:flutter_github_connect/ui/page/common/no_data_page.dart';
import 'package:flutter_github_connect/ui/page/repo/stargezers/repo_stargezers_screen.dart';
import 'package:flutter_github_connect/ui/widgets/g_app_bar_title.dart';
import 'package:flutter_github_connect/ui/widgets/g_error_container.dart';
import 'package:flutter_github_connect/ui/widgets/g_loader.dart';

class RepoStargezersPageProvider extends StatefulWidget {
  final String name;
  final String owner;

  const RepoStargezersPageProvider({Key key, this.name,this.owner}) : super(key: key);
  static MaterialPageRoute getPageRoute(
    {String name,
    String owner,
    int count,
  }) {
    return MaterialPageRoute(
      builder: (context) {
        return BlocProvider<PeopleBloc>(
          create: (BuildContext context) =>
              PeopleBloc()..add(LoadStargezersEvent(name:name,owner:owner,count:count)),
          child: RepoStargezersPageProvider(name: name, owner:owner),
        );
      },
    );
  }

  @override
  _RepoStargezersPageProviderState createState() =>
      _RepoStargezersPageProviderState();
}

class _RepoStargezersPageProviderState extends State<RepoStargezersPageProvider> {
  ScrollController _controller;
  void initState() {
    _controller = ScrollController()..addListener(listener);
    super.initState();
  }

  void listener() {
    if (_controller.position.pixels == _controller.position.maxScrollExtent) {
      print(widget.name);
      BlocProvider.of<PeopleBloc>(context)
          .add(LoadStargezersEvent(name:widget.name,owner:widget.owner,isLoadNextStartgers:true));
    }
  }

  @override
  Widget build(BuildContext context) {
    return RepoStargazersPage(
      controller: _controller,
      login: widget.name,
      name:widget.name,
      owner:widget.owner,
      bloc:BlocProvider.of<PeopleBloc>(context)
    );
  }
}


class RepoStargazersPage extends StatelessWidget {
  const RepoStargazersPage({Key key, this.bloc, this.owner,this.name,this.login, this.controller})
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
      appBar: AppBar(title: GAppBarTitle(login: login, title: "Stargazers")),
      body: Container(
        color: Theme.of(context).colorScheme.surface,
        child: BlocBuilder<PeopleBloc, PeopleState>(
          cubit: bloc,
          builder: (
            BuildContext context,
            PeopleState currentState,
          ) {
            if (currentState is ErrorStargezersState) {
              return GErrorContainer(
                description: currentState.errorMessage,
                onPressed: () {
                  bloc..add(LoadStargezersEvent(name:name,owner:owner));
                },
              );
            }
            if (currentState is LoadedStargezersState) {
              if (currentState.isNotNullEmpty)
                return StargazersScreen(
                  watchersList: currentState.stargezers.userList,
                  controller: controller,
                );
              return NoDataPage(
                title: "",
                description:
                    "Nothing is here to see\nCome back later!!",
                icon: GIcons.star_fill_24,
              );
            }
            if (currentState is LoadingStargezersState) {
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


