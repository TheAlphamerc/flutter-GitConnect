import 'package:flutter/material.dart';
import 'package:flutter_github_connect/bloc/User/User_model.dart';
import 'package:flutter_github_connect/ui/widgets/cached_image.dart';
import 'package:flutter_github_connect/ui/widgets/custom_text.dart';

class UserScreen extends StatelessWidget {
  final UserModel model;

  const UserScreen({Key key, this.model}) : super(key: key);

  Widget _iconWithText(context, IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: <Widget>[
          Icon(icon, color: Theme.of(context).colorScheme.onSurface),
          SizedBox(width: 10),
          KText(text)
        ],
      ),
    );
  }

  Widget _keyValueTile(context, String key, String value) {
    return Padding(
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
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return CustomScrollView(
      slivers: <Widget>[
        SliverToBoxAdapter(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            color: theme.cardColor,
            child: Column(
              children: <Widget>[
                Container(
                  height: 60,
                  child: Row(
                    children: <Widget>[
                      ClipRRect(
                        borderRadius: BorderRadius.circular(15),
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
                          KText(
                            model.login,
                            variant: TypographyVariant.h4,
                            style: TextStyle(color: Colors.white70),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 8),
                KText(
                  model.bio,
                  variant: TypographyVariant.h3,
                ),
                SizedBox(height: 8),
                _iconWithText(context, Icons.person, model.login),
                _iconWithText(context, Icons.link, model.blog),
                _iconWithText(context, Icons.email, model.email),
                _iconWithText(context, Icons.location_city, model.location),
                _iconWithText(context, Icons.person_outline,
                    "${model.followers} flollowers  ${model.following} Following"),
              ],
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            margin: EdgeInsets.symmetric(vertical: 16),
            color: theme.cardColor,
            child: Column(
              children: <Widget>[
                _keyValueTile(
                  context,
                  "Repository",
                  model.publicRepos.toString(),
                ),
                // SizedBox(height: 24),
                _keyValueTile(
                  context,
                  "Public Gist",
                  model.publicGists.toString(),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
