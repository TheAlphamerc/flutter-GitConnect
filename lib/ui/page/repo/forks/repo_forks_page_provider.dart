import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_github_connect/bloc/bloc/repo_bloc.dart';
import 'package:flutter_github_connect/helper/GIcons.dart';
import 'package:flutter_github_connect/ui/page/common/no_data_page.dart';
import 'package:flutter_github_connect/ui/page/repo/forks/repo_forks_screen.dart';
import 'package:flutter_github_connect/ui/theme/images.dart';
import 'package:flutter_github_connect/ui/widgets/g_app_bar_title.dart';
import 'package:flutter_github_connect/ui/widgets/g_error_container.dart';
import 'package:flutter_github_connect/ui/widgets/g_loader.dart';

class RepoForksPageProvider extends StatefulWidget {
  final String name;
  final String owner;
  const RepoForksPageProvider({Key key, this.name,this.owner}) : super(key: key);
  static MaterialPageRoute getPageRoute(
    {String name,
    String owner, 
    int count
  }) {
    return MaterialPageRoute(
      builder: (context) {
        return BlocProvider<RepoBloc>(
          create: (BuildContext context) =>
              RepoBloc()..add(LoadForksEvent(name:name,owner:owner,count:count)),
          child: RepoForksPageProvider(name: name, owner:owner),
        );
      },
    );
  }

  @override
  _RepoForksPageProviderState createState() =>
      _RepoForksPageProviderState();
}

class _RepoForksPageProviderState extends State<RepoForksPageProvider> {
  ScrollController _controller;
  void initState() {
    _controller = ScrollController()..addListener(listener);
    super.initState();
  }

  void listener() {
    if (_controller.position.pixels == _controller.position.maxScrollExtent) {
      print(widget.name);
      BlocProvider.of<RepoBloc>(context)
          .add(LoadForksEvent(name:widget.name,owner:widget.owner,isLoadNextForks:true));
    }
  }

  @override
  Widget build(BuildContext context) {
    return RepoForksPage(
      controller: _controller,
      login: widget.name,
      name:widget.name,
      owner:widget.owner,
      bloc:BlocProvider.of<RepoBloc>(context)
    );
  }
}


class RepoForksPage extends StatelessWidget {
  const RepoForksPage({Key key, this.bloc, this.owner,this.name,this.login, this.controller})
      : super(key: key);
  final RepoBloc bloc;
  final String name;
  final String owner;
  final String login;
  final ScrollController controller;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(title: GAppBarTitle(login: login, title: "Forks")),
      body: Container(
        color: Theme.of(context).colorScheme.surface,
        child: BlocBuilder<RepoBloc, RepoState>(
          cubit: bloc,
          builder: (
            BuildContext context,
            RepoState currentState,
          ) {
            if (currentState is ErrorForksState) {
              return GErrorContainer(
                description: currentState.errorMessage,
                onPressed: () {
                  bloc..add(LoadForksEvent(name:name,owner:owner));
                },
              );
            }
            if (currentState is LoadedForksState) {
              if (currentState.forks!= null &&
                  currentState.forks.totalCount > 0)
                return ForksScreen(
                  forksList: currentState.forks.nodes,
                  controller: controller,
                );
              return NoDataPage(
                title: "",
                image: GImages.octocat12,
                description: "Nothing to see here!!",
                icon: GIcons.git_fork_24,
              );
            }
            if (currentState is LoadingForksState) {
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


