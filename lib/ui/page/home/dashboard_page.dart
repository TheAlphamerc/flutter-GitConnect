import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_github_connect/bloc/User/index.dart';
import 'package:flutter_github_connect/bloc/navigation/index.dart';
import 'package:flutter_github_connect/ui/page/home/home_page.dart';
import 'package:flutter_github_connect/ui/page/notification/notification_page.dart';
import 'package:flutter_github_connect/ui/page/search/search_page.dart';
import 'package:flutter_github_connect/ui/page/user/User_screen.dart';
import 'package:flutter_github_connect/ui/widgets/bottom_navigation_bar.dart';
import 'package:flutter_github_connect/ui/widgets/user_image.dart';
import 'package:flutter_github_connect/ui/theme/export_theme.dart';

class DashBoardPage extends StatefulWidget {
  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<DashBoardPage> {
  @override
  void initState() {
    print("Init Profile page");
    super.initState();
  }

  Widget getPage(int index) {
    switch (index) {
      case 0:
        return HomePageScreen();

      case 1:
        return NotificationPage();
      case 2:
        return SearchPage();

      default:
        return HomePageScreen();
    }
  }

  @override
  Widget build(BuildContext context) {
    print("Dashboard Page build");
    return BlocBuilder<NavigationBloc, NavigationState>(
      builder: (
        BuildContext context,
        NavigationState currentState,
      ) {
        int index = 0;
        if (currentState is SelectPageIndex) {
          index = currentState.index;
        }
        return Scaffold(
          backgroundColor: Theme.of(context).backgroundColor,
          bottomNavigationBar: GBottomNavigationBar(),
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Theme.of(context).colorScheme.surface,
            leading: BlocBuilder<UserBloc, UserState>(builder: (
              BuildContext context,
              UserState state,
            ) {
              UserModel user;
              if (state is LoadedUserState) {
                user = state.user;
              }
              return Container(
                alignment: Alignment.center,
                margin: EdgeInsets.only(left: 16),
                child: UserAvatar(
                  imagePath: user?.avatarUrl,
                  height: 30,
                ).ripple(() {
                  if (user == null) {
                    return;
                  }
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => UserScreen(model: user),
                    ),
                  );
                }),
              );
            }),
            title:
                Text(index == 0 ? "Home" : index == 1 ? "Inbox" : "Explorer"),
          ),
          body: getPage(index),
        );
      },
    );
  }
}

class HomePageScreen extends StatelessWidget {
  const HomePageScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
      builder: (
        BuildContext context,
        UserState currentState,
      ) {
        if (currentState is ErrorUserState) {
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
          return HomePage(
            model: currentState.user,
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
