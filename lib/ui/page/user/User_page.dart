import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_github_connect/bloc/User/index.dart';
import 'package:flutter_github_connect/ui/page/user/User_screen.dart';

// class UserPageProvider extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider<UserBloc>(
//       create: (context) {
//         return UserBloc()..add(OnLoad());
//       },
//       child: UserPage(),
//     );
//   }
// }

class UserPage extends StatefulWidget {
  // static route() => MaterialPageRoute(
  //       builder: (context) => UserPageProvider(),
  //     );

  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  @override
  void initState() {
    print("Init Profile page");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print("User Page build");
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        title: Text("Profile"),
      ),
      body: BlocBuilder<UserBloc, UserState>(
        // bloc: widget._userBloc,
        builder: (
          BuildContext context,
          UserState currentState,
        ) {
          if (currentState is ErrorUserState) {
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
                      onPressed: () {},
                    ),
                  ),
                ],
              ),
            );
          }
          if (currentState is LoadedUserState) {
            return UserScreen(
              model: currentState.user,
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
