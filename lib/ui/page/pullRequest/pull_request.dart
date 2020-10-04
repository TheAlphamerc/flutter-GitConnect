import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_github_connect/bloc/User/index.dart';
// import 'package:flutter_github_connect/bloc/people/index.dart';
import 'package:flutter_github_connect/bloc/pullrequest/index.dart';
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
    int count
  }) {
    return MaterialPageRoute(
      builder: (context) {
        return BlocProvider<PullrequestBloc>(
          create: (BuildContext context) =>
              PullrequestBloc()..add(OnPullRequestLoad(login,count:count)),
          child: PullRequestPageProvider(login:login),
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
      BlocProvider.of<PullrequestBloc>(context)
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
        bloc: BlocProvider.of<PullrequestBloc>(context),
        login: login,
        controller: controller);
  }
}

class PullRequestPage extends StatelessWidget {
  const PullRequestPage({Key key, this.bloc, this.login, this.controller})
      : super(key: key);
  final PullrequestBloc bloc;
  final String login;
  final ScrollController controller;
  @override
  Widget build(BuildContext context) {
    return Scaffold( 
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(title: GAppBarTitle(login: login, title: "Pull Request")),
      body: Container(
        color: Theme.of(context).colorScheme.surface,
        child: BlocBuilder<PullrequestBloc, PullrequestState>(
          cubit: bloc,
          builder: (
            BuildContext context,
            PullrequestState currentState,
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
                title: "",
                description:
                    "No pull request created yet",
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


class RepoPullRequestPageProvider extends StatefulWidget {
  final String name;
  final String owner;
  final int count;
  const RepoPullRequestPageProvider({Key key, this.name,this.owner,this.count}) : super(key: key);
  static MaterialPageRoute getPageRoute(
    BuildContext context, {
    String name,
    String owner,
    int count
  }) {
    return MaterialPageRoute(
      builder: (context) {
        return BlocProvider<PullrequestBloc>(
          create: (BuildContext context) =>
              PullrequestBloc()..add(LoadRepoPullRequests(name:name,owner:owner,count:count)),
          child: RepoPullRequestPageProvider(name: name, owner:owner,count:count),
        );
      },
    );
  }

  @override
  _RepoPullRequestPageProviderState createState() =>
      _RepoPullRequestPageProviderState();
}

class _RepoPullRequestPageProviderState extends State<RepoPullRequestPageProvider> {
  ScrollController _controller;
  void initState() {
    _controller = ScrollController()..addListener(listener);
    super.initState();
  }

  void listener() {
    if (_controller.position.pixels == _controller.position.maxScrollExtent) {
      print(widget.name);
      BlocProvider.of<PullrequestBloc>(context)
          .add(LoadRepoPullRequests(name:widget.name,owner:widget.owner,isNextRepoPull:true));
    }
  }

  @override
  Widget build(BuildContext context) {
    return RepoPullRequestPage(
      controller: _controller,
      login: widget.name,
      name:widget.name,
      owner:widget.owner
    );
  }
}


class RepoPullRequestPage extends StatelessWidget {
  const RepoPullRequestPage({Key key, this.bloc, this.owner,this.name,this.login, this.controller})
      : super(key: key);
  final PullrequestBloc bloc;
  final String name;
  final String owner;
  final String login;
  final ScrollController controller;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(title: GAppBarTitle(login: login, title: "Pull Request")),
      body: Container(
        color: Theme.of(context).colorScheme.surface,
        child: BlocBuilder<PullrequestBloc, PullrequestState>(
          cubit: bloc,
          builder: (
            BuildContext context,
            PullrequestState currentState,
          ) {
            if (currentState is ErrorRepoPullrequestState) {
              return GErrorContainer(
                description: currentState.errorMessage,
                onPressed: () {
                  bloc..add(LoadRepoPullRequests(name:name,owner:owner));
                },
              );
            }
            if (currentState is LoadedRepoPullRequest) {
              if (currentState.repoPullRequest != null &&
                  currentState.repoPullRequest.totalCount > 0)
                return PullRequestScreen(
                  pullRequest: currentState.repoPullRequest,
                  controller: controller,
                );
              return NoDataPage(
                title: "",
                description:
                    "No pull request created yet",
                icon: GIcons.git_pull_request_24,
              );
            }
            if (currentState is LoadingRepoPullRequest) {
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
