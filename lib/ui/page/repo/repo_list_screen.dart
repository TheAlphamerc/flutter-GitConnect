import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_github_connect/bloc/User/User_model.dart';
import 'package:flutter_github_connect/bloc/User/index.dart';
import 'package:flutter_github_connect/bloc/people/people_bloc.dart';
import 'package:flutter_github_connect/bloc/people/people_state.dart' as people;
import 'package:flutter_github_connect/bloc/search/index.dart';
import 'package:flutter_github_connect/helper/GIcons.dart';
import 'package:flutter_github_connect/ui/page/common/no_data_page.dart';
import 'package:flutter_github_connect/ui/page/repo/repo_detail_page.dart';
import 'package:flutter_github_connect/ui/theme/export_theme.dart';
import 'package:flutter_github_connect/ui/widgets/g_app_bar_title.dart';
import 'package:flutter_github_connect/ui/widgets/g_loader.dart';
import 'package:flutter_github_connect/ui/widgets/user_image.dart';

class RepositoryListScreen extends StatelessWidget {
  final List<RepositoriesNode> list;
  final bool isFromUserRepositoryListPage;
  final UserBloc userBloc;
  final PeopleBloc peopleBloc;
  final ScrollController controller;
  final String login;

  static MaterialPageRoute getPageRoute(
      {ScrollController controller,
      List<RepositoriesNode> list,
      UserBloc userBloc,
      PeopleBloc peopleBloc,
      String login}) {
    return MaterialPageRoute(
      builder: (_) => RepositoryListScreen(
        list: list,
        controller: controller,
        userBloc: userBloc,
        peopleBloc: peopleBloc,
        login: login,
      ),
    );
  }

  /// `isFromUserRepositoryListPage` should be set to true if this screen is used as widget
  const RepositoryListScreen({
    Key key,
    this.list,
    this.isFromUserRepositoryListPage = false,
    this.controller,
    this.userBloc,
    this.peopleBloc,
    this.login,
  }) : super(key: key);

  Widget repoCard(context, RepositoriesNode repo) {
    return Container(
      color: Theme.of(context).colorScheme.surface,
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          UserAvatar(
            subtitle: repo.owner.login,
            imagePath: repo.owner.avatarUrl,
            titleStyle: Theme.of(context).textTheme.subtitle1,
          ),
          SizedBox(height: 16),
          Text(
            repo.name,
            style: Theme.of(context).textTheme.bodyText1,
          ),
          SizedBox(height: 4),
          Text(
            repo.description ?? "N/A",
            style: Theme.of(context).textTheme.subtitle2,
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
                    Text(
                      "${repo.stargazers.totalCount}",
                      style: Theme.of(context).textTheme.subtitle2,
                    ),
                    SizedBox(width: 20),
                    Icon(
                      Icons.blur_circular,
                      color: repo.languages.nodes.first.color,
                      size: 15,
                    ),
                    SizedBox(width: 5),
                    Text(
                      "${repo.languages.nodes.first.name}",
                      style: Theme.of(context).textTheme.subtitle2,
                    ),
                  ],
                ),
        ],
      ),
    ).ripple(() {
      Navigator.of(context).push(RepoDetailPage.getPageRoute(
        context,
        name: repo.name,
        owner: repo.owner.login,
      ));
    });
  }

  Widget _repoList(List<RepositoriesNode> list, {bool displayLoader = false}) {
    return ListView.separated(
      physics: BouncingScrollPhysics(),
      controller: controller ?? ScrollController(),
      itemCount: list.length + 1,
      separatorBuilder: (BuildContext context, int index) => Divider(height: 0),
      itemBuilder: (BuildContext context, int index) {
        if ((index >= list.length && !isFromUserRepositoryListPage) &&
            (peopleBloc != null || userBloc != null)) {
          print("Fetching user's repositories");
          return displayLoader ? GCLoader() : SizedBox.shrink();
        } else if (index >= list.length && isFromUserRepositoryListPage) {
          print("Fetching more repositories");
          return BlocBuilder<SearchBloc, SearchState>(
            builder: (context, state) {
              if (state is LoadingNextSearchState) return GCLoader();

              return SizedBox.shrink();
            },
          );
        }
        final repo = list[index];
        return repoCard(context, repo);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: isFromUserRepositoryListPage
          ? null
          : AppBar(title: GAppBarTitle(login: login, title: "Repositories"),),
      body: !(list != null && list.isNotEmpty) && isFromUserRepositoryListPage
          ? NoDataPage(
                title: "No repo Found",
                description: "$login haven't created any repo yet",
                icon: GIcons.github_1,
              )
          : !isFromUserRepositoryListPage
              ? peopleBloc != null
                  ? BlocBuilder<PeopleBloc, people.PeopleState>(
                      cubit: peopleBloc,
                      buildWhen: (old, newState) {
                        return (old != newState);
                      },
                      builder: (context, state) {
                        bool displayLoader = false;
                        if (state is people.LoadingNextRepositoriesState)
                          displayLoader = true;
                        if (state is people.LoadedUserState) {
                          return _repoList(state.user.repositories.nodes,
                              displayLoader: displayLoader);
                        } else {
                          return GLoader();
                        }
                      },
                    )
                  : BlocBuilder<UserBloc, UserState>(
                      cubit: userBloc,
                      buildWhen: (old, newState) {
                        return (old != newState);
                      },
                      builder: (context, state) {
                        bool displayLoader = false;
                        if (state is LoadingNextRepositoriesState)
                          displayLoader = true;
                        if (state is LoadedUserState) {
                          return _repoList(state.user.repositories.nodes,
                              displayLoader: displayLoader);
                        } else {
                          return GLoader();
                        }
                      },
                    )
              : _repoList(list),
    );
  }
}
