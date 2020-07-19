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
      separatorBuilder: (BuildContext context, int index) => Divider(height: 0),
      itemBuilder: (BuildContext context, int index) {
        final model = list[index];
        return ListTile(
          leading: SizedBox(
              height: 30,
              width: 30,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: customNetworkImage(list[index].owner.avatarUrl),
              )),
          title: KText(
            list[index].name,
            variant: TypographyVariant.h3,
          ),
          trailing: Container(
            constraints: BoxConstraints(minWidth: 40, maxWidth: 60),
            child: Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              children: <Widget>[
                Icon(Icons.star,
                    color: Theme.of(context).colorScheme.secondary, size: 17),
                KText(
                  model.stargazersCount.toString(),
                  variant: TypographyVariant.body,
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
