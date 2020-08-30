import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_github_connect/bloc/User/User_model.dart';
import 'package:flutter_github_connect/bloc/User/index.dart';
import 'package:flutter_github_connect/bloc/people/people_bloc.dart';
import 'package:flutter_github_connect/bloc/people/people_state.dart' as people;
import 'package:flutter_github_connect/bloc/search/index.dart';
import 'package:flutter_github_connect/ui/page/repo/repo_detail_page.dart';
import 'package:flutter_github_connect/ui/theme/export_theme.dart';
import 'package:flutter_github_connect/ui/theme/extentions.dart';
import 'package:flutter_github_connect/ui/widgets/user_image.dart';

class RepositoryListScreen extends StatefulWidget {
  final List<RepositoriesNode> list;
  final bool isFromUserRepositoryListPage;
  final UserBloc userBloc;
  final PeopleBloc peopleBloc;
  final Function onScollToBootom;

  /// `isFromUserRepositoryListPage` will be set to true if this screen is used as widget
  const RepositoryListScreen(
      {Key key,
      this.list,
      this.isFromUserRepositoryListPage = false,
      this.onScollToBootom,
      this.userBloc,
      this.peopleBloc})
      : super(key: key);

  @override
  _RepositoryListScreenState createState() => _RepositoryListScreenState();
}

class _RepositoryListScreenState extends State<RepositoryListScreen> {
  ScrollController _controller;
  @override
  void initState() {
    _controller = ScrollController()..addListener(listener);
    super.initState();
  }

  void listener() {
    if (_controller.position.pixels == _controller.position.maxScrollExtent) {
      widget.onScollToBootom();
    }
  }

  Widget repoCard(context, RepositoriesNode repo) {
    return Container(
      color: Theme.of(context).colorScheme.surface,
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          UserAvatar(
            subtitle: repo.owner.login,
            imagePath: repo.owner.avatarUrl,
            titleStyle: Theme.of(context).textTheme.subtitle1,
          ),
          SizedBox(height: 16),
          Text(
            repo.name,
            style: Theme.of(context).textTheme.bodyText1,
          ),
          SizedBox(height: 4),
          Text(
            repo.description ?? "N/A",
            style: Theme.of(context).textTheme.subtitle2,
          ),
          SizedBox(height: 16),
          repo.languages.nodes.isEmpty
              ? SizedBox()
              : Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(bottom: 3),
                      child: Icon(Icons.star,
                          size: 20, color: Colors.yellowAccent[700]),
                    ),
                    SizedBox(width: 10),
                    Text(
                      "${repo.stargazers.totalCount}",
                      style: Theme.of(context).textTheme.subtitle2,
                    ),
                    SizedBox(width: 20),
                    Icon(
                      Icons.blur_circular,
                      color: repo.languages.nodes.first.color,
                      size: 15,
                    ),
                    SizedBox(width: 5),
                    Text(
                      "${repo.languages.nodes.first.name}",
                      style: Theme.of(context).textTheme.subtitle2,
                    ),
                  ],
                ),
        ],
      ),
    ).ripple(() {
      Navigator.of(context).push(RepoDetailPage.getPageRoute(
        context,
        name: repo.name,
        owner: repo.owner.login,
      ));
    });
  }

  Widget _repoList(List<RepositoriesNode> list, {bool displayLoader = false}) {
    return ListView.separated(
      controller: _controller,
      itemCount: list.length + 1,
      separatorBuilder: (BuildContext context, int index) => Divider(height: 0),
      itemBuilder: (BuildContext context, int index) {
        if ((index >= list.length && !widget.isFromUserRepositoryListPage) &&
            (widget.peopleBloc != null || widget.userBloc != null)) {
          print("Display Loader1");
          return displayLoader ? _loader() : SizedBox.shrink();
        } else if (index >= list.length &&
            widget.isFromUserRepositoryListPage) {
          print("Display Loader2s");
          return BlocBuilder<SearchBloc, SearchState>(
            builder: (context, state) {
              if (state is LoadingNextSearchState) return _loader();

              return SizedBox.shrink();
            },
          );
        }
        final repo = list[index];
        print("Display List");
        return repoCard(context, repo);
      },
    );
  }

  Widget _loader() {
    return Container(
      alignment: Alignment.center,
      height: 60,
      child: SizedBox(
        height: 20,
        width: 20,
        child: CircularProgressIndicator(
          strokeWidth: 1,
          valueColor: AlwaysStoppedAnimation(GColors.blue),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: widget.isFromUserRepositoryListPage
          ? null
          : AppBar(
              title: Text("Repositories"),
            ),
      body: widget.list == null
          ? SizedBox()
          : !widget.isFromUserRepositoryListPage
              ? widget.peopleBloc != null
                  ? BlocBuilder<PeopleBloc, people.PeopleState>(
                      cubit: widget.peopleBloc,
                      buildWhen: (old, newState) {
                        return (old != newState);
                      },
                      builder: (context, state) {
                        bool displayLoader = false;
                        if (state is LoadingNextRepositoriesState)
                          displayLoader = true;
                        if (state is people.LoadedUserState) {
                          return _repoList(state.user.repositories.nodes,
                              displayLoader: displayLoader);
                        } else {
                          return CircularProgressIndicator();
                        }
                      },
                    )
                  : BlocBuilder<UserBloc, UserState>(
                      cubit: widget.userBloc,
                      buildWhen: (old, newState) {
                        return (old != newState);
                      },
                      builder: (context, state) {
                        bool displayLoader = false;
                        if (state is LoadingNextRepositoriesState)
                          displayLoader = true;
                        if (state is LoadedUserState) {
                          return _repoList(state.user.repositories.nodes,
                              displayLoader: displayLoader);
                        } else {
                          return CircularProgressIndicator();
                        }
                      },
                    )
              : _repoList(widget.list),
    );
  }
}
