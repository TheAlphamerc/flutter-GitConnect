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

class IssuesPage extends StatefulWidget {
  final String login;

  const IssuesPage({
    Key key,
    this.login,
  }) : super(key: key);
  static route(String login,{int count}) => MaterialPageRoute(
        builder: (context) => BlocProvider(
          create: (BuildContext context) =>
              IssuesBloc()..add(LoadIssuesEvent(login,count:count)),
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
      appBar:  AppBar(title: GAppBarTitle(title: "Issues")),
      body: BlocBuilder<IssuesBloc, IssuesState>(
        builder: (
          BuildContext context,
          IssuesState currentState,
        ) {
          if (currentState is LoadingUserIssuesState) {
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
              image: GImages.octocat6,
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
