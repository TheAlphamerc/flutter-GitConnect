import 'package:flutter/material.dart';
import 'package:flutter_github_connect/bloc/User/User_model.dart';
import 'package:flutter_github_connect/ui/page/repo/repo_detail_page.dart';
import 'package:flutter_github_connect/ui/theme/extentions.dart';
import 'package:flutter_github_connect/ui/widgets/user_image.dart';

class RepositoryListScreen extends StatelessWidget {
  final List<RepositoriesNode> list;
  final bool hideAppBar;

  const RepositoryListScreen({Key key, this.list, this.hideAppBar = false})
      : super(key: key);
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
      appBar: hideAppBar
          ? null
          : AppBar(
              title: Text("Repositories"),
            ),
      body: list == null
          ? SizedBox()
          : ListView.separated(
              itemCount: list.length,
              separatorBuilder: (BuildContext context, int index) =>
                  Divider(height: 0),
              itemBuilder: (BuildContext context, int index) {
                final repo = list[index];
                return repoCard(context, repo);
              },
            ),
    );
  }
}
