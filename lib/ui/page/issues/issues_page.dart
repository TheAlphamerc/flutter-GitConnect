import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_github_connect/bloc/issues/index.dart';
import 'package:flutter_github_connect/helper/GIcons.dart';
import 'package:flutter_github_connect/ui/page/common/no_data_page.dart';
import 'package:flutter_github_connect/ui/page/search/searcgPage/issue_list_page.dart';
import 'package:flutter_github_connect/ui/widgets/g_error_container.dart';
import 'package:flutter_github_connect/ui/widgets/g_loader.dart';

class IssuesPage extends StatefulWidget {
  final String login;
  static const String routeName = '/issues';

  const IssuesPage({
    Key key,
    this.login,
  }) : super(key: key);
  static route(String login) => MaterialPageRoute(
        builder: (context) => BlocProvider(
          create: (BuildContext context) =>
              IssuesBloc()..add(LoadIssuesEvent(login)),
          child: IssuesPage(),
        ),
      );
  @override
  _IssuesPageState createState() => _IssuesPageState();
}

class _IssuesPageState extends State<IssuesPage> {
  ScrollController _controller;
  @override
  void initState() {
    _controller = ScrollController()..addListener(listener);
    super.initState();
  }

  void listener() {
    if (_controller.position.pixels == _controller.position.maxScrollExtent) {
      BlocProvider.of<IssuesBloc>(context).add(
        LoadIssuesEvent(
          widget.login,
          isLoadNextIssues: true,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(title: Text("Issues")),
      body: BlocBuilder<IssuesBloc, IssuesState>(
        builder: (
          BuildContext context,
          IssuesState currentState,
        ) {
          if (currentState is LoadingUserState) {
            return GLoader();
          }
          if (currentState is ErrorIssuesState) {
            return GErrorContainer(
              description: currentState.errorMessage,
              onPressed: () {
                BlocProvider.of<IssuesBloc>(context)
                  ..add(LoadIssuesEvent(widget.login));
              },
            );
          }
          if (currentState is LoadedIssuesState) {
            if (currentState.issues.list != null &&
                currentState.issues.list.isNotEmpty)
              return IssueListPage(
                  list: currentState.issues.list,
                  hideAppBar: true,
                  controller: _controller);

            // If issues list is empty then display empty list message
            return NoDataPage(
              title: "Empty issues",
              description:
                  "No issue created yet,\n Once new issues are created, they will be displayed here",
              icon: GIcons.issue_opened_24,
            );
          }
          return GLoader();
        },
      ),
    );
  }
}
