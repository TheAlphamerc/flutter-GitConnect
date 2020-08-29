import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_github_connect/bloc/notification/index.dart';
import 'package:flutter_github_connect/helper/GIcons.dart';
import 'package:flutter_github_connect/ui/page/common/no_data_page.dart';
import 'package:flutter_github_connect/ui/page/notification/notification_screen.dart';

class NotificationPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      color:Theme.of(context).colorScheme.surface,
      child: BlocBuilder<NotificationBloc, NotificationState>(
        builder: (
          BuildContext context,
          NotificationState currentState,
        ) {
          if (currentState is ErrorNotificationState) {
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
                    onPressed: () {
                      BlocProvider.of<NotificationBloc>(context)..add(OnLoad());
                      print("Load Notification");
                    },
                  ),
                ),
              ],
            ));
          }
          if (currentState is LoadedNotificationState) {
            if(currentState.list == null && currentState.list.isNotEmpty)
            return NotificationScreen(list: currentState.list,);
            return Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: NoDataPage(
                      title: "No Notification Available",
                      description:
                          "Seems like you have no notification for now. If new notifiaction appear it will be displayed here",
                      icon: GIcons.alert_16,
                    ),
                  ),
                ],
              );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
