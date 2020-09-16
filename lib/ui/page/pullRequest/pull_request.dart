import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_github_connect/bloc/User/index.dart';
import 'package:flutter_github_connect/bloc/people/index.dart';
import 'package:flutter_github_connect/helper/GIcons.dart';
import 'package:flutter_github_connect/ui/page/common/no_data_page.dart';
import 'package:flutter_github_connect/ui/page/pullRequest/pull_request_screen.dart';
import 'package:flutter_github_connect/ui/widgets/g_app_bar_title.dart';
import 'package:flutter_github_connect/ui/widgets/g_error_container.dart';
import 'package:flutter_github_connect/ui/widgets/g_loader.dart';

class PullRequestPageProvider extends StatefulWidget {
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
  _PullRequestPageProviderState createState() =>
      _PullRequestPageProviderState();
}

class _PullRequestPageProviderState extends State<PullRequestPageProvider> {
  ScrollController _controller;
  void initState() {
    _controller = ScrollController()..addListener(listener);
    super.initState();
  }

  void listener() {
    if (_controller.position.pixels == _controller.position.maxScrollExtent) {
      BlocProvider.of<PeopleBloc>(context)
          .add(OnPullRequestLoad(widget.login, isLoadNextIssues: true));
    }
  }

  @override
  Widget build(BuildContext context) {
    return PullRequestPageBody(
      controller: _controller,
      login: widget.login,
    );
  }
}

class PullRequestPageBody extends StatelessWidget {
  final ScrollController controller;
  final String login;

  const PullRequestPageBody({Key key, this.controller, this.login})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PullRequestPage(
        bloc: BlocProvider.of<PeopleBloc>(context),
        login: login,
        controller: controller);
  }
}

class PullRequestPage extends StatelessWidget {
  const PullRequestPage({Key key, this.bloc, this.login, this.controller})
      : super(key: key);
  final PeopleBloc bloc;
  final String login;
  final ScrollController controller;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(title: GAppBarTitle(login: login, title: "Pull Request")),
      body: Container(
        color: Theme.of(context).colorScheme.surface,
        child: BlocBuilder<PeopleBloc, PeopleState>(
          cubit: bloc,
          builder: (
            BuildContext context,
            PeopleState currentState,
          ) {
            if (currentState is ErrorPullRequestState) {
              return GErrorContainer(
                description: currentState.errorMessage,
                onPressed: () {
                  bloc..add(OnPullRequestLoad(login));
                },
              );
            }
            if (currentState is LoadedPullRequestState) {
              if (currentState.pullRequestsList != null &&
                  currentState.pullRequestsList.totalCount > 0)
                return PullRequestScreen(
                  pullRequest: currentState.pullRequestsList,
                  controller: controller,
                );
              return NoDataPage(
                title: "Empty issues",
                description:
                    "No pull request created yet,\n Once new pullr equest are created, they will be displayed here",
                icon: GIcons.git_pull_request_24,
              );
            }
            if (currentState is LoadingPullRequestState) {
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
