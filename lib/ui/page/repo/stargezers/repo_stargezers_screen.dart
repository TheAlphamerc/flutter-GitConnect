import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_github_connect/bloc/User/User_model.dart';
import 'package:flutter_github_connect/bloc/people/index.dart';
import 'package:flutter_github_connect/ui/widgets/g_loader.dart';
import 'package:flutter_github_connect/ui/widgets/g_user_tile.dart';

class StargazersScreen extends StatelessWidget {
  const StargazersScreen({
    Key key,
    @required this.watchersList,
    this.controller,
  }) : super(key: key);

  final List<UserModel> watchersList;
  final ScrollController controller;

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: ListView.separated(
        controller: controller,
        physics: BouncingScrollPhysics(),
        itemCount: watchersList.length + 1,
        separatorBuilder: (BuildContext context, int index) =>
            SizedBox(), // Divider(height: 0),
        itemBuilder: (BuildContext context, int index) {
          if (index >= watchersList.length) {
            return BlocBuilder<PeopleBloc, PeopleState>(
              buildWhen: (oldState, newState) {
                return oldState != newState;
              },
              builder: (context, state) {
                if (state is LoadingNextStargezersState) {
                  return GCLoader();
                }
                return SizedBox.shrink();
              },
            );
          }
          return GUserTile(watchersList[index]);
        },
      ),
    );
  }
}
