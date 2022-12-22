import 'package:server_driven_ui/type/widget_factory.type.dart';

import 'base_widget.dart';

class WidgetRegistry {
  static final Map<String, WidgetFactory> _factories = {};

  static void register(String type, WidgetFactory factory) {
    String key = type.toLowerCase();
    if (_factories.containsKey(key)) {
      return;
    }
    _factories[key] = factory;
  }

  static BaseWidget? create(String type) {
    WidgetFactory? factory = _factories[type.toLowerCase()];
    return factory?.call();
  }
}
