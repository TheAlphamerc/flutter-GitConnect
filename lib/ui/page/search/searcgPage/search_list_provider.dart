import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_github_connect/bloc/search/index.dart';
import 'package:flutter_github_connect/helper/GIcons.dart';
import 'package:flutter_github_connect/ui/page/auth/repo/repo_list_screen.dart';
import 'package:flutter_github_connect/ui/page/common/no_data_page.dart';
import 'package:flutter_github_connect/ui/page/search/searcgPage/issue_list_page.dart';
import 'package:flutter_github_connect/ui/page/search/searcgPage/user_list_page.dart';

class SearchListProvider extends StatelessWidget {
  final GithubSearchType type;

  const SearchListProvider({Key key, this.type}) : super(key: key);

  String _getAppBarTitle() {
    switch (type) {
      case GithubSearchType.People:
        return "People";
      case GithubSearchType.Repository:
        return "Repository";
      case GithubSearchType.Issue:
        return "Issues";

      default:
        return "People";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).colorScheme.surface,
        title: Text(_getAppBarTitle()),
      ),
      body: BlocBuilder<SearchBloc, SearchState>(
        builder: (
          BuildContext context,
          SearchState currentState,
        ) {
          if (currentState is ErrorRepoState) {
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
                    onPressed: () {},
                  ),
                ),
              ],
            ));
          }
          if (currentState is LoadedSearchState) {
            if (!(currentState.list != null && currentState.list.isNotEmpty)) {
              return Column(
                children: <Widget>[
                  NoDataPage(
                    title: "No ${_getAppBarTitle()} Found",
                    description: "Try again with different keyword",
                    icon: GIcons.github_1,
                  ),
                ],
              );
            }
            switch (currentState.type) {
              case GithubSearchType.Repository:
                return RepositoryListScreen(
                  hideAppBar: true,
                  list: currentState.toRepositoryList(),
                );
              case GithubSearchType.People:
                return UserListPage(
                  hideAppBar: true,
                  list: currentState.toUSerList(),
                );

              case GithubSearchType.Issue:
                return IssueListPage(
                  hideAppBar: true,
                  list: currentState.toIssueList(),
                );
              default:
            }
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
