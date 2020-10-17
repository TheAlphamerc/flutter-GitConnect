import 'package:flutter/material.dart';
import 'package:flutter_github_connect/bloc/issues/issues_model.dart';
import 'package:flutter_github_connect/helper/GIcons.dart';
import 'package:flutter_github_connect/helper/utility.dart';
import 'package:flutter_github_connect/ui/page/common/under_development.dart';
import 'package:flutter_github_connect/ui/page/user/User_page.dart';
import 'package:flutter_github_connect/ui/page/user/User_screen.dart';
import 'package:flutter_github_connect/ui/theme/export_theme.dart';
import 'package:flutter_github_connect/ui/widgets/g_card.dart';
import 'package:flutter_github_connect/ui/widgets/user_image.dart';

class IssueListPage extends StatelessWidget {
  const IssueListPage({Key key, this.list, this.hideAppBar, this.controller}) : super(key: key);
  final List<IssuesModel> list;
  final bool hideAppBar;
  final ScrollController controller;

  Widget _issueTile(context, IssuesModel model) {
    return Container(
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
                      width: MediaQuery.of(context).size.width - 66,
                      child: Text(
                        '${model.author.login}/${model.repository.name} #${model.number}',
                        style: Theme.of(context).textTheme.subtitle1,
                        maxLines: 1,
                      ),
                    ),
                    SizedBox(height: 8),
                    Container(
                      width: MediaQuery.of(context).size.width - 66,
                      child: Text(
                        '${model.title}',
                        style: Theme.of(context).textTheme.bodyText1,
                        maxLines: 1,
                      ),
                    ),
                    SizedBox(height: 8),
                    if (model.labels != null && model.labels.nodes.isNotEmpty)
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                        decoration: BoxDecoration(
                            color: getColor(model.state).withAlpha(200),
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                            border: Border.all(color: getColor(model.state))),
                        child: Text(
                          '${model.labels?.nodes?.first?.name ?? ""}',
                          style: Theme.of(context).textTheme.bodyText2,
                        ),
                      ),
                    if (model.closedAt != null)
                      Container(
                        width: MediaQuery.of(context).size.width - 66,
                        alignment: Alignment.bottomRight,
                        child: Text(
                          Utility.getPassedTime(model.closedAt) + " ago",
                          style: Theme.of(context).textTheme.subtitle2,
                        ),
                      )
                  ],
                ),
              ],
            ).vP16)
        .ripple(() {
      Utility.launchURL(context, model.url);
      // showCommitDetail(context, model);
      // Utility.launchTo(model.url);
      // Underdevelopment.displaySnackbar(context,msg: "Issue detail feature is under development");
    });
  }

  void showCommitDetail(BuildContext context, IssuesModel model) async {
    await showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        builder: (context) {
          return Wrap(children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
                color: Theme.of(context).colorScheme.surface,
              ),
              alignment: Alignment.bottomCenter,
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(height: 0),
                  Center(
                    child: Container(
                        height: 5,
                        width: 90,
                        decoration: BoxDecoration(color: Theme.of(context).cardColor, borderRadius: BorderRadius.circular(20))),
                  ),
                  SizedBox(height: 20),
                  GCard(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                    child: Column(
                      children: <Widget>[
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              "Repository: ",
                              style: Theme.of(context).textTheme.subtitle2,
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width - 153,
                              child: Text(
                                model.repository.name,
                                style: Theme.of(context).textTheme.button.copyWith(
                                      color: GColors.blue,
                                      decoration: TextDecoration.underline,
                                    ),
                              ),
                            ).ripple(() {
                              Utility.launchTo(model.repository.url);
                              Navigator.pop(context);
                            }),
                          ],
                        ),
                        SizedBox(height: 10),
                        Row(
                          children: <Widget>[
                            Text(
                              "State: ",
                              style: Theme.of(context).textTheme.subtitle2,
                            ),
                            Text(
                              model.state,
                              // style: Theme.of(context).textTheme.subtitle2
                            )
                          ],
                        ),
                        SizedBox(height: 10),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              "Title: ",
                              style: Theme.of(context).textTheme.subtitle2,
                            ),
                            Expanded(
                              child: Text(
                                model.title,
                                // style: Theme.of(context).textTheme.subtitle2,
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                  GCard(
                    padding: EdgeInsets.symmetric(horizontal: 26, vertical: 12),
                    child: Center(
                      child: Text("Issue created by", style: Theme.of(context).textTheme.headline6.copyWith(fontSize: 14)),
                    ),
                  ),
                  SizedBox(height: 10),
                  GCard(
                    radius: 10,
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                    child: Wrap(
                      children: <Widget>[
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            SizedBox(
                              height: 30,
                              width: 30,
                              child: Avatar(
                                height: 30,
                                imagePath: model.author.avatarUrl,
                              ),
                            ),
                            SizedBox(width: 10),
                            Text("${model.author.login ?? ""}", style: Theme.of(context).textTheme.headline6),
                          ],
                        )
                      ],
                    ),
                  ).ripple(() {
                    if (model.author.login != null) Navigator.push(context, UserPage.getPageRoute(context, login: model.author.login));
                  }),
                ],
              ),
            ),
          ]);
        });
  }

  IconData getIcon(String type) {
    switch (type) {
      case "OPEN":
        return GIcons.issue_opened_24;
      case "CLOSED":
        return GIcons.issue_closed_24;
      default:
        print(type);
        return GIcons.arrow_both_16;
    }
  }

  Color getColor(String type) {
    switch (type) {
      case "OPEN":
        return GColors.green;
      case "CLOSED":
        return GColors.red;
      default:
        return GColors.blue;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: hideAppBar
          ? null
          : AppBar(
              elevation: 0,
              backgroundColor: Theme.of(context).colorScheme.surface,
              title: Title(
                title: "People",
                color: Colors.black,
                child: Text("People", style: Theme.of(context).textTheme.headline6),
              ),
            ),
      body: ListView.separated(
        physics: BouncingScrollPhysics(),
        controller: controller ?? ScrollController(),
        itemCount: list.length,
        separatorBuilder: (BuildContext context, int index) => Divider(height: 0),
        itemBuilder: (BuildContext context, int index) {
          return _issueTile(context, list[index]);
        },
      ),
    );
  }
}
