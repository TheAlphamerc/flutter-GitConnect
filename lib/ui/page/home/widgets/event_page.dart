import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_github_connect/bloc/User/index.dart';
import 'package:flutter_github_connect/bloc/User/model/event_model.dart';
import 'package:flutter_github_connect/bloc/people/index.dart' as people;
import 'package:flutter_github_connect/helper/GIcons.dart';
import 'package:flutter_github_connect/helper/shared_prefrence_helper.dart';
import 'package:flutter_github_connect/helper/utility.dart';
import 'package:flutter_github_connect/ui/page/common/no_data_page.dart';
import 'package:flutter_github_connect/ui/theme/export_theme.dart';
import 'package:flutter_github_connect/ui/widgets/g_app_bar_title.dart';
import 'package:flutter_github_connect/ui/widgets/g_card.dart';
import 'package:flutter_github_connect/ui/widgets/g_loader.dart';
import 'package:flutter_github_connect/ui/widgets/user_image.dart';
import 'package:get_it/get_it.dart';

class EventsPage extends StatelessWidget {
  const EventsPage({Key key, this.login}) : super(key: key);

  final String login;
  final int widthOffset = 66;

  Widget _loader() {
    return Container(
      alignment: Alignment.center,
      height: 60,
      child: SizedBox(
        height: 20,
        width: 20,
        child: GLoader(stroke: 1),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
      buildWhen: (oldState, newState) {
        if (oldState is LoadedUserState) {
          if (oldState.eventList == null) {
            return true;
          } else {
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
        } else if (state is LoadingEventState) {
          return _loader();
        }
        return EventPageBody(eventList: eventList, login: login);
      },
    );
  }
}

class PeopleEventsPage extends StatefulWidget {
  const PeopleEventsPage({Key key, this.login, this.bloc}) : super(key: key);

  final people.PeopleBloc bloc;
  final String login;

  @override
  _PeopleEventsPageState createState() => _PeopleEventsPageState();

  static MaterialPageRoute getPageRoute(
      {String login, people.PeopleBloc bloc}) {
    return MaterialPageRoute(
      builder: (context) {
        return PeopleEventsPage(
          login: login,
          bloc: bloc..add(people.LoadPeopleActivitiesEvent()),
        );
      },
    );
  }
}

class _PeopleEventsPageState extends State<PeopleEventsPage> {
  final int widthOffset = 66;

  final getIt = GetIt.instance;
  ScrollController _controller;
  String loggedInUserName;

  @override
  void initState() {
    _controller = ScrollController()..addListener(listener);

    super.initState();
  }

  void listener() {
    if (_controller.position.pixels == _controller.position.maxScrollExtent) {
      widget.bloc.add(people.LoadPeopleActivitiesEvent(loadNextActivity: true));
    }
  }

  Widget _loader() {
    return Container(
      alignment: Alignment.center,
      height: 60,
      child: SizedBox(
        height: 20,
        width: 20,
        child: GLoader(stroke: 1),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar:
          AppBar(title: GAppBarTitle(login: widget.login, title: "Activities")),
      body: BlocBuilder<people.PeopleBloc, people.PeopleState>(
        cubit: widget.bloc,
        builder: (context, state) {
          List<EventModel> eventList;
          if (state is people.LoadedPeopleActivityStates) {
            eventList = state.eventList;
          } else if (state is people.LoadingPeopleActivityStates) {
            return _loader();
          }
          if (eventList != null && eventList.isNotEmpty)
            return SingleChildScrollView(
              controller: _controller,
              physics: BouncingScrollPhysics(),
              child: Column(
                children: <Widget>[
                  FutureBuilder(
                      future: getIt<SharedPrefrenceHelper>().getUserName(),
                      builder: (context, AsyncSnapshot<String> snapshot) {
                        if(snapshot.hasData)
                        return EventPageBody(
                          eventList: eventList,
                          login: widget.login,
                          loggedInUserName: snapshot.data,
                        );
                        return _loader();
                      }),
                  if (state is people.LoadingNextPeopleActivityStates) _loader()
                ],
              ),
            );
          return NoDataPage(
              title: "Activities",
              description: "No recent activity detected",
              icon: GIcons.github);
        },
      ),
    );
  }
}

class EventPageBody extends StatelessWidget {
  const EventPageBody(
      {Key key, this.eventList, this.login, this.loggedInUserName})
      : super(key: key);

  final List<EventModel> eventList;
  final String login;
  final int widthOffset = 66;
  final String loggedInUserName;

  Widget _issueTile(context, EventModel model, {bool isCommented = false}) {
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
                  subtitle: isMyEvent(model.actor.login) && isCommented
                      ? "You Commented"
                      : model.payload.action == "closed"
                          ? "You closed this issue"
                          : "Closed this issue",
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

  Widget _pushCommitEvent(context, EventModel model) {
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
                  subtitle: isMyEvent(model.actor.login)
                      ? "You created a commit"
                      : "Created a new commit",
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

  Widget _pullRequestTile(context, EventModel model,
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
                  subtitle: isMyEvent(model.actor.login) && isCommented
                      ? "You created a pull request"
                      : "Created a pull request",
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

  Widget _createRepoEventTile(context, EventModel model) {
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
                  subtitle: isMyEvent(model.actor.login)
                      ? "You created a ${model.payload.refType}"
                      : "Created a ${model.payload.refType}",
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

  Widget _watchRepoEventTile(context, EventModel model) {
    return GCard(
        color: Theme.of(context).colorScheme.surface,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              width: 50,
              child: Icon(
                GIcons.eye_24,
                color: GColors.blue,
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
                UserAvatar(
                  imagePath: model.actor.avatarUrl,
                  height: 18,
                  subtitle: isMyEvent(model.actor.login)
                      ? "You created a ${model.payload.refType}"
                      : "${model.payload.action} watching repo",
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

  bool isMyEvent(String name) {
    if (loggedInUserName != null) {
      return name == loggedInUserName;
    } else
      return login == name;
  }

  @override
  Widget build(BuildContext context) {
    return eventList == null
        ? _noActivity(context)
        : GCard(
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
                            context,
                            model,
                          ),
                          if (eventList.last != model)
                            Divider(height: 1, indent: 50),
                        ],
                      );
                    } else if (model.type == UserEventType.ISSUES_EVENT) {
                      return Column(
                        children: <Widget>[
                          // Text(model.type.toString()),
                          _issueTile(context, model),
                          if (eventList.last != model)
                            Divider(height: 1, indent: 50),
                        ],
                      );
                    } else if (model.type ==
                        UserEventType.ISSUE_COMMENT_EVENT) {
                      return Column(
                        children: <Widget>[
                          // Text(model.type.toString()),
                          _issueTile(context, model, isCommented: true),
                          if (eventList.last != model)
                            Divider(height: 1, indent: 50),
                        ],
                      );
                    } else if (model.type == UserEventType.PULL_REQUEST_EVENT) {
                      return Column(
                        children: <Widget>[
                          // Text(model.type.toString()),
                          _pullRequestTile(context, model, isCommented: true),
                          if (eventList.last != model)
                            Divider(height: 1, indent: 50),
                        ],
                      );
                    } else if (model.type == UserEventType.CREATE_EVENT) {
                      return Column(
                        children: <Widget>[
                          // Text(model.type.toString()),
                          _createRepoEventTile(context, model),
                          if (eventList.last != model)
                            Divider(height: 1, indent: 50),
                        ],
                      );
                    } else if (model.type == UserEventType.WATCH_EVENT) {
                      return Column(
                        children: <Widget>[
                          _watchRepoEventTile(context, model),
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
  }
}
