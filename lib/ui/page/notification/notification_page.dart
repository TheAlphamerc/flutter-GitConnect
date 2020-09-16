import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_github_connect/bloc/notification/index.dart';
import 'package:flutter_github_connect/helper/GIcons.dart';
import 'package:flutter_github_connect/ui/page/common/no_data_page.dart';
import 'package:flutter_github_connect/ui/page/notification/notification_screen.dart';
import 'package:flutter_github_connect/ui/widgets/g_error_container.dart';
import 'package:flutter_github_connect/ui/widgets/g_loader.dart';

class NotificationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.surface,
      child: BlocBuilder<NotificationBloc, NotificationState>(
        builder: (
          BuildContext context,
          NotificationState currentState,
        ) {
          if (currentState is ErrorNotificationState) {
            return GErrorContainer(
              description: currentState.errorMessage,
              onPressed: () {
                BlocProvider.of<NotificationBloc>(context)..add(OnLoad());
              },
            );
          }
          if (currentState is LoadedNotificationState) {
            if (currentState.list != null && currentState.list.isNotEmpty)
              return NotificationScreen(
                list: currentState.list,
              );
            return NoDataPage(
              title: "No Notification Available",
              description:
                  "Seems like you have no notification for now. If new notifiaction appear it will be displayed here",
              icon: GIcons.alert_16,
            );
          }
          return GLoader();
        },
      ),
    );
  }
}
