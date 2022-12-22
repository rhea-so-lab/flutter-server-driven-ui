import 'package:server_driven_ui/type/json.type.dart';

import 'base_widget.dart';
import 'widget_registry.dart';

class JSONParser {
  static BaseWidget toWidget(JSON json) {
    String type = json["type"];
    BaseWidget? widget = WidgetRegistry.create(type);
    if (widget == null) {
      throw Exception("Unsupported type: $type");
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
