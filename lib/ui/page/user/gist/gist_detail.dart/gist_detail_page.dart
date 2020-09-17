import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_github_connect/bloc/gist/gist_bloc.dart';
import 'package:flutter_github_connect/ui/page/user/gist/gist_detail.dart/gist_detail_scree.dart';
import 'package:flutter_github_connect/ui/widgets/g_app_bar_title.dart';
import 'package:flutter_github_connect/ui/widgets/g_error_container.dart';
import 'package:flutter_github_connect/ui/widgets/g_loader.dart';

class GistDetailPage extends StatelessWidget {
  final String id;
  const GistDetailPage({Key key, this.id}) : super(key: key);
  static MaterialPageRoute getPageRoute(
    BuildContext context, {
    String id,
  }) {
    return MaterialPageRoute(
      builder: (context) {
        return BlocProvider<GistBloc>(
          create: (BuildContext context) =>
              GistBloc()..add(LoadGistDetailEvent(id)),
          child: GistDetailPage(id: id),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        elevation: 0,
        title: GAppBarTitle(login: id, title: "Gists Detail"),
        bottom: PreferredSize(
          child: Divider(
            height: 0,
          ),
          preferredSize: Size(MediaQuery.of(context).size.width, 0),
        ),
      ),
      body: BlocBuilder<GistBloc, GistState>(
        builder: (
          BuildContext context,
          GistState currentState,
        ) {
          if (currentState is ErrorGistDetailState) {
            return GErrorContainer(
              description: currentState.errorMessage,
              onPressed: () {
                BlocProvider.of<GistBloc>(context)
                  ..add(LoadGistDetailEvent(id));
              },
            );
          }
          if (currentState is LoadedGistDetailState) {
            if (currentState.model != null)
              return GistDetailScreen(
                model: currentState.model,
              );
          }
          return GLoader();
        },
      ),
    );
  }
}
