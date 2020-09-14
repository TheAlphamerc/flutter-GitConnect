import 'package:flutter/material.dart';
import 'package:flutter_github_connect/helper/GIcons.dart';
import 'package:flutter_github_connect/ui/widgets/flat_button.dart';

class GErrorContainer extends StatelessWidget {
  const GErrorContainer({Key key, this.onPressed,this.description,this.icon = GIcons.github_1, this.title = "Seems like into trouble"}) : super(key: key);
  final GestureTapCallback onPressed;
  final IconData icon;
  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            alignment: Alignment.center,
            height: MediaQuery.of(context).size.height - 280,
            width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(icon, size: 120),
                SizedBox(height: 16),
                Text(
                  title,
                  style: Theme.of(context).textTheme.headline5,
                ),
                SizedBox(height: 8),
                Text(
                  description,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                SizedBox(
                  height: 24,
                ),
                GFlatButton(
                  isLoading: ValueNotifier(false),
                  label: "Reload",
                  onPressed: onPressed ?? () {},
                  isWraped: true,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
