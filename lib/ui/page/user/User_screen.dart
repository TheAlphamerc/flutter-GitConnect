import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_github_connect/bloc/User/User_model.dart';
import 'package:flutter_github_connect/bloc/User/index.dart';
import 'package:flutter_github_connect/bloc/people/index.dart' as people;
import 'package:flutter_github_connect/bloc/people/people_bloc.dart';
import 'package:flutter_github_connect/helper/GIcons.dart';
import 'package:flutter_github_connect/helper/utility.dart';
import 'package:flutter_github_connect/ui/page/auth/repo/repo_list_screen.dart';
import 'package:flutter_github_connect/ui/page/issues/issues_page.dart';
import 'package:flutter_github_connect/ui/page/people/people_page.dart';
import 'package:flutter_github_connect/ui/page/pullRequest/pull_request.dart';
import 'package:flutter_github_connect/ui/page/repo/repo_detail_page.dart';
import 'package:flutter_github_connect/ui/page/settings/settings_page.dart';
import 'package:flutter_github_connect/ui/page/user/gist/gist_list_page.dart';
import 'package:flutter_github_connect/ui/page/user/widget/git_contribution_graph.dart';
import 'package:flutter_github_connect/ui/theme/export_theme.dart';
import 'package:flutter_github_connect/ui/widgets/flat_button.dart';
import 'package:flutter_github_connect/ui/widgets/g_card.dart';
import 'package:flutter_github_connect/ui/widgets/user_image.dart';

class UserScreen extends StatelessWidget {
  final UserModel model;
  final UserBloc bloc;
  final PeopleBloc peopleBloc;
  final bool isHideAppBar;

  static MaterialPageRoute getPageRoute(BuildContext context, UserModel user) {
    return MaterialPageRoute(
      builder: (_) => UserScreen(
        model: user,
        bloc: BlocProvider.of<UserBloc>(context),
      ),
    );
  }

  const UserScreen(
      {Key key,
      this.model,
      this.bloc,
      this.peopleBloc,
      this.isHideAppBar = false})
      : super(key: key);

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

  Widget _pinnedRepoSection(BuildContext context) {
    return model.itemShowcase.items.nodes.isNotEmpty
        ? Container(
            height: 150,
            width: double.infinity,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              physics: BouncingScrollPhysics(),
              itemCount: model.itemShowcase.items.nodes.length,
              itemBuilder: (context, index) {
                final repo = model.itemShowcase.items.nodes[index];
                return _pinnedRepoCard(context, repo);
              },
            ),
          )
        : GCard(
            margin: EdgeInsets.symmetric(horizontal: 16),
            color: Theme.of(context).colorScheme.surface,
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: Column(
              children: <Widget>[
                Text(
                  "Pin repositories to profile for quick access at any time, without having to search",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyText2,
                ),
                SizedBox(height: 16),
                GFlatButton(
                  label: "PIN REPOSITORY",
                  onPressed: () {},
                ).ripple(() {})
              ],
            ),
          );
  }

  Widget _pinnedRepoCard(context, Node repo) {
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
            Container(
              width: MediaQuery.of(context).size.width * .65,
              child: Text(
                repo.name,
                maxLines: 2,
              ),
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
                if (repo.languages != null && repo.languages.nodes.isNotEmpty)
                  Icon(
                    Icons.blur_circular,
                    color: repo.languages.nodes.first.color,
                    size: 15,
                  ),
                SizedBox(width: 5),
                if (repo.languages != null && repo.languages.nodes.isNotEmpty)
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

  void loadPeoples(context, people.PeopleType type) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) {
          return BlocProvider<people.PeopleBloc>(
            create: (BuildContext context) => people.PeopleBloc()
              ..add(people.LoadFollowerEvent(model.login, type)),
            child: ActorPage(type: type),
          );
        },
      ),
    );
  }

  void onScollToBottom(context) {
    bloc..add(OnLoad(isLoadNextRepositories: true));
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: isHideAppBar
          ? null
          : AppBar(
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
                  if (model.bio != null && model.bio.isNotEmpty)
                    Text(
                      model.bio,
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                  if (model.bio != null && model.bio.isNotEmpty)
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
                        loadPeoples(context, people.PeopleType.Follower);
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
                          loadPeoples(context, people.PeopleType.Following);
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
              height: 154,
              padding: EdgeInsets.symmetric(
                vertical: 8,
              ),
              margin: EdgeInsets.only(top: 16),
              color: theme.colorScheme.surface,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Github Contribution",
                    style: Theme.of(context).textTheme.headline6,
                  ).hP16,
                  SizedBox(height: 8),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        SizedBox(width: 16),
                        GitContributionGraph(
                          login: model.login,
                        )
                      ],
                    ),
                  ),
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
                      Row(
                        children: [
                          SizedBox(width: 10),
                          Icon(GIcons.pin_24,
                              size: 20,
                              color:
                                  Theme.of(context).textTheme.headline6.color),
                          Text(
                            "Pinned",
                            style: Theme.of(context).textTheme.headline6,
                          ).hP16,
                        ],
                      ),
                      SizedBox(height: 8),
                      _pinnedRepoSection(context)
                    ],
                  ),
                  SizedBox(height: 8),
                  Divider(height: 1),
                  _keyValueTile(
                    context,
                    "Repository",
                    model.repositories.totalCount.toString(),
                    onPressed: () {
                      print("Get user Repository");
                      Navigator.push(
                          context,
                          RepositoryListScreen.getPageRoute(
                            list: model.repositories.nodes,
                            onScollToBottom: () {
                              onScollToBottom(context);
                            },
                            userBloc: bloc,
                            peopleBloc: peopleBloc,
                          )
                          // MaterialPageRoute(
                          //   builder: (_) => RepositoryListScreen(
                          //     list: model.repositories.nodes,
                          //     onScollToBootom: () => onScollToBottom(context),
                          //     userBloc: bloc,
                          //     peopleBloc: peopleBloc,
                          //   ),
                          // ),
                          );
                    },
                  ).hP16,
                  _keyValueTile(
                    context,
                    "Public Gist",
                    model?.gists?.totalCount != null
                        ? model.gists.totalCount.toString()
                        : "N/A",
                    onPressed: () {
                      Navigator.push(
                        context,
                        GistlistPageProvider.getPageRoute(
                          context,
                          login: model.login,
                        ),
                      );
                    },
                  ).hP16,
                  _keyValueTile(
                    context,
                    "Pull Request",
                    model.pullRequests.totalCount.toString(),
                    onPressed: () {
                      Navigator.push(
                          context,
                          PullRequestPageProvider.getPageRoute(context,
                              login: model.login));
                    },
                  ).hP16,
                  _keyValueTile(
                    context,
                    "Issues",
                    model.issues.totalCount.toString(),
                    onPressed: () {
                      Navigator.push(context, IssuesPage.route(model.login));
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
