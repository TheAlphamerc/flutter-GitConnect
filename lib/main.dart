import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_github_connect/app_delegate.dart';
import 'package:flutter_github_connect/locator.dart';
import 'package:flutter_github_connect/ui/page/auth/auth_page.dart';


void main() {
  BlocSupervisor.delegate = AppBlocDelegate();
  setUpDependency();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: RaisedButton(
          onPressed: () async {
            await Navigator.push(context, AuthPage.route());
            // Navigator.push(context, MaterialPageRoute(builder: (context) => AuthPage()));
            // if(status ?? false){
            //     Navigator.pushReplacement(context, UserPage.route());
            // }
          },
          child: Text("Login"),
        ),
      ),
    );
  }
}
