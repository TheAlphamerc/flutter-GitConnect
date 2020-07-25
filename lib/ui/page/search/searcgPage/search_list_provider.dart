import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_github_connect/bloc/search/index.dart';
import 'package:flutter_github_connect/helper/GIcons.dart';
import 'package:flutter_github_connect/ui/page/auth/repo/repo_list_screen.dart';
import 'package:flutter_github_connect/ui/page/search/searcgPage/issue_list_page.dart';
import 'package:flutter_github_connect/ui/page/search/searcgPage/user_list_page.dart';
import 'package:flutter_github_connect/ui/widgets/custom_text.dart';

class SearchListProvider extends StatelessWidget {
  final GithubSearchType type;

  const SearchListProvider({Key key, this.type}) : super(key: key);
  Widget _noContant(context) {
    return Container(
      alignment: Alignment.center,
      height: MediaQuery.of(context).size.height - 280,
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          // Image.asset(GImages.githubMarkLight120, width:160),
          Icon(GIcons.github_1, size: 120),
          SizedBox(height: 16),
          KText(
            "No user found",
            variant: TypographyVariant.title,
          ),
          SizedBox(height: 8),
          KText("Try again with different username",
              textAlign: TextAlign.center,
              variant: TypographyVariant.h3,
              style: TextStyle(letterSpacing: 1, height: 1.1)),
        ],
      ),
    );
  }
  
  String _getAppBarTitle(){
    switch (type) {
          case GithubSearchType.People: return "People";
          case GithubSearchType.Repository:return "Repository";
           case GithubSearchType.Issue: return "Issues";
            
          default: return "People";
            
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
            if (currentState.list == null) {
              return _noContant(context);
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
