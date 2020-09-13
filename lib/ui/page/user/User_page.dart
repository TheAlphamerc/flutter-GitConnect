import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_github_connect/bloc/people/index.dart';
import 'package:flutter_github_connect/helper/GIcons.dart';
import 'package:flutter_github_connect/helper/utility.dart';
import 'package:flutter_github_connect/ui/page/user/User_screen.dart';
import 'package:flutter_github_connect/ui/theme/export_theme.dart';
import 'package:flutter_github_connect/ui/widgets/g_loader.dart';

class UserPage extends StatefulWidget {
  final String login;

  const UserPage({Key key, this.login}) : super(key: key);
  static MaterialPageRoute getPageRoute(
    BuildContext context, {
    String login,
  }) {
    return MaterialPageRoute(
      builder: (context) {
        return BlocProvider<PeopleBloc>(
            create: (BuildContext context) => PeopleBloc()
              ..add(
                LoadUserEvent(login: login),
              ),
            child: UserPage(login: login));
      },
    );
  }

  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  @override
  void initState() {
    print("Init Profile page");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print("User Page build");
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        title: Text(widget.login ?? "Profile"),
        actions: <Widget>[
          IconButton(
                  icon: Icon(GIcons.share_android_24, color: GColors.blue),
                  onPressed: () {
                    Utility.share("https://www.github.com/${widget.login}");
                  },
                ),
        ],
      ),
      body: BlocBuilder<PeopleBloc, PeopleState>(
        // bloc: widget._userBloc,
        builder: (
          BuildContext context,
          PeopleState currentState,
        ) {
          if (currentState is ErrorPeopleState) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(currentState.errorMessage ?? 'Error'),
                  Padding(
                    padding: const EdgeInsets.only(top: 32.0),
                    child: RaisedButton(
                      color: Colors.blue,
                      child: Text('reload'),
                      onPressed: () {},
                    ),
                  ),
                ],
              ),
            );
          } else if (currentState is LoadedUserState) {
            return UserScreen(
                model: currentState.user,
                isHideAppBar: true,
                peopleBloc: BlocProvider.of<PeopleBloc>(context));
          } else {
            return GLoader();
          }
        },
      ),
    );
  }
}
