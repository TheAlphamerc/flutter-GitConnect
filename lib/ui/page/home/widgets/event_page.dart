import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_github_connect/bloc/User/index.dart';
import 'package:flutter_github_connect/bloc/User/model/event_model.dart';
import 'package:flutter_github_connect/helper/GIcons.dart';
import 'package:flutter_github_connect/helper/shared_prefrence_helper.dart';
import 'package:flutter_github_connect/helper/utility.dart';
import 'package:flutter_github_connect/ui/theme/export_theme.dart';
import 'package:flutter_github_connect/ui/widgets/g_card.dart';
import 'package:flutter_github_connect/ui/widgets/user_image.dart';
import 'package:get_it/get_it.dart';

class EventsPage extends StatelessWidget {
  const EventsPage({Key key,}) : super(key: key);
  final int widthOffset = 66;

  Widget _issueTile(context, EventModel model, String username,
      {bool isCommented = false}) {
    return GCard(
        color: Theme.of(context).colorScheme.surface,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              width: 50,
              child: Icon(
                getIcon(model.payload.issue.state),
                color: getColor(model.payload.issue.state),
                size: 20,
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width - widthOffset,
                  child: Text(
                    '${model.repo.name} #${model.payload.issue.number}',
                    style: Theme.of(context).textTheme.subtitle2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                SizedBox(height: 8),
                Container(
                  width: MediaQuery.of(context).size.width - widthOffset,
                  child: Text(
                    '${model.payload.issue.title}',
                    style: Theme.of(context).textTheme.bodyText1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                SizedBox(height: 8),
                UserAvatar(
                  imagePath: model.actor.avatarUrl,
                  height: 18,
                  subtitle: username == model.actor.login && isCommented
                      ? "You Commented"
                      : model.payload.action == "closed"
                          ? "You closed this issue"
                          : model.actor.login,
                ),
                SizedBox(height: 8),
                if (model.createdAt != null)
                  Container(
                    width: MediaQuery.of(context).size.width - widthOffset,
                    alignment: Alignment.bottomRight,
                    child: Text(
                      Utility.getPassedTime(model.createdAt.toString()) +
                          " ago",
                      style: Theme.of(context).textTheme.subtitle2,
                    ),
                  ),
                SizedBox(height: 8),
              ],
            ),
            // Spacer(),
          ],
        ).vP16);
  }

  Widget _pushCommitEvent(context, EventModel model, String username) {
    return GCard(
        color: Theme.of(context).colorScheme.surface,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              width: 50,
              child: Icon(
                GIcons.commit_24,
                color: GColors.yellow,
                size: 20,
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width - widthOffset,
                  child: Text(
                    '${model.repo.name}',
                    style: Theme.of(context).textTheme.subtitle1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                SizedBox(height: 8),
                Container(
                  padding: EdgeInsets.only(right: 5),
                  width: MediaQuery.of(context).size.width - widthOffset,
                  child: Text(
                    '${model.payload?.commits?.first?.message ?? ""}',
                    style: Theme.of(context).textTheme.bodyText1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                SizedBox(height: 8),
                UserAvatar(
                  imagePath: model.actor.avatarUrl,
                  height: 18,
                  subtitle: username == model.actor.login
                      ? "You pushed a commit"
                      : model.actor.login,
                ),
                SizedBox(height: 8),
                Container(
                  width: MediaQuery.of(context).size.width - widthOffset,
                  alignment: Alignment.bottomRight,
                  child: Text(
                    Utility.getPassedTime(model.createdAt.toString()) + " ago",
                    style: Theme.of(context).textTheme.subtitle2,
                  ),
                )
              ],
            ),
          ],
        ).vP16);
  }

  Widget _pullRequestTile(context, EventModel model, String username,
      {bool isCommented = false}) {
    return GCard(
        color: Theme.of(context).colorScheme.surface,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              width: 50,
              child: Icon(
                getIcon(null, eventType: model.type),
                color: getColor(null, eventType: model.type),
                size: 20,
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width - widthOffset,
                  child: Text(
                    '${model.repo.name}',
                    style: Theme.of(context).textTheme.subtitle1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                SizedBox(height: 8),
                Container(
                  width: MediaQuery.of(context).size.width - widthOffset,
                  child: Text(
                    '${model.payload.pullRequest.title ?? "N/A"}',
                    style: Theme.of(context).textTheme.bodyText1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                SizedBox(height: 8),
                UserAvatar(
                  imagePath: model.actor.avatarUrl,
                  height: 18,
                  subtitle: username == model.actor.login && isCommented
                      ? "You created a pull request"
                      : model.actor.login,
                ),
                if (model.createdAt != null)
                  Container(
                    width: MediaQuery.of(context).size.width - widthOffset,
                    alignment: Alignment.bottomRight,
                    child: Text(
                      Utility.getPassedTime(model.createdAt.toString()) +
                          " ago",
                      style: Theme.of(context).textTheme.subtitle2,
                    ),
                  )
              ],
            ),
            // Spacer(),
          ],
        ).vP16);
  }

