import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_github_connect/bloc/User/User_model.dart';
import 'package:flutter_github_connect/bloc/User/index.dart';
import 'package:flutter_github_connect/bloc/User/model/event_model.dart';
import 'package:flutter_github_connect/bloc/people/index.dart';
import 'package:flutter_github_connect/helper/GIcons.dart';
import 'package:flutter_github_connect/helper/utility.dart';
import 'package:flutter_github_connect/ui/page/auth/repo/repo_list_screen.dart';
import 'package:flutter_github_connect/ui/page/issues/issues_page.dart';
import 'package:flutter_github_connect/ui/page/people/people_page.dart';
import 'package:flutter_github_connect/ui/page/pullRequest/pull_request.dart';
import 'package:flutter_github_connect/ui/page/repo/repo_detail_page.dart';
import 'package:flutter_github_connect/ui/page/settings/settings_page.dart';
import 'package:flutter_github_connect/ui/page/user/gist/gist_list_page.dart';
import 'package:flutter_github_connect/ui/theme/export_theme.dart';
import 'package:flutter_github_connect/ui/widgets/g_card.dart';
import 'package:flutter_github_connect/ui/widgets/user_image.dart';

class UserScreen extends StatelessWidget {
  final UserModel model;
  final UserBloc bloc;

  const UserScreen({Key key, this.model, this.bloc}) : super(key: key);

  Widget _iconWithText(context, IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: <Widget>[
          Icon(icon, color: Theme.of(context).colorScheme.onSurface, size: 18),
          SizedBox(width: 10),
          Text(
            text ?? "N/A",
            style: Theme.of(context).textTheme.bodyText1,
          )
        ],
      ),
    );
  }

  void loadPeoples(context, PeopleType type) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) {
          return BlocProvider<PeopleBloc>(
            create: (BuildContext context) =>
                PeopleBloc()..add(LoadFollowerEvent(model.login, type)),
            child: ActorPage(type: type),
          );
        },
      ),
    );
  }

  Widget topRepoCard(context, TopRepositoriesNode repo) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
      child: GCard(
        width: MediaQuery.of(context).size.width * .7,
        // margin: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            UserAvatar(
              name: repo.owner.login,
              imagePath: repo.owner.avatarUrl,
            ),
            SizedBox(height: 16),
            Text(
              repo.name,
            ),
            SizedBox(height: 8),
            Spacer(),
            Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(bottom: 5),
                  child: Icon(GIcons.star_fill_24,
                      size: 16, color: Colors.yellowAccent[700]),
                ),
                SizedBox(width: 10),
                Text(
                  "${repo.stargazers.totalCount}",
                  style: Theme.of(context).textTheme.subtitle2,
                ),
                SizedBox(width: 20),
                if(repo.languages != null && repo.languages.nodes.isNotEmpty)
                Icon(
                  Icons.blur_circular,
                  color: repo.languages.nodes.first.color,
                  size: 15,
                ),
                SizedBox(width: 5),
                if(repo.languages != null && repo.languages.nodes.isNotEmpty)
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
      }),
    );
  }

  Widget _keyValueTile(context, String key, String value,
      {Function onPressed}) {
    return InkWell(
      onTap: onPressed,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          children: <Widget>[
            Text(key, style: Theme.of(context).textTheme.bodyText1),
            Spacer(),
            Text(
              value,
              style: Theme.of(context).textTheme.subtitle2,
            ),
            Icon(
              GIcons.chevron_right_24,
              color: Theme.of(context).colorScheme.onSurface,
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.surface,
        elevation: 0,
        actions: <Widget>[
          IconButton(
            icon: Icon(GIcons.share_android_24, color: GColors.blue),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(GIcons.settings_24, color: GColors.blue),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => SettingsPage(),
                ),
              );
            },
          ),
        ],
      ),
      body: CustomScrollView(
        physics: BouncingScrollPhysics(),
        slivers: <Widget>[
          SliverToBoxAdapter(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              color: theme.colorScheme.surface,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  UserAvatar(
                    name: model.name,
                    subtitle: model.login,
                    imagePath: model.avatarUrl,
                    height: 64,
                  ),
                  SizedBox(height: 8),
                  GCard(
                    width: double.infinity,
                    margin: EdgeInsets.symmetric(vertical: 12),
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                    child: Text(
                      model?.status?.message ?? "N/A",
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                  ),
                  Text(
                    model.bio,
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  SizedBox(height: 8),
                  _iconWithText(context, GIcons.people_24, model.login),
                  _iconWithText(context, GIcons.link_24, model.websiteUrl),
                  _iconWithText(context, GIcons.gift_24,
                      Utility.toDMYformate(model.createdAt)),
                  _iconWithText(context, Icons.location_city, model.location),
                  // _iconWithText(context, GIcons.person_24,
                  //     "${model.followers.totalCount} flollowers  ${model.following.totalCount} Following"),
                  Row(
                    children: <Widget>[
                      _iconWithText(context, GIcons.person_24,
                          "${model.followers.totalCount}"),
                      SizedBox(width: 10),
                      Text(
                        "Followers",
                        style: Theme.of(context).textTheme.subtitle1,
                      ).ripple(() {
                        loadPeoples(context, PeopleType.Follower);
                      }),
                      SizedBox(width: 20),
                      Text(
                        "${model.following.totalCount}",
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                      SizedBox(width: 10),
                      Text(
                        "Following",
                        style: Theme.of(context).textTheme.subtitle1,
                      ).ripple(
                        () {
                          loadPeoples(context, PeopleType.Following);
                        },
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 12),
              margin: EdgeInsets.symmetric(vertical: 16),
              color: theme.colorScheme.surface,
              child: Column(
                children: <Widget>[
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "Top Repository",
                          style: Theme.of(context).textTheme.headline6,
                        ).hP16,
                        SizedBox(height: 8),
                        Container(
                          height: 150,
                          width: double.infinity,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            physics: BouncingScrollPhysics(),
                            itemCount: model.topRepositories.nodes.length,
                            itemBuilder: (context, index) {
                              final repo = model.topRepositories.nodes[index];
                              return topRepoCard(context, repo);
                            },
                          ),
                        )
                      ]),
                  _keyValueTile(
                    context,
                    "Repository",
                    model.repositories.totalCount.toString(),
                    onPressed: () {
                      print("Get user Repository");
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => RepositoryListScreen(
                            list: model.repositories.nodes,
                          ),
                        ),
                      );
                    },
                  ).hP16,
                  _keyValueTile(
                      context,
                      "Public Gist",
                      model?.gists?.totalCount != null
                          ? model.gists.totalCount.toString()
                          : "N/A", onPressed: () {
                    bloc.add(OnGistLoad());
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => GistlistPage(
                          bloc: bloc,
                        ),
                      ),
                    );
                  }).hP16,
                  _keyValueTile(
                    context,
                    "Pull Request",
                    model.pullRequests.totalCount.toString(),
                    onPressed: () {
                      bloc.add(OnPullRequestLoad());
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => PullRequestPage(bloc: bloc),
                        ),
                      );
                    },
                  ).hP16,
                  _keyValueTile(
                    context,
                    "Issues",
                    model.issues.totalCount.toString(),
                    onPressed: () {
                      Navigator.push(context, IssuesPage.route());
                    },
                  ).hP16,
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
