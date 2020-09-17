import 'package:flutter/material.dart';
import 'package:flutter_github_connect/bloc/User/model/gist_model.dart';
import 'package:flutter_github_connect/ui/page/user/gist/gist_detail.dart/gist_file_content.dart';
import 'package:flutter_github_connect/ui/widgets/g_card.dart';
import 'package:flutter_github_connect/ui/theme/export_theme.dart';

class GistDetailScreen extends StatelessWidget {
  const GistDetailScreen({Key key, this.model}) : super(key: key);

  final GistDetail model;

  Widget gistcard(BuildContext context, FileModel model) {
    String codeString;
    if (model.language != "Markdown" && model.language != "Text") {
      codeString = "```${model.language}\n${model.content}\n```";
    } else {
      codeString = model.content;
    }
    return GCard(
      radius: 0,
      color: Theme.of(context).colorScheme.surface,
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      width: MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(model.filename ?? "",
              style: Theme.of(context).textTheme.bodyText1),
          SizedBox(height: 5),
          Row(
            children: <Widget>[
              Text("Language"),
              SizedBox(width: 5),
              Text(model.language ?? "",
                  style: Theme.of(context).textTheme.subtitle1),
            ],
          ),
          Row(
            children: <Widget>[
              Text("Type"),
              SizedBox(width: 5),
              Text(model.type ?? "",
                  style: Theme.of(context).textTheme.subtitle1),
            ],
          ),
        ],
      ),
    ).ripple(() {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => GistFileContent(
              filename: model.filename, content: codeString, url: model.rawUrl),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      physics: BouncingScrollPhysics(),
      itemCount: model.files.list.length,
      separatorBuilder: (BuildContext context, int index) => Divider(height: 0),
      itemBuilder: (BuildContext context, int index) {
        return gistcard(context, model.files.list[index]);
      },
    );
  }
}
