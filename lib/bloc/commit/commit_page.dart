import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_github_connect/bloc/commit/index.dart';
import 'package:flutter_github_connect/helper/GIcons.dart';
import 'package:flutter_github_connect/ui/page/common/no_data_page.dart';
import 'package:flutter_github_connect/ui/widgets/g_app_bar_title.dart';
import 'package:flutter_github_connect/ui/widgets/g_error_container.dart';
import 'package:flutter_github_connect/ui/widgets/g_loader.dart';

class CommitPageProvider extends StatefulWidget {
  final String name;
  final String owner;

  const CommitPageProvider({Key key, this.name, this.owner}) : super(key: key);
  static MaterialPageRoute getPageRoute({String owner, String name,int count}) => MaterialPageRoute(
        builder: (context) => BlocProvider(
          create: (BuildContext context) =>
              CommitBloc()..add(LoadCommitsEvent(name, owner, count: count)),
          child: CommitPageProvider(name: name, owner: owner),
        ),
      );

  @override
  _CommitPageProviderState createState() => _CommitPageProviderState();
}

class _CommitPageProviderState extends State<CommitPageProvider> {
  ScrollController _controller;
  @override
  void initState() {
    _controller = ScrollController()..addListener(listener);
    super.initState();
  }

  void listener() {
    if (_controller.position.pixels == _controller.position.maxScrollExtent) {
      BlocProvider.of<CommitBloc>(context).add(
        LoadCommitsEvent(widget.name, widget.owner, isLoadNextCommit: true),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(title: GAppBarTitle(title: "Commits",login: widget.name,)),
      body: BlocBuilder<CommitBloc, CommitState>(
        builder: (
          BuildContext context,
          CommitState currentState,
        ) {
          if (currentState is LoadingCommitState) {
            return GLoader();
          }
          if (currentState is ErrorCommitState) {
            return GErrorContainer(
              description: currentState.errorMessage,
              onPressed: () {
                BlocProvider.of<CommitBloc>(context)
                  ..add(
                    LoadCommitsEvent(widget.name, widget.owner,
                        isLoadNextCommit: true),
                  );
              },
            );
          }
          if (currentState is LoadedCommitState) {
            if (currentState.isNotNullEmpty)
              return CommitScreen(
                 history: currentState.history,
                controller: _controller);

            // If history list is empty then display empty list message
            return NoDataPage(
              title: "Empty commit history",
              description:
                  "No issue created yet,\n Once new history are created, they will be displayed here",
              icon: GIcons.issue_opened_24,
            );
          }
          return GLoader();
        },
      ),
    );
  }
}
