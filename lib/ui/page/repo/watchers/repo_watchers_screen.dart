import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_github_connect/bloc/User/User_model.dart';
import 'package:flutter_github_connect/bloc/people/index.dart';
import 'package:flutter_github_connect/ui/page/user/User_page.dart';
import 'package:flutter_github_connect/ui/theme/export_theme.dart';
import 'package:flutter_github_connect/bloc/people/people_model.dart';
import 'package:flutter_github_connect/ui/widgets/g_loader.dart';
import 'package:flutter_github_connect/ui/widgets/user_image.dart';

class WatchersScreen extends StatelessWidget {
  const WatchersScreen({
    Key key,
    @required this.watchersList,
    this.controller,
  }) : super(key: key);

  final List<UserModel> watchersList;
  final ScrollController controller;

  Widget userTile(context, UserModel user) {
    return Container(
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

  Widget _loader() {
    return Container(
      alignment: Alignment.center,
      height: 60,
      child: SizedBox(
        height: 30,
        width: 30,
        child: GLoader(stroke: 1),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: ListView.separated(
        controller: controller,
        physics: BouncingScrollPhysics(),
        itemCount: watchersList.length + 1,
        separatorBuilder: (BuildContext context, int index) =>
            SizedBox(), // Divider(height: 0),
        itemBuilder: (BuildContext context, int index) {
          if (index >= watchersList.length) {
            return BlocBuilder<PeopleBloc, PeopleState>(
              buildWhen: (oldState, newState) {
                return oldState != newState;
              },
              builder: (context, state) {
                if (state is LoadingNextWatcherState) {
                  return _loader();
                }
                return SizedBox.shrink();
              },
            );
          }
          return userTile(context, watchersList[index]);
        },
      ),
    );
  }
}
