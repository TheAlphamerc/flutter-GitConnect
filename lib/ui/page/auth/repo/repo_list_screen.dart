import 'package:flutter/material.dart';
import 'package:flutter_github_connect/bloc/repo/index.dart';
import 'package:flutter_github_connect/ui/widgets/cached_image.dart';
import 'package:flutter_github_connect/ui/widgets/custom_text.dart';

class RepositoryListScreen extends StatelessWidget {
  final List<RepositoryModel> list;

  const RepositoryListScreen({Key key, this.list}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: list.length,
      separatorBuilder: (BuildContext context, int index) => Divider(),
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
          leading: SizedBox(
              height: 40,
              width: 40,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: customNetworkImage(list[index].owner.avatarUrl),
              )),
          title: KText(
            list[index].name,
            variant: TypographyVariant.header,
          ),
          subtitle:list[index].description  == null ? null : KText(
            list[index].description ?? "",
            variant: TypographyVariant.subHeader,
            style: TextStyle(fontSize: 14),
          ),
        );
      },
    );
  }
}
