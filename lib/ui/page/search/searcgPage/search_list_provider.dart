import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_github_connect/bloc/search/index.dart';
import 'package:flutter_github_connect/bloc/search/search_event.dart';
import 'package:flutter_github_connect/helper/GIcons.dart';
import 'package:flutter_github_connect/ui/page/repo/repo_list_screen.dart';
import 'package:flutter_github_connect/ui/page/common/no_data_page.dart';
import 'package:flutter_github_connect/ui/page/search/searcgPage/issue_list_page.dart';
import 'package:flutter_github_connect/ui/page/search/searcgPage/user_list_page.dart';
import 'package:flutter_github_connect/ui/widgets/g_error_container.dart';
import 'package:flutter_github_connect/ui/widgets/g_loader.dart';

class SearchListProvider extends StatefulWidget {
  static MaterialPageRoute route({GithubSearchType type, String query}) {
    return MaterialPageRoute(
      builder: (context) => BlocProvider<SearchBloc>(
        create: (BuildContext context) =>
            SearchBloc()..add(SearchForEvent(query: query, type: type)),
        child: SearchListProvider(
          query: query,
          type: type,
        ),
      ),
    );
  }

  final GithubSearchType type;
  final String query;
  const SearchListProvider({Key key, this.type, this.query}) : super(key: key);

  @override
  _SearchListProviderState createState() => _SearchListProviderState();
}

class _SearchListProviderState extends State<SearchListProvider> {
  ScrollController _controller;
  @override
  void initState() {
    _controller = ScrollController()..addListener(listener);
    super.initState();
  }

  void listener() {
    if (_controller.position.pixels == _controller.position.maxScrollExtent) {
      BlocProvider.of<SearchBloc>(context)
          .add(SearchForEvent(query: widget.query, type: widget.type));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).colorScheme.surface,
        title: Text(widget.type.asSmallString()),
      ),
      body: BlocBuilder<SearchBloc, SearchState>(
        builder: (
          BuildContext context,
          SearchState currentState,
        ) {
          if (currentState is ErrorRepoState) {
            return GErrorContainer(
              description: currentState.errorMessage,
              onPressed: () {
                BlocProvider.of<SearchBloc>(context)
                  ..add(SearchForEvent(query: widget.query, type: widget.type));
              },
            );
          }

          if (currentState is LoadedSearchState) {
            if (!(currentState.list != null && currentState.list.isNotEmpty)) {
              return NoDataPage(
                title: "No ${widget.type.asSmallString()} Found",
                description: "Try again with different keyword",
                icon: GIcons.github_1,
              );
            }
            switch (currentState.type) {
              case GithubSearchType.Repository:
                return RepositoryListScreen(
                  isFromUserRepositoryListPage: true,
                  list: currentState.toRepositoryList(),
                  controller: _controller,
                );
              case GithubSearchType.People:
                return UserListPage(
                    hideAppBar: true,
                    list: currentState.toUSerList(),
                    controller: _controller);

              case GithubSearchType.Issue:
                return IssueListPage(
                  hideAppBar: true,
                  list: currentState.toIssueList(),
                  controller: _controller,
                );
              default:
            }
          }
          return GLoader();
        },
      ),
    );
  }
}
