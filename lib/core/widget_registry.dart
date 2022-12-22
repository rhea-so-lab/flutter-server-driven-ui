import 'package:server_driven_ui/type/widget_factory.type.dart';

import 'base_widget.dart';

class WidgetRegistry {
  static final Map<String, WidgetFactory> _factories = {};

  static void register(String widgetName, WidgetFactory factory) {
    String key = widgetName.toLowerCase();
    if (_factories.containsKey(key)) {
      return;
    }
    _factories[key] = factory;
  }

  static BaseWidget? create(String widgetName) {
    WidgetFactory? factory = _factories[widgetName.toLowerCase()];
    return factory?.call();
  }
}
