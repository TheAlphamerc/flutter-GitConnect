import 'package:flutter/material.dart';
import 'package:flutter_github_connect/helper/GIcons.dart';
import 'package:flutter_github_connect/helper/utility.dart';
import 'package:flutter_github_connect/ui/theme/colors.dart';
import 'package:flutter_github_connect/ui/widgets/g_app_bar_title.dart';
import 'package:flutter_github_connect/ui/widgets/markdown/markdown_viewer.dart';

class GistFileContent extends StatelessWidget {
  const GistFileContent({Key key, this.filename, this.content, this.url})
      : super(key: key);
  final String filename;
  final String content;
  final String url;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: GAppBarTitle(login: null, title: filename),
        actions: <Widget>[
          IconButton(
            icon: Icon(GIcons.share_android_24, color: GColors.blue),
            onPressed: () {
              Utility.share(url);
            },
          ),
        ],
        bottom: PreferredSize(
          child: Divider(
            height: 0,
          ),
          preferredSize: Size(MediaQuery.of(context).size.width, 0),
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        color: Theme.of(context).colorScheme.surface,
        child: MarkdownViewer(markdownData: content),
      ),
    );
  }
}
