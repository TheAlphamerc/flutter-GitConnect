import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_github_connect/bloc/navigation/index.dart';
import 'package:flutter_github_connect/helper/GIcons.dart';
import 'package:flutter_github_connect/ui/theme/colors.dart';

class GBottomNavigationBar extends StatelessWidget {
  const GBottomNavigationBar({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var pageindex = 0;

    final theme = Theme.of(context);
    return BlocBuilder<NavigationBloc, NavigationState>(
      builder: (context, state) {
        if (state is SelectPageIndex) {
          pageindex = state.index;
        }
        return BottomNavigationBar(
          elevation: 20,
          backgroundColor: Theme.of(context).colorScheme.surface,
          type: BottomNavigationBarType.fixed,
          unselectedLabelStyle: TextStyle(
            color: theme.iconTheme.color,
            fontWeight: FontWeight.normal,
            fontSize: 14,
          ),
          unselectedItemColor: theme.iconTheme.color,
          onTap: (index) {
            // ignore: close_sinks
            final NavigationBloc bloc =
                BlocProvider.of<NavigationBloc>(context);
            bloc.add(IndexSelected(index));
          },
          showUnselectedLabels: true,
          showSelectedLabels: true,
          selectedItemColor: GColors.blue,
          currentIndex: pageindex,
          items: [
            BottomNavigationBarItem(
                // ignore: deprecated_member_use
                icon: Icon(GIcons.home_24),
                // ignore: deprecated_member_use
                title: Text("Home")),
            BottomNavigationBarItem(
                // ignore: deprecated_member_use
                icon: Icon(GIcons.bell_24),
                // ignore: deprecated_member_use
                title: Text("Notification")),
            BottomNavigationBarItem(
                // ignore: deprecated_member_use
                icon: Icon(Icons.search),
                // ignore: deprecated_member_use
                title: Text("Search")),
          ],
        );
      },
    );
  }
}
