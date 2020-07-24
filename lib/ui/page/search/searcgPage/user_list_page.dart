import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_github_connect/bloc/search/index.dart';
import 'package:flutter_github_connect/bloc/search/model/search_userModel.dart';
import 'package:flutter_github_connect/helper/GIcons.dart';
import 'package:flutter_github_connect/ui/widgets/custom_text.dart';
import 'package:flutter_github_connect/ui/widgets/user_image.dart';
import 'package:flutter_github_connect/ui/theme/export_theme.dart';

class UserListPage extends StatelessWidget {
  const UserListPage({Key key}) : super(key: key);
  Widget userTile(context, SearchUser user) {
    return Container(
      color: Theme.of(context).colorScheme.surface,
      child: ListTile(
        leading: SizedBox(
          width: 50,
          child: UserAvatar(
            height: 50,
            imagePath: user.avatarUrl,
          ),
        ),
        title: KText(user.name ?? "N/A").pB(5),
        subtitle: KText(
          user.login,
          isSubtitle: true,
        ).pT(5),
      ),
    );
  }

  Widget _noContant(context) {
    return Container(
      alignment: Alignment.center,
      height: MediaQuery.of(context).size.height - 280,
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          // Image.asset(GImages.githubMarkLight120, width:160),
          Icon(GIcons.github_1, size: 120),
          SizedBox(height: 16),
          KText(
            "No user found",
            variant: TypographyVariant.title,
          ),
          SizedBox(height: 8),
          KText("Try again with different username",
              textAlign: TextAlign.center,
              variant: TypographyVariant.h3,
              style: TextStyle(letterSpacing: 1, height: 1.1)),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).colorScheme.surface,
        title: KText("People"),
      ),
      body: BlocBuilder<SearchBloc, SearchState>(
        builder: (
          BuildContext context,
          SearchState state,
        ) {
          if (state is LoadingSearchState) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is LoadedSearchState) {
            List<SearchUser> list = state.toUSerList();

            /// If user list is null
            if (list == null) {
              return Center(child: KText("Errror in Parsing json"));
            }

            /// If No user found with search text
            else if (list.isEmpty) {
              return _noContant(context);
            }

            /// If user list is not empty
            return ListView.separated(
              itemCount: list.length,
              separatorBuilder: (BuildContext context, int index) =>
                  Divider(height: 0),
              itemBuilder: (BuildContext context, int index) {
                return userTile(context, list[index]);
              },
            );
          }

          /// If some error occured
          else {
            return Center(child: Text("Unknown Error"));
          }
        },
      ),
    );
  }
}
