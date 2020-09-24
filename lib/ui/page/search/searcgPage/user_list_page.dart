import 'package:flutter/material.dart';
import 'package:flutter_github_connect/bloc/search/model/search_userModel.dart';
import 'package:flutter_github_connect/ui/widgets/g_user_tile.dart';

class UserListPage extends StatelessWidget {
  const UserListPage({Key key, this.hideAppBar = false, this.list,this.controller})
      : super(key: key);
  final bool hideAppBar;
  final List<SearchUser> list;
  final ScrollController controller;
  
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
          return GUserTile(list[index].toUserModel());
        },
      ),
    );
  }
}
