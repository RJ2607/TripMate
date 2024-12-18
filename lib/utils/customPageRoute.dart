import 'package:flutter/material.dart';

class CustomPageRoute extends PageRouteBuilder {
  final Widget child;
  AxisDirection direction;
  String transitionType;
  final RouteSettings settings;

  CustomPageRoute({
    required this.child,
    this.direction = AxisDirection.right,
    required this.transitionType,
    required this.settings,
  }) : super(
          transitionDuration: const Duration(milliseconds: 500),
          pageBuilder: (context, animation, secondaryAnimation) => child,
          settings: settings,
        );

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    if (transitionType == 'slide') {
      return SlideTransition(
        position: Tween<Offset>(
          begin: getOffSet(direction),
          end: Offset.zero,
        ).animate(animation),
        child: child,
      );
    } else if (transitionType == 'fade') {
      return FadeTransition(
        opacity: animation,
        child: child,
      );
    } else {
      return ScaleTransition(
        scale: Tween<double>(
          begin: 0,
          end: 1,
        ).animate(animation),
        child: child,
      );
    }
  }

  getOffSet(AxisDirection direction) {
    switch (direction) {
      case AxisDirection.up:
        return Offset(0, 1);
      case AxisDirection.down:
        return Offset(0, -1);
      case AxisDirection.left:
        return Offset(1, 0);
      case AxisDirection.right:
        return Offset(-1, 0);
      default:
        return Offset(1, 0);
    }
  }
}
