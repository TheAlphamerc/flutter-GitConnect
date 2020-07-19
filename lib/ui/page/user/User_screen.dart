import 'package:flutter/material.dart';
import 'package:flutter_github_connect/bloc/User/User_model.dart';
import 'package:flutter_github_connect/helper/utility.dart';
import 'package:flutter_github_connect/ui/theme/export_theme.dart';
import 'package:flutter_github_connect/ui/widgets/cached_image.dart';
import 'package:flutter_github_connect/ui/widgets/custom_text.dart';

class UserScreen extends StatelessWidget {
  final UserModel model;

  const UserScreen({Key key, this.model}) : super(key: key);
  Widget userAvatarRow() {
    return Container(
      height: 64,
      child: Row(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: customNetworkImage(model.avatarUrl),
          ),
          SizedBox(width: 20),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              KText(
                model.name,
                variant: TypographyVariant.header,
              ),
              SizedBox(height: 10),
              KText(
                model.login,
                variant: TypographyVariant.h4,
                style: TextStyle(color: Colors.white70, letterSpacing: 1),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _iconWithText(context, IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: <Widget>[
          Icon(icon, color: Theme.of(context).colorScheme.onSurface),
          SizedBox(width: 10),
          KText(text ?? "N/A")
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
              style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
            ),
            Icon(
              Icons.keyboard_arrow_right,
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
    return CustomScrollView(
      physics: BouncingScrollPhysics(),
      slivers: <Widget>[
        SliverToBoxAdapter(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            color: theme.colorScheme.surface,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                userAvatarRow(),
                SizedBox(height: 8),
                Container(
                  width: double.infinity,
                  margin: EdgeInsets.symmetric(vertical: 12),
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  decoration: BoxDecoration(
                      color: theme.cardColor,
                      borderRadius: BorderRadius.circular(5)),
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
                _iconWithText(context, Icons.person, model.login),
                // _iconWithText(context, Icons.email, model.email),
                _iconWithText(context, Icons.link, model.websiteUrl),
                _iconWithText(
                    context, Icons.link, Utility.toDMYformate(model.createdAt)),
                _iconWithText(context, Icons.location_city, model.location),
                _iconWithText(context, Icons.person_outline,
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
                          itemCount: model.topRepositories.nodes.length,
                          itemBuilder: (context, index) {
                            final repo = model.topRepositories.nodes[index];
                            return Container(
                              width: MediaQuery.of(context).size.width * .7,
                              margin: EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 8),
                              padding: EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 16,
                              ),
                              decoration: BoxDecoration(
                                  color: theme.cardColor,
                                  borderRadius: BorderRadius.circular(10)),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Row(children: <Widget>[
                                    Container(
                                      height: 30,
                                      child: Row(
                                        children: <Widget>[
                                          ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            child: customNetworkImage(
                                                repo.owner.avatarUrl),
                                          ),
                                          SizedBox(width: 10),
                                          KText(
                                            repo.owner.name,
                                            variant: TypographyVariant.h3,
                                          ),
                                        ],
                                      ),
                                    )
                                  ]),
                                  SizedBox(height: 8),
                                  KText(
                                    repo.name,
                                    variant: TypographyVariant.h3,
                                  ),
                                  SizedBox(height: 8),
                                  KText(
                                    repo.languages.nodes.first.name,
                                    variant: TypographyVariant.h4,
                                  ),
                                  Spacer(),
                                  KText(
                                    "Forks ${repo.forkCount}",
                                    variant: TypographyVariant.h4,
                                  ),
                                ],
                              ),
                            );
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
                    // Navigator.push(context, MaterialPageRoute(builder: (_)=> RepositoryListPage()));
                  },
                ).hP16,
                SizedBox(height: 24),
                _keyValueTile(
                  context,
                  "Public Gist",
                  model?.gists?.totalCount != null
                      ? model.gists.totalCount.toString()
                      : "N/A",
                ).hP16,
              ],
            ),
          ),
        ),
      ],
    );
  }
}
