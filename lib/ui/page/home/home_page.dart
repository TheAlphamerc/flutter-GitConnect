import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_github_connect/bloc/User/index.dart';
import 'package:flutter_github_connect/bloc/User/model/event_model.dart';
import 'package:flutter_github_connect/bloc/bloc/repo_bloc.dart';
import 'package:flutter_github_connect/helper/GIcons.dart';
import 'package:flutter_github_connect/ui/page/auth/repo/repo_list_screen.dart';
import 'package:flutter_github_connect/ui/page/home/widgets/event_page.dart';
import 'package:flutter_github_connect/ui/page/issues/issues_page.dart';
import 'package:flutter_github_connect/ui/page/pullRequest/pull_request.dart';
import 'package:flutter_github_connect/ui/page/repo/repo_detail_page.dart';
import 'package:flutter_github_connect/ui/widgets/flat_button.dart';
import 'package:flutter_github_connect/ui/widgets/g_card.dart';
import 'package:flutter_github_connect/ui/theme/export_theme.dart';
import 'package:flutter_github_connect/ui/widgets/user_image.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key, this.model, this.eventList, this.bloc})
      : super(key: key);
  final UserModel model;
  final List<EventModel> eventList;
  final UserBloc bloc;

  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<HomePage> {
  ValueNotifier<bool> isLoading = ValueNotifier(false);
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

  Widget _favouriteRepo() {
    final list = widget.model?.topRepositories?.nodes;
    return list == null
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
                  label: "ADD FavouriteS",
                  onPressed: () {},
                ).ripple(() {})
              ],
            ),
          )
        : GCard(
            margin: EdgeInsets.symmetric(horizontal: 16),
            color: Theme.of(context).colorScheme.surface,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: list.sublist(0, 4).map((model) {
                return Column(
                  children: <Widget>[
                    _getUtilRos(
                      GIcons.issue_closed_16,
                      model.name,
                      color: GColors.green,
                      user: model.owner,
                      onPressed: () {
                        Navigator.of(context).push(RepoDetailPage.getPageRoute(
                          context,
                          name: model.name,
                          owner: model.owner.login,
                        ));
                      },
                    ),
                    if (list.last != model) Divider(height: 0, indent: 50),
                  ],
                );
              }).toList(),
            ),
          );
  }

  Widget _pinnedItems() {
    final list = widget.model?.itemShowcase?.items?.nodes;
    return widget.model.itemShowcase == null
        ? GCard(
            color: Theme.of(context).colorScheme.surface,
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: Column(
              children: <Widget>[
                Text(
                    "Add favourite repositories for quick access at any time, without having to search",
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headline5),
                SizedBox(height: 16),
                GFlatButton(
                  label: "ADD FavouriteS",
                  onPressed: () {},
                ).ripple(() {})
              ],
            ),
          )
        : GCard(
            color: Theme.of(context).colorScheme.surface,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: list.map((model) {
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
      margin: EdgeInsets.symmetric(horizontal: 16),
      color: Theme.of(context).colorScheme.surface,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _getUtilRos(GIcons.issue_opened_24, "Issues", color: GColors.green,
              onPressed: () {
            Navigator.push(context, IssuesPage.route(widget.model.login));
          }),
          Divider(height: 0, indent: 50),
          _getUtilRos(GIcons.git_pull_request_16, "Pull Request",
              color: GColors.blue, onPressed: () {
            Navigator.push(
                context,
                PullRequestPageProvider.getPageRoute(context,
                    login: widget.model.login));
          }),
          Divider(height: 0, indent: 50),
          _getUtilRos(GIcons.repo_clone_16, "Repository", color: GColors.purple,
              onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => RepositoryListScreen(
                  list: widget.model.repositories.nodes,
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
    print("Home Page build");
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 0),
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 16),
              // Text("Home", style: Theme.of(context).textTheme.headline3),
              // SizedBox(height: 40),
              Text(
                "My Work",
                style: Theme.of(context).textTheme.headline6,
              ).hP16,
              SizedBox(height: 16),
              _myWorkSection(),
              SizedBox(height: 30),
              Text(
                "Favourite",
                style: Theme.of(context).textTheme.headline6,
              ).hP16,
              SizedBox(height: 16),
              _favouriteRepo(),
              SizedBox(height: 30),
              Text(
                "Recent",
                style: Theme.of(context).textTheme.headline6,
              ).hP16,
              SizedBox(height: 16),
              EventsPage(
                eventList: widget.eventList,
              ),
              SizedBox(height: 16),
              // Text(
              //   "Typography",
              //   style: Theme.of(context).textTheme.headline6,
              // ),
              // SizedBox(height: 16),
              // TypograpgyWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
