import 'package:flutter/material.dart';
import 'package:flutter_github_connect/bloc/User/index.dart';
import 'package:flutter_github_connect/helper/GIcons.dart';
import 'package:flutter_github_connect/ui/page/home/widgets/fav_repos_widget.dart';
import 'package:flutter_github_connect/ui/page/repo/repo_list_screen.dart';
import 'package:flutter_github_connect/ui/page/common/under_development.dart';
import 'package:flutter_github_connect/ui/page/home/widgets/event_page.dart';
import 'package:flutter_github_connect/ui/page/issues/issues_page.dart';
import 'package:flutter_github_connect/ui/page/pullRequest/pull_request.dart';
import 'package:flutter_github_connect/ui/widgets/flat_button.dart';
import 'package:flutter_github_connect/ui/widgets/g_card.dart';
import 'package:flutter_github_connect/ui/theme/export_theme.dart';
import 'package:flutter_github_connect/ui/widgets/user_image.dart';

class HomePageScreen extends StatefulWidget {
  const HomePageScreen({Key key, this.model, this.bloc}) : super(key: key);
  final UserModel model;
  final UserBloc bloc;

  @override
  _HomePageScreenState createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {
  ScrollController _controller;
  void initState() {
    _controller = ScrollController()..addListener(listener);
    super.initState();
  }

  void listener() {
    if (_controller.position.pixels == _controller.position.maxScrollExtent) {
      widget.bloc..add(OnLoad(isLoadNextRepositories: true));
    }
  }

  @override
  Widget build(BuildContext context) {
    return HomePageScreenBody(
      controller: _controller,
      model: widget.model,
      bloc: widget.bloc,
    );
  }
}

class HomePageScreenBody extends StatelessWidget {
  final ScrollController controller;
  final UserModel model;
  final UserBloc bloc;
  const HomePageScreenBody({Key key, this.controller, this.model, this.bloc})
      : super(key: key);

  Widget _getUtilRos(BuildContext context, IconData icon, String text,
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

  Widget _pinnedItems(BuildContext context) {
    final list = model?.itemShowcase?.items?.nodes;
    return model.itemShowcase == null
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
                  label: "ADD Favourites",
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
                    _getUtilRos(context, GIcons.issue_closed_16, model.name,
                        color: GColors.green, user: model.owner),
                    if (list.last != model) Divider(height: 0, indent: 50),
                  ],
                );
              }).toList(),
            ),
          );
  }

  Widget _myWorkSection(BuildContext context) {
    return GCard(
      margin: EdgeInsets.symmetric(horizontal: 16),
      color: Theme.of(context).colorScheme.surface,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _getUtilRos(context, GIcons.issue_opened_24, "Issues",
              color: GColors.green, onPressed: () {
            Navigator.push(context, IssuesPage.route(model.login));
          }),
          Divider(height: 0, indent: 50),
          _getUtilRos(context, GIcons.git_pull_request_16, "Pull Request",
              color: GColors.blue, onPressed: () {
            Navigator.push(
              context,
              PullRequestPageProvider.getPageRoute(context, login: model.login),
            );
          }),
          Divider(height: 0, indent: 50),
          _getUtilRos(context, GIcons.repo_clone_16, "Repository",
              color: GColors.purple, onPressed: () {
            Navigator.push(
              context,
              RepositoryListScreen.getPageRoute(
                list: [],
                controller: controller,
                userBloc: bloc,
                peopleBloc: null,
                login: model.login),
            );
          }),
          Divider(height: 0, indent: 50),
          _getUtilRos(context, GIcons.people_24, "Organisations",
              color: GColors.orange, onPressed: () {
            Underdevelopment.displaySnackbar(context);
          }),
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
              _myWorkSection(context),
              SizedBox(height: 30),
             
              FavouriteReposWidget(controller: controller, login: model.login,),
              SizedBox(height: 30),
              Text(
                "Recent",
                style: Theme.of(context).textTheme.headline6,
              ).hP16,
              SizedBox(height: 16),
              EventsPage(login: model.login),
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
