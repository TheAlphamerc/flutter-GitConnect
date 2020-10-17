import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_github_connect/bloc/issues/index.dart';
import 'package:flutter_github_connect/helper/GIcons.dart';
import 'package:flutter_github_connect/ui/page/common/no_data_page.dart';
import 'package:flutter_github_connect/ui/page/search/searcgPage/issue_list_page.dart';
import 'package:flutter_github_connect/ui/theme/images.dart';
import 'package:flutter_github_connect/ui/widgets/g_app_bar_title.dart';
import 'package:flutter_github_connect/ui/widgets/g_error_container.dart';
import 'package:flutter_github_connect/ui/widgets/g_loader.dart';

class RepoIssuesPage extends StatefulWidget {
  final String owner;
  final String name;
  const RepoIssuesPage({Key key, this.owner, this.name}) : super(key: key);
  static getPageRoute({String owner, String name, int count}) => MaterialPageRoute(
        builder: (context) => BlocProvider(
          create: (BuildContext context) => IssuesBloc()..add(LoadRepoIssuesEvent(owner: owner, name: name, count: count)),
          child: RepoIssuesPage(
            name: name,
            owner: owner,
          ),
        ),
      );
  @override
  _RepoIssuesPagState createState() => _RepoIssuesPagState();
}

class _RepoIssuesPagState extends State<RepoIssuesPage> {
  ScrollController _controller;
  @override
  void initState() {
    _controller = ScrollController()..addListener(listener);
    super.initState();
  }

  void listener() {
    if (_controller.position.pixels == _controller.position.maxScrollExtent) {
      BlocProvider.of<IssuesBloc>(context).add(
        LoadRepoIssuesEvent(
          name: widget.name,
          owner: widget.owner,
          isLoadNextRepoIssues: true,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(title: GAppBarTitle(login: widget.name, title: "Issues")),
      body: BlocBuilder<IssuesBloc, IssuesState>(
        builder: (
          BuildContext context,
          IssuesState currentState,
        ) {
          if (currentState is LoadingRepoIssuesState) {
            return GLoader();
          }
          if (currentState is ErrorRepoIssuesState) {
            return GErrorContainer(
              description: currentState.errorMessage,
              onPressed: () {
                BlocProvider.of<IssuesBloc>(context)
                  ..add(LoadRepoIssuesEvent(
                    name: widget.name,
                    owner: widget.owner,
                  ));
              },
            );
          }
          if (currentState is LoadedRepoIssuesState) {
            if (currentState.isNotNullEmpty)
              return IssueListPage(list: currentState.issues.list, hideAppBar: true, controller: _controller);

            // If issues list is empty then display empty list message
            return NoDataPage(
              image: GImages.octocat3,
              title: "Empty issues",
              description: "Nothing is here to see!!",
              icon: GIcons.issue_opened_24,
            );
          }
          return GLoader();
        },
      ),
    );
  }
}
