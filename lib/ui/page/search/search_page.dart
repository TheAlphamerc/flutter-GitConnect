import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_github_connect/ui/theme/export_theme.dart';
import 'package:flutter_github_connect/helper/GIcons.dart';
import 'package:flutter_github_connect/ui/widgets/custom_text.dart';
import 'package:flutter_github_connect/ui/widgets/g_card.dart';

class SearchPage extends StatelessWidget {
  SearchPage({Key key}) : super(key: key);
  ValueNotifier<String> searchText = ValueNotifier("");
  Widget _getAppBar(context) {
    final theme = Theme.of(context);
    return AppBar(
      backgroundColor: Theme.of(context).colorScheme.surface,
      elevation: 1,
      title: Container(
        alignment: Alignment.bottomLeft,
        padding: EdgeInsets.only(top: 20),
        child: KText(
          "Search",
          variant: TypographyVariant.header,
        ),
      ),
      bottom: PreferredSize(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: CupertinoTextField(
            placeholder: "Search GitHub",
            style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
            autocorrect: true,
            clearButtonMode: OverlayVisibilityMode.editing,
            cursorColor: GColors.blue,
            enableSuggestions: true,
            keyboardAppearance: Brightness.dark,
            onChanged: (val) {
              searchText.value = val;
            },
            textInputAction: TextInputAction.search,
            prefix: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Icon(Icons.search,
                  color: theme.colorScheme.background, size: 20),
            ),
          ),
        ),
        preferredSize: Size(
          MediaQuery.of(context).size.width,
          70,
        ),
      ),
    );
  }

  Widget _getUtilRos(
    context,
    String text, {
    Function onPressed,
    Color color,
    IconData icon,
  }) {
    return ListTile(
      onTap: onPressed,
      contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 12),
      leading: Container(
        width: 30,
        alignment: Alignment.centerRight,
        child: Icon(
          icon,
          color: Theme.of(context).colorScheme.onSurface,
          size: 18,
        ),
      ),
      title: KText(
        text,
        variant: TypographyVariant.h3,
      ),
      trailing: Icon(
        GIcons.chevron_right_24,
        color: Theme.of(context).colorScheme.onSurface,
        size: 18,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: _getAppBar(context),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            ValueListenableBuilder<String>(
              valueListenable: searchText,
              builder: (context, searchText, child) {
                return searchText.isEmpty
                    ? child
                    : Container(
                        color: Theme.of(context).colorScheme.surface,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            _getUtilRos(
                                context, "Repository with \"$searchText\"",
                                color: GColors.green,
                                onPressed: () {},
                                icon: GIcons.repo_24),
                            Divider(
                              height: 0,
                            ),
                            _getUtilRos(context, "Issue with \"$searchText\"",
                                color: GColors.green,
                                onPressed: () {},
                                icon: GIcons.issue_opened_24),
                            Divider(
                              height: 0,
                            ),
                            _getUtilRos(
                                context, "Pull Request with \"$searchText\"",
                                color: GColors.green,
                                onPressed: () {},
                                icon: GIcons.git_pull_request_24),
                            Divider(
                              height: 0,
                            ),
                            _getUtilRos(context, "People with \"$searchText\"",
                                color: GColors.green,
                                onPressed: () {},
                                icon: GIcons.people_24),
                            Divider(
                              height: 0,
                            ),
                            _getUtilRos(
                                context, "Orgnisation with \"$searchText\"",
                                color: GColors.green,
                                onPressed: () {},
                                icon: GIcons.organization_24),
                            Divider(
                              height: 0,
                            ),
                          ],
                        ),
                      );
              },
              child: SizedBox(),
            )
          ],
        ),
      ),
    );
  }
}
