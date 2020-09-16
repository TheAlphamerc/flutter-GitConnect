import 'package:flutter/material.dart';
import 'package:flutter_github_connect/bloc/User/model/gist_model.dart';
import 'package:flutter_github_connect/helper/GIcons.dart';
import 'package:flutter_github_connect/helper/utility.dart';
import 'package:flutter_github_connect/ui/page/common/under_development.dart';
import 'package:flutter_github_connect/ui/widgets/g_card.dart';
import 'package:flutter_github_connect/ui/theme/export_theme.dart';

class GistListScreen extends StatelessWidget {
  final Gists gist;
  final String login;
  final ScrollController controller;
  const GistListScreen({Key key, this.gist, this.login, this.controller})
      : super(key: key);
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
                GIcons.code_square_24,
                color: GColors.gray,
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
                    '${model.owner.login}/${model.files.first.name}',
                    style: Theme.of(context).textTheme.subtitle1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                SizedBox(height: 8),
                Container(
                  width: MediaQuery.of(context).size.width - widthOffset,
                  child: Text(
                    '${model.files.first.name ?? "N/A"}',
                    style: Theme.of(context).textTheme.bodyText1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                SizedBox(height: 8),
                Row(
                  children: <Widget>[
                    Icon(GIcons.star_fill_24,
                        size: 16, color: Colors.yellowAccent[700]),
                    SizedBox(width: 10),
                    Text(
                      "${model.stargazers.totalCount}",
                      style: Theme.of(context).textTheme.subtitle2,
                    ),
                    SizedBox(width: 20),
                    Icon(
                      GIcons.file_24,
                      color: Colors.blue,
                      size: 15,
                    ),
                    SizedBox(width: 5),
                    Text(
                      "${model.files.length} ${model.files.length > 1 ? "Files" : "File"}",
                      style: Theme.of(context).textTheme.subtitle2,
                    ),
                    SizedBox(width: 20),
                    if (model.isFork)
                      Icon(
                        GIcons.git_fork_24,
                        color: Colors.purple,
                        size: 15,
                      ),
                    if (model.isFork)
                      Text(
                        "${model.isFork ? "Forked" : "Created"}",
                        style: Theme.of(context).textTheme.subtitle2,
                      ),
                  ],
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
        ).vP16).ripple((){
           Underdevelopment.displaySnackbar(context,
          msg: "Gist detail feature is under development");
        });
  }

  @override
  Widget build(BuildContext context) {
    return GCard(
      radius: 0,
      // color: Theme.of(context).backgroundColor,
      child: ListView.separated(
        controller: controller,
        itemCount: gist.nodes.length,
        separatorBuilder: (BuildContext context, int index) =>
            Divider(indent: 50,height:0),
        itemBuilder: (BuildContext context, int index) {
          return _pullRequestTile(
            context,
            gist.nodes[index],
            login ?? "",
            isCommented: true,
          );
        },
      ),
    );
  }
}
