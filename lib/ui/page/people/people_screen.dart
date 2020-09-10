import 'package:flutter/material.dart';
import 'package:flutter_github_connect/bloc/people/index.dart';
import 'package:flutter_github_connect/ui/page/user/User_page.dart';
import 'package:flutter_github_connect/ui/widgets/user_image.dart';
import 'package:flutter_github_connect/ui/theme/export_theme.dart';

class PeopleScreen extends StatelessWidget {
  const PeopleScreen({
    Key key,
    @required List<Node> followers,
  })  : _followers = followers,
        super(key: key);

  final List<Node> _followers;

  Widget userTile(context, Node user) {
    return Container(
      color: Theme.of(context).colorScheme.surface,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            leading: SizedBox(
              width: 50,
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
          if(user.bio != null && user.bio.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(left: 86, bottom: 8),
            child: Text(
              user.bio.trim() ?? "N/A",
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ),
          Divider(height: 0),
        ],
      ).ripple((){
        Navigator.push(context, UserPage.getPageRoute(context, login: user.login));
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: ListView.separated(
        physics: BouncingScrollPhysics(),
        itemCount: _followers.length,
        separatorBuilder: (BuildContext context, int index) =>
            SizedBox(),// Divider(height: 0),
        itemBuilder: (BuildContext context, int index) {
          return userTile(context, _followers[index]);
        },
      ),
    );
  }
}
