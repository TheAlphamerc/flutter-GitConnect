import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_github_connect/bloc/User/User_model.dart';
import 'package:flutter_github_connect/bloc/search/index.dart';
import 'package:flutter_github_connect/bloc/search/search_event.dart';
import 'package:flutter_github_connect/ui/page/repo/repo_detail_page.dart';
import 'package:flutter_github_connect/ui/theme/export_theme.dart';
import 'package:flutter_github_connect/ui/theme/extentions.dart';
import 'package:flutter_github_connect/ui/widgets/user_image.dart';

class RepositoryListScreen extends StatefulWidget {
  final List<RepositoriesNode> list;
  final bool hideAppBar;
  final Function onScollToBootom;

  const RepositoryListScreen(
      {Key key, this.list, this.hideAppBar = false, this.onScollToBootom})
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: widget.hideAppBar
          ? null
          : AppBar(
              title: Text("Repositories"),
            ),
      body: widget.list == null
          ? SizedBox()
          : ListView.separated(
              controller: _controller,
              itemCount: widget.list.length + 1,
              separatorBuilder: (BuildContext context, int index) =>
                  Divider(height: 0),
              itemBuilder: (BuildContext context, int index) {
                if (index >= widget.list.length) {
                  return BlocBuilder<SearchBloc, SearchState>(
                    builder: (context, state) {
                      if (state is LoadingNextSearchState)
                        return Container(
                          alignment: Alignment.center,
                          height: 30,
                          child: SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 1,
                              valueColor: AlwaysStoppedAnimation(GColors.blue),
                            ),
                          ),
                        );
                      ;
                      return SizedBox.shrink();
                    },
                  );
                }
                final repo = widget.list[index];
                return repoCard(context, repo);
              },
            ),
    );
  }
}
