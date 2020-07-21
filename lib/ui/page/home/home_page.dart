import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_github_connect/bloc/User/index.dart';
import 'package:flutter_github_connect/helper/GIcons.dart';
import 'package:flutter_github_connect/ui/page/auth/repo/repo_list_screen.dart';
import 'package:flutter_github_connect/ui/page/user/User_screen.dart';
import 'package:flutter_github_connect/ui/widgets/custom_text.dart';
import 'package:flutter_github_connect/ui/widgets/g_card.dart';
import 'package:flutter_github_connect/ui/theme/export_theme.dart';
import 'package:flutter_github_connect/ui/widgets/user_image.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key, this.model}) : super(key: key);
  final UserModel model;

  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<HomePage> {
  @override
  void initState() {
    print("Init Profile page");
    super.initState();
  }

  Widget _getUtilRos(IconData icon, String text,
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
              ? Icon(icon, size: 15)
              : UserAvatar(
                  imagePath: user.avatarUrl,
                  height: 30,
                ),
        ),
        KText(
          text,
          variant: TypographyVariant.h3,
          style: TextStyle(fontWeight: FontWeight.w300, letterSpacing: .6),
        ),
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

  Widget _favouriteRepo() {
    final list = widget.model.topRepositories.nodes;
    return GCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: list.sublist(0, 4).map((model) {
          return Column(
            children: <Widget>[
              _getUtilRos(GIcons.issue_closed_16, model.name,
                  color: GColors.green, user: model.owner),
              if (list.last != model) Divider(height: 0, indent: 50),
            ],
          );
        }).toList(),
      ),
    );
  }

  Widget _myWorkSection() {
    return GCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _getUtilRos(GIcons.issue_opened_24, "Issues", color: GColors.green),
          Divider(height: 0, indent: 50),
          _getUtilRos(GIcons.git_pull_request_16, "Pull Request",
              color: GColors.blue),
          Divider(height: 0, indent: 50),
          _getUtilRos(GIcons.repo_clone_16, "Repository", color: GColors.purple,
              onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => RepositoryListScreen(
                  list1: widget.model.repositories.nodes,
                ),
              ),
            );
          }),
          Divider(height: 0, indent: 50),
          _getUtilRos(GIcons.people_24, "Organisations", color: GColors.orange),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    print("User Page build");
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: Container(
        padding: EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              KText(
                "Home",
                variant: TypographyVariant.title,
              ),
              SizedBox(height: 40),
              KText(
                "My Work",
                variant: TypographyVariant.subHeader,
              ),
              SizedBox(height: 16),
              _myWorkSection(),
              SizedBox(height: 30),
              KText(
                "Favourite",
                variant: TypographyVariant.subHeader,
              ),
              SizedBox(height: 16),
              _favouriteRepo()
            ],
          ),
        ),
      ),
    );
  }
}
