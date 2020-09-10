import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_github_connect/bloc/notification/index.dart';
import 'package:flutter_github_connect/helper/GIcons.dart';
import 'package:flutter_github_connect/helper/utility.dart';
import 'package:flutter_github_connect/ui/theme/export_theme.dart';

class NotificationScreen extends StatefulWidget {
  final List<NotificationModel> list;

  const NotificationScreen({Key key, this.list}) : super(key: key);

  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  ScrollController _controller;
  @override
  void initState() {
    _controller = ScrollController()..addListener(listener);
    super.initState();
  }

  void listener() {
    if (_controller.position.pixels == _controller.position.maxScrollExtent) {
      BlocProvider.of<NotificationBloc>(context).add(
        OnLoad(
          isLoadNextNotification: true,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return NotificationBody(list: widget.list,controller: _controller,);
  }
}

class NotificationBody extends StatelessWidget {
  const NotificationBody({Key key, this.list, this.controller})
      : super(key: key);
  final List<NotificationModel> list;
  final ScrollController controller;

  Widget _notificationTile(context, NotificationModel model) {
    return Container(
        child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
            width: 50,
            child: Column(
              children: <Widget>[
                Icon(
                  getIcon(model.reason),
                  color: getColor(model.reason),
                  size: 20,
                ),
                SizedBox(height: 3),
                Icon(
                  GIcons.dot_24,
                  color: model.unread ? GColors.blue : Colors.transparent,
                  size: 20,
                ),
              ],
            )),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width - 66,
              child: Text(
                '${trimMessage(model.repository.fullName)}',
                style: Theme.of(context).textTheme.subtitle1,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ),
            SizedBox(height: 8),
            SizedBox(
              width: MediaQuery.of(context).size.width - 66,
              child: Text(
                '${model.subject.title}',
                style: Theme.of(context).textTheme.bodyText1,
              ),
            ),
            SizedBox(height: 8),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 6, vertical: 4),
              decoration: BoxDecoration(
                  color: getColor(model.reason).withAlpha(200),
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                  border: Border.all(color: getColor(model.reason))),
              child: Text(
                '${model.reason}',
                style: Theme.of(context).textTheme.subtitle2,
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width - 66,
              alignment: Alignment.bottomRight,
              child: Text(Utility.getPassedTime(model.updatedAt) + " ago",
                  style: Theme.of(context).textTheme.subtitle2),
            )
          ],
        ),
      ],
    ).vP16);
  }

  IconData getIcon(String type) {
    switch (type) {
      case "author":
        return GIcons.person_24;
      case "manual":
        return GIcons.tools_24;
      case "mention":
        return GIcons.mention_24;
      case "PullRequest":
        return GIcons.git_pull_request_24;
      case "security_alert":
        return GIcons.alert_16;
      case "subscribed":
        return GIcons.eye_24;
      case "comment":
        return GIcons.comment_24;

        break;

      default:
        print(type);
        return GIcons.arrow_both_16;
    }
  }

  Color getColor(String type) {
    switch (type) {
      case "author":
        return GColors.green;
      case "manual":
        return GColors.gray;
      case "mention":
        return GColors.yellow;
      case "PullRequest":
        return GColors.purple;
      case "security_alert":
        return GColors.red;
      case "subscribed":
        return GColors.orange;
      case "comment":
        return GColors.blue;

        break;
      default:
        return GColors.blue;
    }
  }

  String trimMessage(String text) {
    if (text.length > 40) {
      return text.substring(0, 37) + " ...";
    } else {
      return text;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      physics: BouncingScrollPhysics(),
      controller: controller ?? ScrollController(),
      itemCount: list.length,
      separatorBuilder: (BuildContext context, int index) => Divider(),
      itemBuilder: (BuildContext context, int index) {
        final model = list[index];
        return _notificationTile(context, model);
      },
    );
  }
}
