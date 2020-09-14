import 'package:flutter/material.dart';
import 'package:flutter_github_connect/helper/GIcons.dart';
import 'package:flutter_github_connect/ui/page/common/no_data_page.dart';
import 'package:flutter_github_connect/ui/theme/export_theme.dart';

class Underdevelopment extends StatelessWidget {
  const Underdevelopment({Key key}) : super(key: key);
  static Future<Null> displayDevelopmentAlert(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          insetAnimationCurve: Curves.easeInToLinear,
          insetAnimationDuration: Duration(milliseconds: 500),
          child: Underdevelopment(),
          backgroundColor: Colors.transparent,
        );
      },
    );
  }

  static void displaySnackbar(BuildContext context,{ String msg = "Feature is under development", GlobalKey<ScaffoldState> key}) {
    final snackBar = SnackBar(content: Text(msg));
    if(key != null && key.currentState != null){
      key.currentState.hideCurrentSnackBar();
      key.currentState.showSnackBar(snackBar);
    }
    else{
       Scaffold.of(context).hideCurrentSnackBar();
       Scaffold.of(context).showSnackBar(snackBar);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * .4,
      width: MediaQuery.of(context).size.width * .8,
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      color: Theme.of(context).colorScheme.surface,
      child: NoDataPage(
        description: "This feature is currently under development",
        icon: GIcons.alert_16,
        // title: "sdsd",
      ),
    ).cornerRadius(15);
  }
}
