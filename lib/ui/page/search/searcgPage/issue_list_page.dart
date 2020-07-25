import 'package:flutter/material.dart';
import 'package:flutter_github_connect/bloc/issues/issues_model.dart';
import 'package:flutter_github_connect/helper/GIcons.dart';
import 'package:flutter_github_connect/helper/utility.dart';
import 'package:flutter_github_connect/ui/widgets/custom_text.dart';
import 'package:flutter_github_connect/ui/theme/export_theme.dart';

class IssueListPage extends StatelessWidget {
  const IssueListPage({Key key, this.list, this.hideAppBar}) : super(key: key);
  final List<IssuesModel> list;
  final bool hideAppBar;

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
                  width: MediaQuery.of(context).size.width - 116,
                  child: KText(
                    '${model.author.login}/${model.repository.name} #${model.number}',
                    isSubtitle: true,
                    maxLines: 1,
                  ),
                ),
                SizedBox(height: 8),
                Container(
                  width: MediaQuery.of(context).size.width - 116,
                  child: KText(
                    '${model.title}',
                    variant: TypographyVariant.h3,
                    style: TextStyle(fontWeight: FontWeight.w400),
                    maxLines: 1,
                  ),
                ),
                SizedBox(height: 8),
                SizedBox(height: 8),
                if (model.labels != null && model.labels.nodes.isNotEmpty)
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                    decoration: BoxDecoration(
                        color: getColor(model.state).withAlpha(200),
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                        border: Border.all(color: getColor(model.state))),
                    child: KText(
                      '${model.labels?.nodes?.first?.name ?? ""}',
                      isSubtitle: true,
                      variant: TypographyVariant.bodySmall,
                    ),
                  )
              ],
            ),
            Spacer(),
            KText(Utility.getPassedTime(model.closedAt)),
            SizedBox(width: 16)
          ],
        ).vP16);
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
                title: KText("People"),
              ),
        body: ListView.separated(
          itemCount: list.length,
          separatorBuilder: (BuildContext context, int index) =>
              Divider(height: 0),
          itemBuilder: (BuildContext context, int index) {
            return _issueTile(context, list[index]);
          },
        ));
  }
}
