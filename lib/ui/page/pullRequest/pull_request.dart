import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_github_connect/bloc/User/index.dart';
import 'package:flutter_github_connect/bloc/people/index.dart';
import 'package:flutter_github_connect/helper/GIcons.dart';
import 'package:flutter_github_connect/ui/page/common/no_data_page.dart';
import 'package:flutter_github_connect/ui/page/pullRequest/pull_request_screen.dart';
import 'package:flutter_github_connect/ui/widgets/g_card.dart';

class PullRequestPageProvider extends StatelessWidget {
  final String login;

  const PullRequestPageProvider({Key key, this.login}) : super(key: key);
  static MaterialPageRoute getPageRoute(
    BuildContext context, {
    String login,
  }) {
    return MaterialPageRoute(
      builder: (context) {
        return BlocProvider<PeopleBloc>(
          create: (BuildContext context) =>
              PeopleBloc()..add(OnPullRequestLoad(login)),
          child: PullRequestPageProvider(login: login),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return PullRequestPage(
        bloc: BlocProvider.of<PeopleBloc>(context), login: login);
  }
}

class PullRequestPage extends StatelessWidget {
  const PullRequestPage({Key key, this.bloc, this.login}) : super(key: key);
  final PeopleBloc bloc;
  final String login;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        title: Title(
          title: "Pull Request",
          color: Colors.black,
          child: Text("Pull Request",
              style: Theme.of(context).textTheme.headline6),
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
            if (currentState is ErrorPullRequestState) {
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
                        bloc..add(OnPullRequestLoad(login));
                        print("Load Notification");
                      },
                    ),
                  ),
                ],
              ));
            }
            if (currentState is LoadedPullRequestState) {
              if (currentState.pullRequestsList != null &&
                  currentState.pullRequestsList.totalCount > 0)
                return PullRequestScreen(
                    pullRequest: currentState.pullRequestsList);
              return Column(
                children: <Widget>[
                  NoDataPage(
                    title: "Empty issues",
                    description:
                        "No pullrequest created yet,\n Once new pullrequest are created, they will be displayed here",
                    icon: GIcons.git_pull_request_24,
                  ),
                ],
              );
            }
            if (currentState is LoadingPullRequestState) {
              return Center(
                child: CircularProgressIndicator(),
              );
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
