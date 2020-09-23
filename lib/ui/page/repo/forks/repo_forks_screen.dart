import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_github_connect/bloc/User/User_model.dart';
import 'package:flutter_github_connect/bloc/bloc/repo_bloc.dart';
import 'package:flutter_github_connect/bloc/people/index.dart';
import 'package:flutter_github_connect/model/forks_model.dart';
import 'package:flutter_github_connect/ui/page/repo/repo_detail_page.dart';
import 'package:flutter_github_connect/ui/page/user/User_page.dart';
import 'package:flutter_github_connect/ui/theme/export_theme.dart';
import 'package:flutter_github_connect/ui/widgets/g_loader.dart';
import 'package:flutter_github_connect/ui/widgets/user_image.dart';

class ForksScreen extends StatelessWidget {
  const ForksScreen({
    Key key,
    @required this.forksList,
    this.controller,
  }) : super(key: key);

  final List<ForksNode> forksList;
  final ScrollController controller;

  Widget userTile(context, ForksNode model) {
    return Container(
      color: Theme.of(context).colorScheme.surface,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                UserAvatar(
                  height: 20,
                  subtitle: model.owner.login,
                  imagePath: model.owner.avatarUrl,
                ),
                Text(
                  model.name ?? "N/A",
                  style: Theme.of(context).textTheme.bodyText1,
                ).pT(8),
              ],
            ),
            subtitle: Column(
              children: <Widget>[
                Text(
                  model.description ?? "N/A",
                  style: Theme.of(context).textTheme.subtitle2,
                ).pT(8),

                model.languages.nodes.isEmpty
              ? SizedBox()
              : Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(bottom: 3),
                      child: Icon(Icons.star,
                          size: 20, color: Colors.yellowAccent[700]),
                    ),
                    SizedBox(width: 10),
                    Text(
                      "${model.stargazers.totalCount}",
                      style: Theme.of(context).textTheme.subtitle2,
                    ),
                    SizedBox(width: 20),
                    Icon(
                      Icons.blur_circular,
                      color: model.languages.nodes.first.color,
                      size: 15,
                    ),
                    SizedBox(width: 5),
                    Text(
                      "${model.languages.nodes.first.name}",
                      style: Theme.of(context).textTheme.subtitle2,
                    ),
                  ],
                ).pT(8),
              ],
            ),
          ).vP8,
          Divider(height: 1),
        ],
      ).ripple(() {
        Navigator.push(
            context, RepoDetailPage.getPageRoute(context,name: model.name,owner: model.owner.login));
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
      body: ListView.builder(
        controller: controller,
        physics: BouncingScrollPhysics(),
        itemCount: forksList.length + 1,
        itemBuilder: (BuildContext context, int index) {
          if (index >= forksList.length) {
            return BlocBuilder<RepoBloc, RepoState>(
              buildWhen: (oldState, newState) {
                return oldState != newState;
              },
              builder: (context, state) {
                if (state is LoadingNextForksState) {
                  return _loader();
                }
                return SizedBox.shrink();
              },
            );
          }
          return userTile(context, forksList[index]);
        },
      ),
    );
  }
}
