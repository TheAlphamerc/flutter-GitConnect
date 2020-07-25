import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_github_connect/bloc/issues/index.dart';
import 'package:flutter_github_connect/ui/page/search/searcgPage/issue_list_page.dart';

class IssuesPage extends StatefulWidget {
  static const String routeName = '/issues';
  static route() => MaterialPageRoute(
        builder: (context) => BlocProvider(
          create: (BuildContext context) =>
              IssuesBloc()..add(LoadIssuesEvent()),
          child: IssuesPage(),
        ),
      );
  @override
  _IssuesPageState createState() => _IssuesPageState();
}

class _IssuesPageState extends State<IssuesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(title: Text("Issues")),
      body: BlocBuilder<IssuesBloc, IssuesState>(
        builder: (
          BuildContext context,
          IssuesState currentState,
        ) {
          if (currentState is LoadingUserState) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (currentState is ErrorIssuesState) {
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
                      BlocProvider.of<IssuesBloc>(context)
                        ..add(LoadIssuesEvent());
                    },
                  ),
                ),
              ],
            ));
          }
          if (currentState is LoadedIssuesState) {
            return IssueListPage(
              list: currentState.list,
              hideAppBar: true,
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
