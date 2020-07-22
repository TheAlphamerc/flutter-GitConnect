import 'package:flutter/material.dart';
import 'package:flutter_github_connect/bloc/User/User_model.dart';
import 'package:flutter_github_connect/helper/GIcons.dart';
import 'package:flutter_github_connect/helper/utility.dart';
import 'package:flutter_github_connect/ui/page/auth/repo/repo_list_screen.dart';
import 'package:flutter_github_connect/ui/theme/export_theme.dart';
import 'package:flutter_github_connect/ui/widgets/custom_text.dart';
import 'package:flutter_github_connect/ui/widgets/g_card.dart';
import 'package:flutter_github_connect/ui/widgets/user_image.dart';

class UserScreen extends StatelessWidget {
  final UserModel model;

  const UserScreen({Key key, this.model}) : super(key: key);

  Widget _iconWithText(context, IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: <Widget>[
          Icon(icon, color: Theme.of(context).colorScheme.onSurface, size: 18),
          SizedBox(width: 10),
          KText(text ?? "N/A")
        ],
      ),
    );
  }

  Widget topRepoCard(context, TopRepositoriesNode repo) {
    return GCard(
      width: MediaQuery.of(context).size.width * .7,
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
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
          KText(
            repo.name,
            variant: TypographyVariant.h3,
          ),
          SizedBox(height: 8),
          Spacer(),
          Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(bottom: 5),
                child:
                    Icon(GIcons.star_fill_24, size: 16, color: Colors.yellowAccent[700]),
              ),
              SizedBox(width: 10),
              KText(
                "${repo.stargazers.totalCount}",
                variant: TypographyVariant.h4,
                isSubtitle: true,
              ),
              SizedBox(width: 20),
              Icon(
                Icons.blur_circular,
                color: repo.languages.nodes.first.color,
                size: 15,
              ),
              SizedBox(width: 5),
              KText(
                "${repo.languages.nodes.first.name}",
                isSubtitle: true,
                variant: TypographyVariant.h4,
              ),
            ],
          ),
        ],
      ),
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
            KText(key),
            Spacer(),
            KText(
              value,
              isSubtitle: true,
              style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
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
                    variant: TypographyVariant.header,
                    subVarient: TypographyVariant.h4,
                  ),
                  SizedBox(height: 8),

                  GCard(
                    width: double.infinity,
                    margin: EdgeInsets.symmetric(vertical: 12),
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                    child: KText(
                      model?.status?.message ?? "N/A",
                      variant: TypographyVariant.h3,
                    ),
                  ),
                  KText(
                    model.bio,
                    variant: TypographyVariant.h3,
                    style: TextStyle(letterSpacing: .7, height: 1.4),
                  ),
                  SizedBox(height: 8),
                  _iconWithText(context, GIcons.people_24, model.login),
                  _iconWithText(context, GIcons.link_24,model.websiteUrl),
                  _iconWithText(context, GIcons.gift_24,
                      Utility.toDMYformate(model.createdAt)),
                  _iconWithText(context, Icons.location_city, model.location),
                  _iconWithText(context, GIcons.person_24,
                      "${model.followers.totalCount} flollowers  ${model.following.totalCount} Following"),
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
                        KText("Top Repository").hP16,
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
                            list1: model.repositories.nodes,
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
                        : "N/A",
                  ).hP16,
                  _keyValueTile(
                    context,
                    "Pull Request",
                    model.pullRequests.totalCount.toString(),
                    onPressed: () {
                      print("Get user Repository");
                      // Navigator.push(context, MaterialPageRoute(builder: (_)=> RepositoryListPage()));
                    },
                  ).hP16,
                  _keyValueTile(
                    context,
                    "Issues",
                    model.issues.totalCount.toString(),
                    onPressed: () {
                      print("Get user Repository");
                      // Navigator.push(context, MaterialPageRoute(builder: (_)=> RepositoryListPage()));
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
