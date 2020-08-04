import 'package:flutter/material.dart';
import 'package:flutter_github_connect/helper/GIcons.dart';
import 'package:flutter_github_connect/helper/shared_prefrence_helper.dart';
import 'package:flutter_github_connect/helper/utility.dart';
import 'package:flutter_github_connect/model/pul_request.dart';
import 'package:flutter_github_connect/ui/widgets/g_card.dart';
import 'package:flutter_github_connect/ui/widgets/user_image.dart';
import 'package:flutter_github_connect/ui/theme/export_theme.dart';
import 'package:get_it/get_it.dart';

class PullRequestScreen extends StatelessWidget {
  final UserPullRequests pullRequest;
  const PullRequestScreen({Key key, this.pullRequest}) : super(key: key);
  Widget _pullRequestTile(context, Node model, String username,
      {bool isCommented = false}) {
    final double widthOffset = 58.0;
    return GCard(
        color: Theme.of(context).colorScheme.surface,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              width: 50,
              child: Icon(
                getIcon(model.state),
                color: getColor(model.state),
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
                    '${model.repository.nameWithOwner}',
                    style: Theme.of(context).textTheme.subtitle1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                SizedBox(height: 8),
                Container(
                  width: MediaQuery.of(context).size.width - widthOffset,
                  child: Text(
                    '${model.title ?? "N/A"}',
                    style: Theme.of(context).textTheme.bodyText1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                SizedBox(height: 8),
                SizedBox(
                  width: MediaQuery.of(context).size.width - widthOffset,
                  child: Text(
                    "#${model.number} by ${model.author.login}   was ${model.getPullRequestState()} " ,
                    style: Theme.of(context).textTheme.subtitle2,
                  ),
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


  IconData getIcon(
    PullRequestState type,
  ) {
    switch (type) {
      case PullRequestState.OPEN:
        return GIcons.git_pull_request_24;
      case PullRequestState.CLOSED:
        return GIcons.git_pull_request_24;
      case PullRequestState.MERGED:
        return GIcons.git_merge_24;
      default:
        print(type);
        return GIcons.arrow_both_16;
    }
  }

  Color getColor(
    PullRequestState type,
  ) {
    switch (type) {
      case PullRequestState.OPEN:
        return GColors.green;
      case PullRequestState.CLOSED:
        return GColors.red;
      case PullRequestState.MERGED:
        return GColors.purple;
      default:
        return GColors.blue;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: FutureBuilder(
        initialData: "",
        future: GetIt.instance<SharedPrefrenceHelper>().getUserName(),
        builder: (context, AsyncSnapshot<String> snapshot) {
          return GCard(
            color: Theme.of(context).colorScheme.surface,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                ...pullRequest.nodes.map(
                  (model) {
                    return Column(
                      children: <Widget>[
                        // Text(model.type.toString()),
                        _pullRequestTile(context, model, snapshot.data ?? "",
                            isCommented: true),
                        if (pullRequest.nodes.last != model)
                          Divider(height: 1, indent: 50),
                      ],
                    );
                  },
                ).toList(),
              ],
            ),
          );
        },
      ),
    );
  }
}
