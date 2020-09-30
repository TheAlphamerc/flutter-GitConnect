import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_github_connect/bloc/User/index.dart';
import 'package:flutter_github_connect/bloc/favourite/index.dart';
import 'package:flutter_github_connect/bloc/people/index.dart' as people;
import 'package:flutter_github_connect/bloc/search/index.dart';
import 'package:flutter_github_connect/bloc/search/search_bloc.dart';
import 'package:flutter_github_connect/helper/GIcons.dart';
import 'package:flutter_github_connect/resources/service/db_service/db_service.dart';
import 'package:flutter_github_connect/ui/widgets/g_app_bar_title.dart';
import 'package:flutter_github_connect/ui/widgets/g_loader.dart';
import 'package:flutter_github_connect/ui/widgets/user_image.dart';
import 'package:flutter_github_connect/ui/theme/export_theme.dart';
import 'package:get_it/get_it.dart';

class SelectFavouriteRepoPage extends StatelessWidget {
  const SelectFavouriteRepoPage(
      {Key key,
      this.list,
      this.userBloc,
      this.peopleBloc,
      this.controller,
      this.login,
      this.favBloc})
      : super(key: key);
  final List<RepositoriesNode> list;
  final UserBloc userBloc;
  final people.PeopleBloc peopleBloc;
  final ScrollController controller;
  final String login;
  final FavouriteBloc favBloc;
  
  static MaterialPageRoute getPageRoute(BuildContext context,
      {ScrollController controller, String login}) {
    return MaterialPageRoute(
      builder: (_) => SelectFavouriteRepoPage(
          controller: controller,
          userBloc: BlocProvider.of<UserBloc>(context),
          login: login,
          favBloc: BlocProvider.of<FavouriteBloc>(context)),
    );
  }

  Widget repoCard(context, RepositoriesNode repo) {
    final isMarkedAsFav = GetIt.instance.get<DbService>().isAvailableinFavRepos(repo);
    return Container(
      color: Theme.of(context).colorScheme.surface,
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              UserAvatar(
                height: 45,
                subtitle: repo.name.takeOnly(25),
                name: repo.owner.login,
                imagePath: repo.owner.avatarUrl,
                titleStyle: Theme.of(context).textTheme.subtitle1,
                subTitleStyle: Theme.of(context).textTheme.bodyText1,
              ),
              Spacer(),
              Icon(isMarkedAsFav ? GIcons.x_circle_24 : GIcons.plus_circle_24, color:isMarkedAsFav ? GColors.red : GColors.blue)
            ],
          ),
        ],
      ),
    ).ripple(() {
      favBloc..add(AddRepotoFavouriteEvent(repo));
    });
  }

  Widget _repoList(List<RepositoriesNode> list, {bool displayLoader = false}) {
    return ListView.separated(
      physics: BouncingScrollPhysics(),
      controller: controller ?? ScrollController(),
      itemCount: list.length + 1,
      separatorBuilder: (BuildContext context, int index) => Divider(height: 0),
      itemBuilder: (BuildContext context, int index) {
        if ((index >= list.length) &&
            (peopleBloc != null || userBloc != null)) {
          print("Fetching user's repositories");
          return displayLoader ? GCLoader() : SizedBox.shrink();
        } else if (index >= list.length) {
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
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        title: GAppBarTitle(login: login, title: "Add to favourite"),
      ),
      body: BlocBuilder<UserBloc, UserState>(
        cubit: userBloc,
        buildWhen: (old, newState) {
          return (old != newState);
        },
        builder: (context, state) {
          bool displayLoader = false;
          if (state is LoadingNextRepositoriesState) displayLoader = true;
          if (state is LoadedUserState) {
            return _repoList(state.user.repositories.nodes,
                displayLoader: displayLoader);
          } else {
            return GLoader();
          }
        },
      ),
    );
  }
}
