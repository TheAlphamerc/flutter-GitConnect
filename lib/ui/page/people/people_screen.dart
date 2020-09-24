import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_github_connect/bloc/people/index.dart';
import 'package:flutter_github_connect/ui/widgets/g_loader.dart';
import 'package:flutter_github_connect/ui/widgets/g_user_tile.dart';

class PeopleScreen extends StatelessWidget {
  const PeopleScreen({
    Key key,
    @required List<Node> followers, this.controller,
  })  : _followers = followers,
        super(key: key);

  final List<Node> _followers;
  final ScrollController controller;

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: ListView.separated(
        controller: controller,
        physics: BouncingScrollPhysics(),
        itemCount: _followers.length + 1,
        separatorBuilder: (BuildContext context, int index) =>
            SizedBox(),// Divider(height: 0),
        itemBuilder: (BuildContext context, int index) {
          if(index >= _followers.length){
            return BlocBuilder<PeopleBloc, PeopleState>(
              buildWhen: (oldState, newState) {
                return oldState != newState;
              },
              builder: (context, state) {
                if(state is LoadingNextFollowState){
                  return GCLoader();
                }
                return SizedBox.shrink();
              },
            );
          }
          return GUserTile(_followers[index].toUserModel());
        },
      ),
    );
  }
}
