import 'package:flutter/material.dart';
import 'package:flutter_github_connect/bloc/search/model/search_userModel.dart';
import 'package:flutter_github_connect/ui/page/user/User_page.dart';
import 'package:flutter_github_connect/ui/widgets/user_image.dart';
import 'package:flutter_github_connect/ui/theme/export_theme.dart';

class UserListPage extends StatelessWidget {
  const UserListPage({Key key, this.hideAppBar = false, this.list,this.controller})
      : super(key: key);
  final bool hideAppBar;
  final List<SearchUser> list;
  final ScrollController controller;
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
        title: Text(
          user.name ?? "N/A",
          style: Theme.of(context).textTheme.bodyText1,
        ).pB(3),
        subtitle: Text(
          user.login ?? "N/A",
          style: Theme.of(context).textTheme.subtitle2,
        ).pT(3),
      ),
    ).ripple(() {
      Navigator.of(context).push(UserPage.getPageRoute(context,login:user.login),);
    });
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
              title: Title(
                title: "People",
                color: Colors.black,
                child: Text("People",
                    style: Theme.of(context).textTheme.headline6),
              ),
            ),
      body: ListView.separated(
        physics: BouncingScrollPhysics(),
        controller:controller ?? ScrollController(),
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
