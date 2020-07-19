import 'package:flutter/material.dart';
import 'package:flutter_github_connect/bloc/User/User_model.dart';
import 'package:flutter_github_connect/bloc/repo/index.dart';
import 'package:flutter_github_connect/ui/theme/extentions.dart';
import 'package:flutter_github_connect/ui/widgets/custom_text.dart';
import 'package:flutter_github_connect/ui/widgets/user_image.dart';

class RepositoryListScreen extends StatelessWidget {
  final List<RepositoryModel> list;
  final List<RepositoriesNode> list1;

  const RepositoryListScreen({Key key, this.list, this.list1})
      : super(key: key);
  Widget repoCard(RepositoriesNode repo) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          UserAvatar(
            subtitle: repo.owner.login,
            imagePath: repo.owner.avatarUrl,
          ),
          SizedBox(height: 16),
          KText(
            repo.name,
            variant: TypographyVariant.h2,
          ),
          SizedBox(height: 8),
          KText(
            repo.description ?? "N/A",
            variant: TypographyVariant.h4,
            style: TextStyle(letterSpacing: .6, height: 1.3),
          ),
          SizedBox(height: 16),
          repo.languages.nodes.isEmpty
              ? SizedBox()
              : Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(bottom: 3),
                      child: Icon(Icons.star,
                          size: 20, color: Colors.yellowAccent[700]),
                    ),
                    SizedBox(width: 10),
                    KText(
                      "${repo.stargazers.totalCount}",
                      variant: TypographyVariant.h4,
                    ),
                    SizedBox(width: 20),
                    Icon(
                      Icons.blur_circular,
                      color: repo.languages.nodes.first.color,
                      size: 15,
                    ),
                    SizedBox(width: 5),
                    KText(
                      "${repo.languages.nodes.first.name}",
                      variant: TypographyVariant.h4,
                      isSubtitle: true,
                    ),
                  ],
                ),
        ],
      ),
    ).ripple(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        title: Text("Repositories"),
      ),
      body: ListView.separated(
        itemCount: list1.length,
        separatorBuilder: (BuildContext context, int index) =>
            Divider(height: 0),
        itemBuilder: (BuildContext context, int index) {
          final repo = list1[index];
          return repoCard(repo);
        },
      ),
    );
  }
}
