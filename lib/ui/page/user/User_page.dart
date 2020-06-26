import 'package:flutter/material.dart';
import 'package:flutter_github_connect/bloc/User/index.dart';
import 'package:flutter_github_connect/ui/page/user/User_screen.dart';

class UserPage extends StatefulWidget {
  static const String routeName = '/user';

  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  final _userBloc = UserBloc();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User'),
      ),
      body: UserScreen(userBloc: _userBloc),
    );
  }
}
