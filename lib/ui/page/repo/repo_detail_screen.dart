import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_github_connect/bloc/bloc/repo_bloc.dart';
import 'package:flutter_github_connect/bloc/bloc/repo_response_model.dart';
import 'package:flutter_github_connect/helper/GIcons.dart';
import 'package:flutter_github_connect/ui/widgets/g_card.dart';
import 'package:flutter_github_connect/ui/widgets/markdown/markdown_viewer.dart';
import 'package:flutter_github_connect/ui/widgets/user_image.dart';
import 'package:flutter_github_connect/ui/theme/export_theme.dart';

class RepoDetailScreen extends StatelessWidget {
  const RepoDetailScreen({
    Key key,
    this.model,
  }) : super(key: key);
  final RepositoryModel model;
  Widget _iconWithText(context, IconData icon, String text, {Color iconColor}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: <Widget>[
          Icon(icon,
              color: iconColor ?? Theme.of(context).colorScheme.onSurface,
              size: 18),
          SizedBox(width: 10),
          Text(
            text ?? "N/A",
            style: Theme.of(context).textTheme.bodyText1,
          )
        ],
      ),
    );
  }

  Widget _getUtilRos(context, String text,
      {Function onPressed,
      Color color,
      IconData icon = GIcons.chevron_right_24,
      String value = ""}) {
    return Row(
      children: <Widget>[
        SizedBox(width: 16, height: 50),
        Text(
          text,
          style: Theme.of(context).textTheme.bodyText1,
        ),
        Spacer(),
        Text(
          value,
          style: Theme.of(context).textTheme.subtitle2,
        ),
        if (icon != null)
          Icon(
            icon,
            color: Theme.of(context).colorScheme.onSurface,
            size: 18,
          ),
        if (icon == null) SizedBox(width: 16, height: 50)
      ],
    ).ripple(onPressed);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GCard(
            radius: 0,
            padding: EdgeInsets.symmetric(
              horizontal: 16,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 12),
                UserAvatar(
                  height: 25,
                  imagePath: model.owner.avatarUrl,
                  subtitle: model.owner.login,
                ),
                SizedBox(height: 8),
                Text(
                  model.name,
                  style: Theme.of(context).textTheme.headline6,
                ),
                SizedBox(height: 8),
                Text(
                  model.description ?? "",
                  style: Theme.of(context).textTheme.bodyText2,
                ),
                SizedBox(height: 8),
                Row(
                  children: <Widget>[
                    _iconWithText(
                      context,
                      GIcons.star_fill_24,
                      "${model.stargazers.totalCount} Stars",
                    ),
                    SizedBox(width: 20),
                    _iconWithText(
                      context,
                      GIcons.git_fork_24,
                      "${model.forkCount} Forks",
                    ),
                  ],
                ),
                SizedBox(height: 8),
              ],
            ),
          ),
          GCard(
            radius: 0,
            child: Column(
              children: <Widget>[
                Divider(height: 1),
                _getUtilRos(
                  context,
                  "Issues",
                  value: "${model.issues.totalCount}",
                ),
                _getUtilRos(
                  context,
                  "Watchers",
                  value: "${model.watchers.totalCount}",
                ),
                _getUtilRos(
                  context,
                  "Pull Request",
                  value: "${model.pullRequests.totalCount}",
                ),
                _getUtilRos(context, "Language",
                    value: "${model?.primaryLanguage?.name ?? "N/A"}",
                    icon: null),
                _getUtilRos(context, "Default Branch",
                    value: model.defaultBranchRef?.name ?? "N/A", icon: null),
                _getUtilRos(context, "Commits", icon: null),
                _getUtilRos(context, "Browse Code", icon: null),
              ],
            ),
          ),
          SizedBox(height: 16),
          BlocBuilder<RepoBloc, RepoState>(
            builder: (context, state) {
              if (state is LoadReadmeState)
                return GCard(
                  radius: 0,
                  child: Center(
                    child: MarkdownViewer(
                      markdownData: state.readme,
                    ),
                  ),
                );
              if (state is ErrorReadmeState) {
                return SizedBox();
              }
              return Container(
                alignment: Alignment.center,
                height: 30,
                child: SizedBox(
                  height: 20,
                  width: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 1,
                    valueColor: AlwaysStoppedAnimation(GColors.blue),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
