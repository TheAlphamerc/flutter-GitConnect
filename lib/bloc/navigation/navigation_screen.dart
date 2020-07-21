import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_github_connect/bloc/navigation/index.dart';

class NavigationScreen extends StatefulWidget {
  const NavigationScreen({
    Key key,
    @required NavigationBloc navigationBloc,
  })  : _navigationBloc = navigationBloc,
        super(key: key);

  final NavigationBloc _navigationBloc;

  @override
  NavigationScreenState createState() {
    return NavigationScreenState();
  }
}

class NavigationScreenState extends State<NavigationScreen> {
  NavigationScreenState();

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavigationBloc, NavigationState>(
        bloc: widget._navigationBloc,
        builder: (
          BuildContext context,
          NavigationState currentState,
        ) {
          
        });
  }
}
