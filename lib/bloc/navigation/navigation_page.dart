import 'package:flutter/material.dart';
import 'package:flutter_github_connect/bloc/navigation/index.dart';

class NavigationPage extends StatefulWidget {
  static const String routeName = '/navigation';

  @override
  _NavigationPageState createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage> {
  final _navigationBloc = NavigationBloc();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Navigation'),
      ),
      body: NavigationScreen(navigationBloc: _navigationBloc),
    );
  }
}
