import 'package:flutter/material.dart';
import 'package:flutter_github_connect/ui/theme/export_theme.dart';

class GFlatButton extends StatelessWidget {
  const GFlatButton(
      {Key key,
      this.onPressed,
      this.label,
      this.isLoading,
      this.isWraped = false,
      this.isColored = true})
      : super(key: key);
  final Function onPressed;
  final String label;
  final ValueNotifier<bool> isLoading;
  final bool isWraped;
  final bool isColored;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: isWraped ? null : double.infinity,
      child: ValueListenableBuilder(
        valueListenable: isLoading ?? ValueNotifier(false),
        builder: (context, loading, child) {
          return FlatButton(
            disabledColor: GColors.disableButtonColor,
            padding: EdgeInsets.symmetric(horizontal: 16, vertical:16),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
            color: !isColored ? null : Theme.of(context).buttonColor,
            textColor: GColors.onPrimary,
            onPressed: loading ? null : onPressed,
            child: loading
                ? SizedBox(
                    height: 15,
                    width: 15,
                    child: FittedBox(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation(
                            GColors.primaryExtraDarkColor),
                      ),
                    ),
                  )
                : child,
          );
        },
        child: Text(
          label,
          style: TextStyle(fontWeight:FontWeight.bold, letterSpacing:1.2, fontSize: 18)
        ),
      ),
    );
  }
}
