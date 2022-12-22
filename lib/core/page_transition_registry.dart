import 'package:flutter/widgets.dart';
import 'package:server_driven_ui/core/page_transition.dart';

class PageTransitionRegistry {
  static final Map<String, RouteTransitionsBuilder> _builders = {};

  static void register(String transitionName, RouteTransitionsBuilder builder) {
    String key = transitionName.toLowerCase();
    if (_builders.containsKey(key)) {
      return;
    }
    _builders[key] = builder;
  }

  static RouteTransitionsBuilder find(String? transitionName) {
    if (transitionName == null) {
      return horizontalTransition;
    }
    RouteTransitionsBuilder? builder = _builders[transitionName.toLowerCase()];
    if (builder == null) {
      return horizontalTransition;
    }
    return builder;
  }
}
