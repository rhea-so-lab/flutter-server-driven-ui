import 'package:server_driven_ui/type/widget_factory.type.dart';

import 'base_widget.dart';
import '../widget/dynamic.widget.dart';
import '../widget/blank.widget.dart';

class WidgetRegistry {
  static final Map<String, WidgetFactory> _factories = {
    'Blank'.toLowerCase(): () => BlankWidget(),
    'Dynamic'.toLowerCase(): () => DynamicWidget()
  };

  static void register(String widgetName, WidgetFactory factory) {
    String key = widgetName.toLowerCase();
    if (_factories.containsKey(key)) {
      return;
    }
    _factories[key] = factory;
  }

  static BaseWidget create(String? widgetName) {
    if (widgetName == null) {
      return BlankWidget();
    }
    WidgetFactory? factory = _factories[widgetName.toLowerCase()];
    BaseWidget? widget = factory?.call();
    if (widget == null) {
      return BlankWidget();
    }
    return widget;
  }
}
