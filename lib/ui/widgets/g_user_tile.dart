import 'package:flutter/material.dart';
import 'package:flutter_github_connect/bloc/User/User_model.dart';
import 'package:flutter_github_connect/ui/page/user/User_page.dart';
import 'package:flutter_github_connect/ui/theme/export_theme.dart';
import 'package:flutter_github_connect/ui/widgets/user_image.dart';

class GUserTile extends StatelessWidget {
  const GUserTile(this.user,{Key key}) : super(key: key);
  final UserModel user;
  @override
  Widget build(BuildContext context) {
    return  Container(
      color: Theme.of(context).colorScheme.surface,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            leading: SizedBox(
              width: 51,
              child: UserAvatar(
                height: 50,
                imagePath: user.avatarUrl,
              ),
            ),
            title: Text(
              user.name ?? "N/A",
              style: Theme.of(context).textTheme.bodyText1,
            ).pB(3),
            subtitle: Text(
              user.login ?? "N/A",
              style: Theme.of(context).textTheme.subtitle2,
            ).pT(3),
          ),
          if (user.bio != null && user.bio.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(left: 86, bottom: 8),
              child: Text(
                user.bio.trim() ?? "N/A",
                style: Theme.of(context).textTheme.bodyText1,
              ),
            ),
          Divider(height: 0),
        ],
      ).ripple(() {
        Navigator.push(
            context, UserPage.getPageRoute(context, login: user.login));
      }),
    );
  }
}