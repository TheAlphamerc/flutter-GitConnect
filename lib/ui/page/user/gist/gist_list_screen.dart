import 'package:flutter/material.dart';
import 'package:flutter_github_connect/bloc/User/model/gist_model.dart';
import 'package:flutter_github_connect/helper/GIcons.dart';
import 'package:flutter_github_connect/helper/shared_prefrence_helper.dart';
import 'package:flutter_github_connect/helper/utility.dart';
import 'package:flutter_github_connect/ui/widgets/g_card.dart';
import 'package:flutter_github_connect/ui/theme/export_theme.dart';
import 'package:get_it/get_it.dart';

class GistListScreen extends StatelessWidget {
  final Gists gist;
  const GistListScreen({Key key, this.gist}) : super(key: key);
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
                ...gist.nodes.map(
                  (model) {
                    return Column(
                      children: <Widget>[
                        // Text(model.type.toString()),
                        _pullRequestTile(context, model, snapshot.data ?? "",
                            isCommented: true),
                        if (gist.nodes.last != model)
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
