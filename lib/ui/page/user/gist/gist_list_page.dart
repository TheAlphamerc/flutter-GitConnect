import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_github_connect/bloc/people/index.dart';
import 'package:flutter_github_connect/helper/GIcons.dart';
import 'package:flutter_github_connect/ui/page/common/no_data_page.dart';
import 'package:flutter_github_connect/ui/page/user/gist/gist_list_screen.dart';
import 'package:flutter_github_connect/ui/widgets/g_loader.dart';

class GistlistPageProvider extends StatelessWidget {
  final String login;

  const GistlistPageProvider({Key key, this.login}) : super(key: key);
  static MaterialPageRoute getPageRoute(
    BuildContext context, {
    String login,
  }) {
    return MaterialPageRoute(
      builder: (context) {
        return BlocProvider<PeopleBloc>(
          create: (BuildContext context) => PeopleBloc()..add(OnGistLoad(login)),
          child: GistlistPageProvider(login:login),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GistlistPage(
      bloc: BlocProvider.of<PeopleBloc>(context),
      login:login
    );
  }
}

class GistlistPage extends StatelessWidget {
  const GistlistPage({Key key, this.bloc,this.login}) : super(key: key);
  final PeopleBloc bloc;
  final String login;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        title: Title(
          title: "Gist",
          color: Colors.black,
          child: Text("Gist", style: Theme.of(context).textTheme.headline6),
        ),
      ),
      body: Container(
        color: Theme.of(context).colorScheme.surface,
        child: BlocBuilder<PeopleBloc, PeopleState>(
          cubit: bloc,
          builder: (
            BuildContext context,
            PeopleState currentState,
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
                        bloc..add(OnGistLoad(login));
                        print("Load Notification");
                      },
                    ),
                  ),
                ],
              ));
            }
            if (currentState is LoadedGitState) {
              if(currentState.gist != null && currentState.gist.totalCount > 0)
              return GistListScreen(gist: currentState.gist);
              return Column(
                children: <Widget>[
                  NoDataPage(
                    title: "No Gist Found",
                    description:
                        "No gist created yet,\n Once new gist are created, they will be displayed here",
                    icon: GIcons.code_24,
                  ),
                ],
              );
            }
            if (currentState is OnPullRequestLoad) {
              return Center(
                child: Text("Loading"),
              );
            }
            return GLoader();
          },
        ),
      ),
    );
  }
}
