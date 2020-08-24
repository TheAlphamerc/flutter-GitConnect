import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class GitContributionGraph extends StatefulWidget {
  final String login;
  GitContributionGraph({Key key, this.login}) : super(key: key);

  @override
  _GitContributionGraphState createState() => _GitContributionGraphState();
}

class _GitContributionGraphState extends State<GitContributionGraph>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  Animation<double> _shimmerAnimation;
  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 3000),
      upperBound: 1,
      lowerBound: 0,
    )..addStatusListener(_statusListener);
    _animationController.forward();

    _shimmerAnimation = new Tween(
      begin: 0.0,
      end: 1.0,
    ).animate(
      new CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInToLinear,
      ),
    );
  }

  void _statusListener(AnimationStatus status) {
    if (status == AnimationStatus.completed) {
      _animationController.reverse();
    } else if (status == AnimationStatus.dismissed) {
      _animationController.forward();
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SvgPicture.network(
      "https://ghchart.rshah.org/${widget.login}",
      height: 100,
      fit: BoxFit.fitHeight,
      allowDrawingOutsideViewBox: true,
      placeholderBuilder: (context) {
        return AnimatedBuilder(
          animation: _shimmerAnimation,
          builder: (context, child) {
            return Container(
              height: 100,
              width: MediaQuery.of(context).size.width - 30,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Theme.of(context).cardColor,
                gradient: LinearGradient(
                    colors: [
                      Theme.of(context).colorScheme.surface,
                      Theme.of(context).cardColor,
                      Theme.of(context).colorScheme.surface,
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    stops: [0, _shimmerAnimation.value, 1]),
              ),
            );
          },
        );
      },
    );
  }
}
