import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_github_connect/bloc/notification/index.dart';
import 'package:flutter_github_connect/ui/page/notification/notification_screen.dart';

class NotificationPage extends StatefulWidget {

  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

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
            return NotificationScreen(list: currentState.list,);
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
