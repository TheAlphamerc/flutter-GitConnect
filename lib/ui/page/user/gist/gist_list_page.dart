import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_github_connect/bloc/people/index.dart';
import 'package:flutter_github_connect/helper/GIcons.dart';
import 'package:flutter_github_connect/ui/page/common/no_data_page.dart';
import 'package:flutter_github_connect/ui/page/user/gist/gist_list_screen.dart';
import 'package:flutter_github_connect/ui/widgets/g_app_bar_title.dart';
import 'package:flutter_github_connect/ui/widgets/g_error_container.dart';
import 'package:flutter_github_connect/ui/widgets/g_loader.dart';

class GistlistPageProvider extends StatefulWidget {
  final String login;

  const GistlistPageProvider({Key key, this.login}) : super(key: key);
  static MaterialPageRoute getPageRoute(
    BuildContext context, {
    String login,
  }) {
    return MaterialPageRoute(
      builder: (context) {
        return BlocProvider<PeopleBloc>(
          create: (BuildContext context) =>
              PeopleBloc()..add(OnGistLoad(login)),
          child: GistlistPageProvider(login: login),
        );
      },
    );
  }

  @override
  _GistlistPageProviderState createState() => _GistlistPageProviderState();
}

class _GistlistPageProviderState extends State<GistlistPageProvider> {
  ScrollController _controller;
  @override
  void initState() {
    _controller = ScrollController()..addListener(listener);
    super.initState();
  }

  void listener() {
    if (_controller.position.pixels == _controller.position.maxScrollExtent) {
      BlocProvider.of<PeopleBloc>(context)
          .add(OnGistLoad(widget.login, isLoadNextGist: true));
    }
  }

  @override
  Widget build(BuildContext context) {
    return GistlistPage(
        bloc: BlocProvider.of<PeopleBloc>(context),
        login: widget.login,
        controller: _controller);
  }
}

class GistlistPage extends StatelessWidget {
  const GistlistPage({Key key, this.bloc, this.login, this.controller})
      : super(key: key);
  final PeopleBloc bloc;
  final String login;
  final ScrollController controller;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(title: GAppBarTitle(login: login, title: "Gists")),
      body: Container(
        child: BlocBuilder<PeopleBloc, PeopleState>(
          cubit: bloc,
          builder: (
            BuildContext context,
            PeopleState currentState,
          ) {
            if (currentState is ErrorGitState) {
              return GErrorContainer(
                description: currentState.errorMessage,
                onPressed: () {
                  bloc..add(OnGistLoad(login));
                },
              );
            }
            if (currentState is LoadedGitState) {
              if (currentState.gist != null && currentState.gist.totalCount > 0)
                return GistListScreen(
                    gist: currentState.gist,
                    login: login,
                    controller: controller);
              return NoDataPage(
                title: "No Gist Found",
                description:
                    "No gist created yet,\n Once new gist are created, they will be displayed here",
                icon: GIcons.code_24,
              );
            }
            return GLoader();
          },
        ),
      ),
    );
  }
}
