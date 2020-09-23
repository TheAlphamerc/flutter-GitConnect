import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_github_connect/bloc/bloc/repo_bloc.dart';
import 'package:flutter_github_connect/bloc/bloc/repo_response_model.dart';
import 'package:flutter_github_connect/helper/GIcons.dart';
import 'package:flutter_github_connect/ui/page/common/under_development.dart';
import 'package:flutter_github_connect/ui/page/issues/repo_issues_page.dart';
import 'package:flutter_github_connect/ui/page/pullRequest/pull_request.dart';
import 'package:flutter_github_connect/ui/page/repo/forks/repo_forks_page_provider.dart';
import 'package:flutter_github_connect/ui/page/repo/stargezers/repo_stargezers_page_provider.dart';
import 'package:flutter_github_connect/ui/page/repo/watchers/repo_watchers_page_provider.dart';
import 'package:flutter_github_connect/ui/page/user/User_page.dart';
import 'package:flutter_github_connect/ui/widgets/g_card.dart';
import 'package:flutter_github_connect/ui/widgets/g_loader.dart';
import 'package:flutter_github_connect/ui/widgets/markdown/markdown_viewer.dart';
import 'package:flutter_github_connect/ui/widgets/user_image.dart';
import 'package:flutter_github_connect/ui/theme/export_theme.dart';

class RepoDetailScreen extends StatelessWidget {
  const RepoDetailScreen({
    Key key,
    this.model,
  }) : super(key: key);
  final RepositoryModel model;
  Widget _iconWithText(context, IconData icon, String text, {Color iconColor, Function onPressed}) {
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
    ).ripple((){
      if(onPressed != null){
        onPressed();
      }
      else{
        Underdevelopment.displaySnackbar(context,
          msg: "Detail feature is under development");
      }
      
    });
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
    ).ripple(onPressed ?? (){Underdevelopment.displaySnackbar(context,
          msg: "Detail feature is under development");});
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
                GestureDetector(
                  onTap: () => Navigator.of(context).push(
                    UserPage.getPageRoute(context, login: model.owner.login),
                  ),
                  child: UserAvatar(
                    height: 25,
                    imagePath: model.owner.avatarUrl,
                    subtitle: model.owner.login,
                  ),
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
                      onPressed:(){
                        Navigator.push(context, RepoStargezersPageProvider.getPageRoute(owner:model.owner.login, name:model.name));
                       }
                    ),
                    SizedBox(width: 20),
                    _iconWithText(
                      context,
                      GIcons.git_fork_24,
                      "${model.forkCount} Forks",
                      onPressed:(){
                        Navigator.push(context, RepoForksPageProvider.getPageRoute(owner:model.owner.login, name:model.name));
                       }
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
                  onPressed:(){
                    Navigator.push(context, RepoIssuesPage.getPageRoute(owner:model.owner.login, name:model.name));
                  }
                ),
                _getUtilRos(
                  context,
                  "Watchers",
                  value: "${model.watchers.totalCount}",
                  onPressed:(){
                    Navigator.push(context, RepoWatchersPageProvider.getPageRoute(context, owner:model.owner.login, name:model.name));
                  }
                ),
                _getUtilRos(
                  context,
                  "Pull Request",
                  value: "${model.pullRequests.totalCount}",
                  onPressed:(){
                    Navigator.push(context, RepoPullRequestPageProvider.getPageRoute(context, owner:model.owner.login, name:model.name));
                  }
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
                  child:GLoader(stroke: 1,)
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
