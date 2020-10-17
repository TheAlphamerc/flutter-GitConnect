import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_github_connect/bloc/gist/gist_bloc.dart';
import 'package:flutter_github_connect/bloc/people/index.dart';
import 'package:flutter_github_connect/helper/GIcons.dart';
import 'package:flutter_github_connect/ui/page/common/no_data_page.dart';
import 'package:flutter_github_connect/ui/page/user/gist/gist_list_screen.dart';
import 'package:flutter_github_connect/ui/theme/images.dart';
import 'package:flutter_github_connect/ui/widgets/g_app_bar_title.dart';
import 'package:flutter_github_connect/ui/widgets/g_error_container.dart';
import 'package:flutter_github_connect/ui/widgets/g_loader.dart';

class GistlistPageProvider extends StatefulWidget {
  final String login;
  const GistlistPageProvider({Key key, this.login}) : super(key: key);
  static MaterialPageRoute getPageRoute(BuildContext context, {String login, int count}) {
    return MaterialPageRoute(
      builder: (context) {
        return BlocProvider<GistBloc>(
          create: (BuildContext context) => GistBloc()..add(OnGistLoad(login, count: count)),
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
      BlocProvider.of<GistBloc>(context).add(OnGistLoad(widget.login, isLoadNextGist: true));
    }
  }

  @override
  Widget build(BuildContext context) {
    return GistlistPage(bloc: BlocProvider.of<GistBloc>(context), login: widget.login, controller: _controller);
  }
}

class GistlistPage extends StatelessWidget {
  const GistlistPage({Key key, this.bloc, this.login, this.controller}) : super(key: key);
  final GistBloc bloc;
  final String login;
  final ScrollController controller;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(title: GAppBarTitle(login: login, title: "Gists")),
      body: Container(
        child: BlocBuilder<GistBloc, GistState>(
          cubit: bloc,
          builder: (
            BuildContext context,
            GistState currentState,
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
              if (currentState.isNotNullEmpty) return GistListScreen(gist: currentState.gist, login: login, controller: controller);
              return NoDataPage(
                title: "",
                image: GImages.octocat4,
                description: "Nothing to see here!!",
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
