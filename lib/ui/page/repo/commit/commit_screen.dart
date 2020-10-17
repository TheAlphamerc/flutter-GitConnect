import 'package:flutter/material.dart';
import 'package:flutter_github_connect/bloc/commit/index.dart';
import 'package:flutter_github_connect/helper/GIcons.dart';
import 'package:flutter_github_connect/helper/utility.dart';
import 'package:flutter_github_connect/ui/page/common/under_development.dart';
import 'package:flutter_github_connect/ui/page/user/User_page.dart';
import 'package:flutter_github_connect/ui/widgets/g_card.dart';
import 'package:flutter_github_connect/ui/theme/export_theme.dart';
import 'package:flutter_github_connect/ui/widgets/user_image.dart';

class CommitScreen extends StatelessWidget {
  final ScrollController controller;
  final History history;
  Widget _commitTile(BuildContext context, Edge edge) {
    final model = edge.node;
    return GCard(
      radius: 0,
      color: Theme.of(context).colorScheme.surface,
      child: Column(
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width,
                child: Text(
                  '${model.messageHeadline}',
                  style: Theme.of(context).textTheme.bodyText1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              SizedBox(height: 8),
              if (model.author != null && model.author.user != null)
                Row(
                  children: <Widget>[
                    UserAvatar(
                      height: 20,
                      imagePath: model.author.user.avatarUrl,
                      subtitle: "${model.author.user.login}",
                      subTitleStyle: Theme.of(context)
                          .textTheme
                          .bodyText1
                          .copyWith(fontSize: 14),
                    ),
                    Text(
                      ' authored',
                      style: Theme.of(context)
                          .textTheme
                          .subtitle1
                          .copyWith(fontSize: 14),
                      overflow: TextOverflow.ellipsis,
                    ),
                    Spacer(),
                    if (model.committedDate != null)
                      Container(
                        alignment: Alignment.bottomRight,
                        child: Text(
                          Utility.getPassedTime(model.committedDate.toString()),
                          style: Theme.of(context).textTheme.subtitle2,
                        ),
                      )
                  ],
                ),
              SizedBox(height: 8),
            ],
          ).p16,
          Divider(height: 0)
        ],
      ).ripple(() {
        // Underdevelopment.displaySnackbar(context,
        //     msg: "Pull request detail feature is under development");
        showCommitDetail(context, model);
      }),
    );
  }

  void showCommitDetail(BuildContext context, Node model) async {
    await showModalBottomSheet(
        context: context,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10), topRight: Radius.circular(10)),
        ),
        builder: (context) {
          return Container(
            height: 300,
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: 0),
                Center(
                  child: Container(
                      height: 5,
                      width: 90,
                      decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.surface,
                          borderRadius: BorderRadius.circular(20))),
                ),
                SizedBox(height: 20),
                UserAvatar(
                  height: 40,
                  imagePath: model.author.user.avatarUrl,
                  subtitle: "${model.author.user.name ?? ""}",
                  name: "${model.author.user.login}",
                ).ripple(() {
                  Navigator.pop(context);
                  Navigator.push(
                      context,
                      UserPage.getPageRoute(context,
                          login: model.author.user.login));
                }),
                SizedBox(height: 20),
                Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(bottom: 3),
                      child: Icon(GIcons.diff_removed_16,
                          size: 14, color: GColors.red),
                    ),
                    SizedBox(width: 10),
                    Text(
                      "${model.deletions} Deletions",
                      style: Theme.of(context).textTheme.subtitle2,
                    ),
                    SizedBox(width: 20),
                    Icon(
                      GIcons.diff_added_16,
                      color: GColors.green,
                      size: 14,
                    ),
                    SizedBox(width: 5),
                    Text(
                      "${model.additions} Additions",
                      style: Theme.of(context).textTheme.subtitle2,
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Row(
                  children: <Widget>[
                    Text("Commit: "),
                    Text(
                      model.oid.substring(0, 7),
                      style: Theme.of(context).textTheme.button.copyWith(
                            color: GColors.blue,
                            decoration: TextDecoration.underline,
                          ),
                    ).ripple(() {
                      // Utility.launchTo(model.url);
                      Utility.launchURL(context, model.url);
                      Navigator.pop(context);
                    }),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  children: <Widget>[
                    Text("Date: "),
                    Text(
                      Utility.toDMYformate(model.committedDate),
                      style: Theme.of(context).textTheme.subtitle2,
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Text(model.messageHeadline),
              ],
            ),
          );
        });
  }

  const CommitScreen({Key key, this.controller, this.history})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).backgroundColor,
      child: ListView.builder(
        physics: BouncingScrollPhysics(),
        controller: controller,
        itemCount: history.edges.length,
        itemBuilder: (BuildContext context, int index) {
          return _commitTile(
            context,
            history.edges[index],
          );
        },
      ),
    );
  }
}
