import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_github_connect/bloc/people/index.dart';
import "package:build_context/build_context.dart";
import 'package:flutter_github_connect/helper/GIcons.dart';
import 'package:flutter_github_connect/ui/page/common/no_data_page.dart';
import 'package:flutter_github_connect/ui/page/people/people_screen.dart';
import 'package:flutter_github_connect/ui/widgets/g_error_container.dart';
import 'package:flutter_github_connect/ui/widgets/g_loader.dart';

class ActorPage extends StatefulWidget {
  static MaterialPageRoute getPageRoute(String login, PeopleType type) {
    return MaterialPageRoute(
      builder: (context) {
        return BlocProvider<PeopleBloc>(
          create: (BuildContext context) =>
              PeopleBloc()..add(LoadFollowEvent(login, type)),
          child: ActorPage(type: type, login: login),
        );
      },
    );
  }

  const ActorPage({Key key, @required this.type, this.login}) : super(key: key);
  final PeopleType type;
  final String login;

  @override
  _ActorPageState createState() => _ActorPageState();
}

class _ActorPageState extends State<ActorPage> {
  ScrollController _controller;

  @override
  void initState() {
    _controller = ScrollController()..addListener(listener);
    super.initState();
  }

  void listener() {
    if (_controller.position.pixels == _controller.position.maxScrollExtent) {
      BlocProvider.of<PeopleBloc>(context).add(
          LoadFollowEvent(widget.login, widget.type, isLoadNextFollow: true));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.backgroundColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).colorScheme.surface,
        title: Title(
          title: widget.type.asString(),
          color: Colors.black,
          child: Text(widget.type.asString(),
              style: Theme.of(context).textTheme.headline6),
        ),
      ),
      body: BlocBuilder<PeopleBloc, PeopleState>(
        builder: (
          BuildContext context,
          PeopleState currentState,
        ) {
          return PeoplePage(
              login: widget.login,
              peopleBloc: BlocProvider.of<PeopleBloc>(context),
              type: widget.type,
              controller: _controller);
        },
      ),
    );
  }
}

class PeoplePage extends StatelessWidget {
  static const String routeName = '/people';
  final PeopleBloc peopleBloc;
  final PeopleType type;
  final ScrollController controller;
  final String login;

  const PeoplePage(
      {Key key, this.peopleBloc, this.type, this.controller, this.login})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PeopleBloc, PeopleState>(
      cubit: peopleBloc,
      builder: (
        BuildContext context,
        PeopleState currentState,
      ) {
        if (currentState is ErrorPeopleState) {
          return GErrorContainer(
            description: currentState.errorMessage,
            onPressed: () {
              BlocProvider.of<PeopleBloc>(context)
                ..add(LoadFollowEvent(login, type));
            },
          );
        }
        if (currentState is LoadingFollowState) {
          return GLoader();
        } else if (currentState is LoadedFollowState) {
          if (currentState.followModel != null &&
              currentState.followModel.nodes.isNotEmpty) {
            return PeopleScreen(
                followers: currentState.followModel.nodes,
                controller: controller);
          } else {
            return Column(
              children: <Widget>[
                NoDataPage(
                  title: "No ${type.asString().toLowerCase()}",
                  description: "Getting empty data here",
                  icon: GIcons.github,
                ),
              ],
            );
          }
        }

        return GLoader();
      },
    );
  }
}
