import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_github_connect/bloc/User/User_model.dart';
import 'package:flutter_github_connect/bloc/favourite/index.dart';
import 'package:flutter_github_connect/helper/GIcons.dart';
import 'package:flutter_github_connect/ui/page/repo/repo_detail_page.dart';
import 'package:flutter_github_connect/ui/page/repo/select_favourite_repo_page.dart';
import 'package:flutter_github_connect/ui/theme/export_theme.dart';
import 'package:flutter_github_connect/ui/widgets/flat_button.dart';
import 'package:flutter_github_connect/ui/widgets/g_card.dart';
import 'package:flutter_github_connect/ui/widgets/user_image.dart';

class FavouriteReposWidget extends StatelessWidget {
  const FavouriteReposWidget({Key key, this.controller, this.login})
      : super(key: key);
  final ScrollController controller;
  final String login;

  Widget _getUtilRos(BuildContext context, IconData icon, String text,
      {Function onPressed, Color color, Owner user}) {
    return Row(
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(user == null ? 8 : 0),
          margin: EdgeInsets.all(10),
          decoration: BoxDecoration(
              color: user == null ? color : Colors.transparent,
              borderRadius: BorderRadius.all(Radius.circular(10))),
          child: user == null
              ? Icon(icon,
                  size: 15, color: Theme.of(context).colorScheme.onPrimary)
              : UserAvatar(imagePath: user.avatarUrl, height: 30),
        ),
        Text(text, style: Theme.of(context).textTheme.bodyText1),
        Spacer(),
        Icon(
          GIcons.chevron_right_24,
          color: Theme.of(context).colorScheme.onSurface,
          size: 18,
        ),
        SizedBox(
          width: 8,
        )
      ],
    ).ripple(onPressed);
  }

  @override
  Widget build(BuildContext context) {
    List<RepositoriesNode> list;
    return BlocBuilder<FavouriteBloc, FavouriteState>(
      builder: (context, state) {
        if (state is LoadedFavReposState) {
          list = state.list;
        }
        return Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  "Favourite",
                  style: Theme.of(context).textTheme.headline6,
                ).hP16,
                if (list != null && list.length > 0)
                  Text(
                    "Edit",
                    style: Theme.of(context)
                        .textTheme
                        .button
                        .copyWith(color: GColors.blue),
                  ).hP16.ripple(() {
                    Navigator.push(
                      context,
                      SelectFavouriteRepoPage.getPageRoute(
                        context,
                        controller: controller,
                        login: login,
                      ),
                    );
                  }),
              ],
            ),
            SizedBox(height: 16),
            !(list != null && list.isNotEmpty)
                ? GCard(
                    margin: EdgeInsets.symmetric(horizontal: 16),
                    color: Theme.of(context).colorScheme.surface,
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                    child: Column(
                      children: <Widget>[
                        Text(
                          "Add favourite repositories for quick access at any time, without having to search",
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.bodyText2,
                        ),
                        SizedBox(height: 16),
                        GFlatButton(
                          label: "ADD Favourites",
                          onPressed: () async {
                            Navigator.push(
                              context,
                              SelectFavouriteRepoPage.getPageRoute(
                                context,
                                controller: controller,
                                login: login,
                              ),
                            );
                          },
                        )
                      ],
                    ),
                  )
                : GCard(
                    margin: EdgeInsets.symmetric(horizontal: 16),
                    color: Theme.of(context).colorScheme.surface,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          ...list.map((model) {
                            return Column(
                              children: <Widget>[
                                _getUtilRos(
                                  context,
                                  GIcons.issue_closed_16,
                                  model.name,
                                  color: GColors.green,
                                  user: model.owner,
                                  onPressed: () {
                                    Navigator.of(context)
                                        .push(RepoDetailPage.getPageRoute(
                                      context,
                                      name: model.name,
                                      owner: model.owner.login,
                                    ));
                                  },
                                ),
                                if (list.last != model)
                                  Divider(height: 0, indent: 50),
                              ],
                            );
                          }).toList(),
                        ]),
                  ),
          ],
        );
      },
    );
  }
}
