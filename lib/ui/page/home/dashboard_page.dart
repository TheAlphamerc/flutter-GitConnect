import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_github_connect/bloc/User/index.dart';
import 'package:flutter_github_connect/bloc/User/model/event_model.dart';
import 'package:flutter_github_connect/bloc/navigation/index.dart';
import 'package:flutter_github_connect/helper/GIcons.dart';
import 'package:flutter_github_connect/ui/page/home/home_page.dart';
import 'package:flutter_github_connect/ui/page/notification/notification_page.dart';
import 'package:flutter_github_connect/ui/page/search/search_page.dart';
import 'package:flutter_github_connect/ui/page/user/User_screen.dart';
import 'package:flutter_github_connect/ui/widgets/bottom_navigation_bar.dart';
import 'package:flutter_github_connect/ui/widgets/custom_text.dart';
import 'package:flutter_github_connect/ui/widgets/flat_button.dart';
import 'package:flutter_github_connect/ui/widgets/user_image.dart';
import 'package:flutter_github_connect/ui/theme/export_theme.dart';

class DashBoardPage extends StatelessWidget {
  

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
                  title: Text(
                      index == 0 ? "Home" : index == 1 ? "Inbox" : "Explorer"),
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
                Container(
                  alignment: Alignment.center,
                  height: MediaQuery.of(context).size.height - 280,
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(GIcons.github_1, size: 120),
                      SizedBox(height: 16),
                      KText(
                        "Seems like into trouble",
                        variant: TypographyVariant.title,
                      ),
                      SizedBox(height: 8),
                      KText(
                        currentState.errorMessage,
                        textAlign: TextAlign.center,
                        variant: TypographyVariant.h3,
                        style: TextStyle(letterSpacing: 1, height: 1.1),
                      ),
                      SizedBox(
                        height: 24,
                      ),
                      GFlatButton(
                        isLoading: ValueNotifier(false),
                        label: "Reload",
                        onPressed: (){
                          BlocProvider.of<UserBloc>(context).add(OnLoad());
                        },
                        isWraped: true,
                      ),
                      ],
                  ),
                ),
              ],
            ),
          );
        } else if (currentState is LoadedUserState) {
          List<EventModel> eventList;
          if (currentState is LoadedEventsState) {
            eventList = currentState.eventList;
          }
          return HomePage(
            model: currentState.user,
            eventList: eventList,
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
