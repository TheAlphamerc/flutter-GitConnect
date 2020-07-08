import 'package:flutter/material.dart';
import 'package:flutter_github_connect/bloc/User/User_model.dart';

class UserScreen extends StatelessWidget {
  final UserModel model;

  const UserScreen({Key key, this.model}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          model?.name ?? "Profile page",
        ),
      ),
    );
  }
}
