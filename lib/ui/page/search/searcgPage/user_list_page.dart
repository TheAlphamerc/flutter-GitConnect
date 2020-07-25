import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_github_connect/bloc/search/index.dart';
import 'package:flutter_github_connect/bloc/search/model/search_userModel.dart';
import 'package:flutter_github_connect/helper/GIcons.dart';
import 'package:flutter_github_connect/ui/widgets/custom_text.dart';
import 'package:flutter_github_connect/ui/widgets/user_image.dart';
import 'package:flutter_github_connect/ui/theme/export_theme.dart';

class UserListPage extends StatelessWidget {
  const UserListPage({Key key, this.hideAppBar = false, this.list})
      : super(key: key);
  final bool hideAppBar;
  final List<SearchUser> list;
  Widget userTile(context, SearchUser user) {
    return Container(
      color: Theme.of(context).colorScheme.surface,
      child: ListTile(
        leading: SizedBox(
          width: 50,
          child: UserAvatar(
            height: 50,
            imagePath: user.avatarUrl,
          ),
        ),
        title: KText(user.name ?? "N/A").pB(5),
        subtitle: KText(
          user.login ?? "N/A",
          isSubtitle: true,
        ).pT(5),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: hideAppBar
          ? null
          : AppBar(
              elevation: 0,
              backgroundColor: Theme.of(context).colorScheme.surface,
              title: KText("People"),
            ),
      body: ListView.separated(
        itemCount: list.length,
        separatorBuilder: (BuildContext context, int index) =>
            Divider(height: 0),
        itemBuilder: (BuildContext context, int index) {
          return userTile(context, list[index]);
        },
      ),
    );
  }
}
