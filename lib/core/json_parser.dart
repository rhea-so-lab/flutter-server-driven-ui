import 'package:server_driven_ui/type/json.type.dart';

import 'base_widget.dart';
import 'widget_registry.dart';

class JSONParser {
  static BaseWidget toWidget(JSON json) {
    var widgetName = json["widgetName"];
    if (widgetName == null) {
      throw Exception("Empty widget name field detected");
    }

    BaseWidget? widget = WidgetRegistry.create(widgetName);
    if (widget == null) {
      throw Exception("Unsupported widget: $widgetName");
    }

    var properties = json["properties"];
    if (properties is JSON && properties.isNotEmpty) {
      widget.setProperties(properties);
    }

    var child = json["child"];
    if (child is JSON && child.isNotEmpty) {
      widget.children = [toWidget(child)];
    }

    var children = json["children"];
    if (children is List<dynamic> && children.isNotEmpty) {
      widget.children = children.map((e) => toWidget(e)).toList();
    }

    return widget;
  }
}
