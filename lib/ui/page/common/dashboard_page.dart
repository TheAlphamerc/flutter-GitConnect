import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_github_connect/bloc/User/index.dart';
import 'package:flutter_github_connect/bloc/favourite/index.dart';
import 'package:flutter_github_connect/bloc/navigation/index.dart';
import 'package:flutter_github_connect/ui/page/home/home_page.dart';
import 'package:flutter_github_connect/ui/page/notification/notification_page.dart';
import 'package:flutter_github_connect/ui/page/search/search_page.dart';
import 'package:flutter_github_connect/ui/page/user/User_screen.dart';
import 'package:flutter_github_connect/ui/widgets/bottom_navigation_bar.dart';
import 'package:flutter_github_connect/ui/widgets/user_image.dart';
import 'package:flutter_github_connect/ui/theme/export_theme.dart';
import "package:build_context/build_context.dart";
import 'package:flutter_github_connect/bloc/notification/index.dart' as notif;

class DashBoardPage extends StatelessWidget {

  static MaterialPageRoute getPageRoute(){
    return MaterialPageRoute(
          builder: (context) {
            return MultiBlocProvider(
              providers: [
                BlocProvider<NavigationBloc>(
                  create: (BuildContext context) => NavigationBloc(),
                ),
                BlocProvider<UserBloc>(
                  create: (BuildContext context) => UserBloc()..add(OnLoad()),
                ),
                BlocProvider<notif.NotificationBloc>(
                  create: (BuildContext context) =>
                      notif.NotificationBloc()..add(notif.OnLoad()),
                ),
                BlocProvider(
                  create: (context) => FavouriteBloc()..add(LoadFavouriteReposEvent()),
                )
              ],
              child: DashBoardPage(),
            );
          },
        );
  }
  Widget getPage(int index) {
    switch (index) {
      case 0:
        return HomePage();

      case 1:
        return NotificationPage();
      case 2:
        return SearchPage();

      default:
        return HomePage();
    }
  }

  @override
  Widget build(BuildContext context) {
    print("Dashboard Page build");
    return BlocBuilder<NavigationBloc, NavigationState>(
      buildWhen: (oldState, newState){
        return (oldState != newState);
      },
      builder: (
        BuildContext context,
        NavigationState currentState,
      ) {
        int index = 0;
        if (currentState is SelectPageIndex) {
          index = currentState.index;
        }
        return Scaffold(
          backgroundColor: context.backgroundColor,
          bottomNavigationBar: GBottomNavigationBar(),
          appBar: index == 2
              ? null
              : AppBar(
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
                      padding: EdgeInsets.only(left: 16),
                      child: UserAvatar(
                        imagePath: user?.avatarUrl,
                        height: 30,
                      )
                    ).ripple(() {
                        if (user == null) {
                          return;
                        }
                        Navigator.of(context).push(
                          UserScreen.getPageRoute(context, user)
                        );
                      });
                  }),
                  title: Title(
                    title:
                        index == 0 ? "Home" : index == 1 ? "Inbox" : "Explorer",
                    color: Colors.black,
                    child: Text(
                        index == 0 ? "Home" : index == 1 ? "Inbox" : "Explorer",
                        style: Theme.of(context).textTheme.headline6),
                  ),
                ),
          body: getPage(index),
        );
      },
    );
  }
}
