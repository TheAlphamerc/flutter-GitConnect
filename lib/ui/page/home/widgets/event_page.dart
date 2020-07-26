import 'package:flutter/material.dart';
import 'package:flutter_github_connect/bloc/User/model/event_model.dart';
import 'package:flutter_github_connect/helper/GIcons.dart';
import 'package:flutter_github_connect/helper/utility.dart';
import 'package:flutter_github_connect/ui/theme/export_theme.dart';
import 'package:flutter_github_connect/ui/widgets/custom_text.dart';
import 'package:flutter_github_connect/ui/widgets/flat_button.dart';
import 'package:flutter_github_connect/ui/widgets/g_card.dart';
import 'package:flutter_github_connect/ui/widgets/user_image.dart';

class EventsPage extends StatelessWidget {
  const EventsPage({Key key, this.eventList}) : super(key: key);
  final List<EventModel> eventList;
  Widget _recentEvents(context) {
    final list = eventList;
    return list == null
        ? GCard(
            color: Theme.of(context).colorScheme.surface,
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: Column(
              children: <Widget>[
                KText(
                    "Add favourite repositories for quick access at any time, without having to search",
                    textAlign: TextAlign.center,
                    variant: TypographyVariant.h3,
                    style: TextStyle(height: 1.25)),
                SizedBox(height: 16),
                GFlatButton(
                  label: "ADD FavouriteS",
                  onPressed: () {},
                ).ripple(() {})
              ],
            ),
          )
        : GCard(
            color: Theme.of(context).colorScheme.surface,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                ...list
                    .where((element) =>
                        element.type == UserEventType.ISSUES_EVENT ||
                        element.type == UserEventType.PUSH_EVENT)
                    .map((model) {
                  if (model.type == UserEventType.PUSH_EVENT) {
                    return Column(
                      children: <Widget>[
                        _createRepoEvent(context, model),
                        if (list.last != model) Divider(height: 0, indent: 50),
                      ],
                    );
                  }
                  else{
                    return Column(
                    children: <Widget>[
                      _issueTile(context, model),
                      if (list.last != model) Divider(height: 0, indent: 50),
                    ],
                  );
                  }
                }).toList(),
              ],
            ),
          );
  }

  Widget _issueTile(context, EventModel model) {
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
                  width: MediaQuery.of(context).size.width - 120,
                  child: KText(
                    '${model.repo.name} #${model.payload.issue.number}',
                    isSubtitle: true,
                    maxLines: 1,
                  ),
                ),
                SizedBox(height: 8),
                Container(
                  width: MediaQuery.of(context).size.width - 120,
                  child: KText(
                    '${model.payload.issue.title}',
                    variant: TypographyVariant.h3,
                    style: TextStyle(fontWeight: FontWeight.w400),
                    maxLines: 1,
                  ),
                ),
                SizedBox(height: 8),

                /// Todo : Replace static string you commned with original String text
                UserAvatar(
                  imagePath: model.actor.avatarUrl,
                  height: 18,
                  subtitle: "You commented",
                ),
                SizedBox(height: 8),
                // if (model.payload.issue.labels != null &&
                //     model.payload.issue.labels.isNotEmpty)
                //   Container(
                //     padding: EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                //     decoration: BoxDecoration(
                //         color:
                //             getColor(model.payload.issue.state).withAlpha(200),
                //         borderRadius: BorderRadius.all(Radius.circular(5)),
                //         border: Border.all(
                //             color: getColor(model.payload.issue.state))),
                //     child: KText(
                //       '${model.payload.issue.labels?.first?.name ?? ""}',
                //       isSubtitle: true,
                //       variant: TypographyVariant.bodySmall,
                //     ),
                //   ),
              ],
            ),
            Spacer(),
            KText(
                Utility.getPassedTime(model.payload.issue.closedAt.toString())),
            SizedBox(width: 16),
          ],
        ).vP16);
  }

  Widget _createRepoEvent(context, EventModel model) {
    return GCard(
        color: Theme.of(context).colorScheme.surface,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              width: 50,
              child: Icon(
                // getIcon(model.payload.issue.state),
                GIcons.commit_24,
                color: GColors.green,
                size: 20,
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                // Container(
                //   width: MediaQuery.of(context).size.width - 120,
                //   child: KText(
                //     '${model.repo.name} #${model.payload.masterBranch}',
                //     isSubtitle: true,
                //     maxLines: 1,
                //   ),
                // ),
                // SizedBox(height: 8),
                Container(
                  width: MediaQuery.of(context).size.width - 141,
                  child: KText(
                    '${model.repo.name}',
                    variant: TypographyVariant.h3,
                    style: TextStyle(fontWeight: FontWeight.w400),
                    overflow: TextOverflow.clip,
                    maxLines: 1,
                  ),
                ),
                SizedBox(height: 8),

                /// Todo : Replace static string you commned with original String text
                UserAvatar(
                  imagePath: model.actor.avatarUrl,
                  height: 18,
                  subtitle: model.actor.login,
                ),
                SizedBox(height: 8),
                Container(
                  width: MediaQuery.of(context).size.width - 140,
                  child: KText(
                    '${model.payload?.commits?.first?.message ?? ""}',
                    isSubtitle: true,
                    variant: TypographyVariant.bodySmall,
                  ),
                ),
              ],
            ),
            Spacer(),
            KText(Utility.getPassedTime(model.createdAt.toString())),
            SizedBox(width: 16),
          ],
        ).vP16);
  }

  IconData getIcon(IssueState type) {
    switch (type) {
      case IssueState.OPEN:
        return GIcons.issue_opened_24;
      case IssueState.CLOSED:
        return GIcons.issue_closed_24;
      default:
        print(type);
        return GIcons.arrow_both_16;
    }
  }

  Color getColor(IssueState type) {
    switch (type) {
      case IssueState.OPEN:
        return GColors.green;
      case IssueState.CLOSED:
        return GColors.red;
      default:
        return GColors.blue;
    }
  }

  @override
  Widget build(BuildContext context) {
    return _recentEvents(context);
  }
}