  Widget _createRepoEventTile(context, EventModel model, String username) {
    return GCard(
        color: Theme.of(context).colorScheme.surface,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              width: 50,
              child: Icon(
                getCreatedIcon(model.payload.refType),
                color: GColors.green,
                size: 20,
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width - widthOffset,
                  child: Text(
                    '${model.repo.name}',
                    style: Theme.of(context).textTheme.subtitle1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                SizedBox(height: 8),
                Container(
                  padding: EdgeInsets.only(right: 5),
                  width: MediaQuery.of(context).size.width - widthOffset,
                  child: Text(
                    '${model.payload?.ref ?? ""}',
                    style: Theme.of(context).textTheme.bodyText1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                SizedBox(height: 8),
                UserAvatar(
                  imagePath: model.actor.avatarUrl,
                  height: 18,
                  subtitle: username == model.actor.login
                      ? "You created a ${model.payload.refType}"
                      : model.actor.login,
                ),
                SizedBox(height: 8),
                Container(
                  width: MediaQuery.of(context).size.width - widthOffset,
                  alignment: Alignment.bottomRight,
                  child: Text(
                    Utility.getPassedTime(model.createdAt.toString()) + " ago",
                    style: Theme.of(context).textTheme.subtitle2,
                  ),
                )
              ],
            ),
          ],
        ).vP16);
  }

  Widget _noActivity(context) {
    return GCard(
      margin: EdgeInsets.symmetric(horizontal: 16),
      color: Theme.of(context).colorScheme.surface,
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Text("No recent activity detected at your github account yet.",
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyText2),
    );
  }

  IconData getCreatedIcon(String ref) {
    switch (ref) {
      case "branch":
        return GIcons.git_branch_24;
      case "repository":
        return GIcons.repo_24;
      case "issue":
        return GIcons.issue_opened_24;
      default:
        return GIcons.arrow_both_16;
    }
  }

  IconData getIcon(EventState type, {UserEventType eventType}) {
    if (eventType != null) {
      switch (eventType) {
        case UserEventType.PULL_REQUEST_EVENT:
          return GIcons.git_pull_request_24;
        default:
          print(eventType);
          return GIcons.arrow_both_16;
      }
    }

    switch (type) {
      case EventState.OPEN:
        return GIcons.issue_opened_24;
      case EventState.CLOSED:
        return GIcons.issue_closed_24;
      default:
        print(type);
        return GIcons.arrow_both_16;
    }
  }

  Color getColor(EventState type, {UserEventType eventType}) {
    if (eventType != null) {
      switch (eventType) {
        case UserEventType.PULL_REQUEST_EVENT:
          return GColors.purple;
        default:
          print(eventType);
          return GColors.yellow;
      }
    }
    switch (type) {
      case EventState.OPEN:
        return GColors.green;
      case EventState.CLOSED:
        return GColors.red;
      default:
        return GColors.blue;
    }
  }
  
  Widget _loader() {
    return Container(
      alignment: Alignment.center,
      height: 60,
      child: SizedBox(
        height: 20,
        width: 20,
        child: CircularProgressIndicator(
          strokeWidth: 1,
          valueColor: AlwaysStoppedAnimation(GColors.blue),
        ),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
       buildWhen: (oldState, newState) {
         if(oldState is LoadedUserState){
           if(oldState.eventList == null){
             return true;
           } else{
             print("Restrict Events to build again");
             return false;
           }
         }
        return false;
      },
      builder: (context, state) {
        List<EventModel> eventList;
        if (state is LoadedUserState) {
          eventList = state.eventList;
        }else if(state is LoadingEventState){
          return  _loader();
        }
        return eventList == null
            ? _noActivity(context)
            : FutureBuilder(
                initialData: "",
                future: GetIt.instance<SharedPrefrenceHelper>().getUserName(),
                builder: (context, AsyncSnapshot<String> snapshot) {
                  return GCard(
                    color: Theme.of(context).colorScheme.surface,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        ...eventList.map(
                          (model) {
                            if (model.type == UserEventType.PUSH_EVENT) {
                              return Column(
                                children: <Widget>[
                                  // Text(model.type.toString()),
                                  _pushCommitEvent(
                                      context, model, snapshot.data ?? ""),
                                  if (eventList.last != model)
                                    Divider(height: 1, indent: 50),
                                ],
                              );
                            } else if (model.type ==
                                UserEventType.ISSUES_EVENT) {
                              return Column(
                                children: <Widget>[
                                  // Text(model.type.toString()),
                                  _issueTile(
                                      context, model, snapshot.data ?? ""),
                                  if (eventList.last != model)
                                    Divider(height: 1, indent: 50),
                                ],
                              );
                            } else if (model.type ==
                                UserEventType.ISSUE_COMMENT_EVENT) {
                              return Column(
                                children: <Widget>[
                                  // Text(model.type.toString()),
                                  _issueTile(
                                      context, model, snapshot.data ?? "",
                                      isCommented: true),
                                  if (eventList.last != model)
                                    Divider(height: 1, indent: 50),
                                ],
                              );
                            } else if (model.type ==
                                UserEventType.PULL_REQUEST_EVENT) {
                              return Column(
                                children: <Widget>[
                                  // Text(model.type.toString()),
                                  _pullRequestTile(
                                      context, model, snapshot.data ?? "",
                                      isCommented: true),
                                  if (eventList.last != model)
                                    Divider(height: 1, indent: 50),
                                ],
                              );
                            } else if (model.type ==
                                UserEventType.CREATE_EVENT) {
                              return Column(
                                children: <Widget>[
                                  // Text(model.type.toString()),
                                  _createRepoEventTile(
                                    context,
                                    model,
                                    snapshot.data ?? "",
                                  ),
                                  if (eventList.last != model)
                                    Divider(height: 1, indent: 50),
                                ],
                              );
                            } else {
                              return SizedBox.shrink();
                            }
                          },
                        ).toList(),
                      ],
                    ),
                  );
                },
              );
      },
    );
  }
}
