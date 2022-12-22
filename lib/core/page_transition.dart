import 'package:flutter/widgets.dart';

RouteTransitionsBuilder getPageTransition(String animationType) {
  switch (animationType) {
    case 'vertical':
      return verticalTransition;

    default:
      return horizontalTransition;
  }
}

AnimatedWidget verticalTransition(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child) {
  var begin = Offset(0.0, 1.0);
  var end = Offset.zero;
  var curve = Curves.ease;
  var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
  return SlideTransition(
    position: animation.drive(tween),
    child: child,
  );
}

AnimatedWidget horizontalTransition(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child) {
  var begin = Offset(1.0, 0.0);
  var end = Offset.zero;
  var curve = Curves.ease;
  var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
  return SlideTransition(
    position: animation.drive(tween),
    child: child,
  );
}
