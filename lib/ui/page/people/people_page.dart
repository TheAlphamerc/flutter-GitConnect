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
  static MaterialPageRoute getPageRoute(String login, PeopleType type) {
    return MaterialPageRoute(
      builder: (context) {
        return BlocProvider<PeopleBloc>(
          create: (BuildContext context) =>
              PeopleBloc()..add(LoadFollowEvent(login, type)),
          child: ActorPage(type: type),
        );
      },
    );
  }

  const ActorPage({Key key, @required this.type}) : super(key: key);
  final PeopleType type;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.backgroundColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).colorScheme.surface,
        title: Title(
          title: type.asString(),
          color: Colors.black,
          child: Text(type.asString(),
              style: Theme.of(context).textTheme.headline6),
        ),
      ),
      body: BlocBuilder<PeopleBloc, PeopleState>(
        builder: (
          BuildContext context,
          PeopleState currentState,
        ) {
          return PeoplePage(
              peopleBloc: BlocProvider.of<PeopleBloc>(context), type: type);
        },
      ),
    );
  }
}

class PeoplePage extends StatelessWidget {
  static const String routeName = '/people';
  final PeopleBloc peopleBloc;
  final PeopleType type;

  const PeoplePage({Key key, this.peopleBloc, this.type}) : super(key: key);
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
        if (currentState is LoadingFollowState) {
          return GLoader();
        } else if (currentState is LoadedFollowState) {
          if (currentState.followers != null &&
              currentState.followers.nodes.isNotEmpty) {
            return PeopleScreen(
              followers: currentState.followers.nodes,
            );
          } else {
            return Column(
              children: <Widget>[
                NoDataPage(
                  title: "No ${type.asString().toLowerCase()}",
                  description: "No ${type.asString().toLowerCase()} found!!",
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
