import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_github_connect/bloc/people/index.dart';
import "package:build_context/build_context.dart";
import 'package:flutter_github_connect/helper/GIcons.dart';
import 'package:flutter_github_connect/ui/page/common/no_data_page.dart';
import 'package:flutter_github_connect/ui/page/people/people_screen.dart';
import 'package:flutter_github_connect/ui/theme/export_theme.dart';
import 'package:flutter_github_connect/ui/widgets/g_loader.dart';

class ActorPage extends StatelessWidget {
  const ActorPage({Key key,@required this.type}) : super(key: key);
  final PeopleType type;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.backgroundColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).colorScheme.surface,
        title: Title(
          title: type == PeopleType.Follower ? "Followers" : "Following",
          color: Colors.black,
          child: Text(type == PeopleType.Follower ? "Followers" : "Following", style: Theme.of(context).textTheme.headline6),
        ),
      ),
      body: BlocBuilder<PeopleBloc, PeopleState>(
        builder: (
          BuildContext context,
          PeopleState currentState,
        ) {
          return PeoplePage(peopleBloc: BlocProvider.of<PeopleBloc>(context));
        },
      ),
    );
  }
}

class PeoplePage extends StatelessWidget {
  static const String routeName = '/people';
  final PeopleBloc peopleBloc;

  const PeoplePage({Key key, this.peopleBloc}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PeopleBloc, PeopleState>(
      cubit: peopleBloc,
      builder: (
        BuildContext context,
        PeopleState currentState,
      ) {
        if (currentState is ErrorPeopleState) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(currentState.errorMessage ?? 'Error'),
                Padding(
                  padding: const EdgeInsets.only(top: 32.0),
                  child: RaisedButton(
                    color: Colors.blue,
                    child: Text('reload'),
                    onPressed: _load,
                  ),
                ),
              ],
            ),
          );
        }
        if (currentState is LoadingFollowersState) {
          return GLoader();
        } else if (currentState is LoadedFollowersState) {
          if (currentState.followers != null &&
              currentState.followers.nodes.isNotEmpty) {
            return PeopleScreen(
              followers: currentState.followers.nodes,
            );
          } else {
            return Column(
                children: <Widget>[
                  NoDataPage(
                    title: "No Followers",
                    description: "No followers found!!",
                    icon: GIcons.github_1,
                  ),
                ],
              );
          }
        } else if (currentState is LoadedFollowingState) {
          if (currentState.following != null &&
              currentState.following.nodes.isNotEmpty) {
            return PeopleScreen(
              followers: currentState.following.nodes,
            );
          } else {
            return Column(
                children: <Widget>[
                  NoDataPage(
                    title: "Following",
                    description: "No Following user found!!",
                    icon: GIcons.github_1,
                  ),
                ],
              );
          }
        }
        return GLoader();
      },
    );
  }

  void _load() {
    // peopleBloc.add(LoadPeopleEvent());
  }
}
