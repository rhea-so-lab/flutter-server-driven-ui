import 'package:server_driven_ui/type/json.type.dart';

import 'action.dart';
import 'base_widget.dart';
import 'widget_registry.dart';

class JSONParser {
  static BaseWidget toWidget(JSON json) {
    BaseWidget widget = WidgetRegistry.create(json["widgetName"]);

    var properties = json["properties"];
    if (properties is JSON && properties.isNotEmpty) {
      widget.setProperties(properties);
    } else {
      widget.setProperties({});
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

  static WidgetAction toAction(JSON? json) {
    if (json == null) {
      return WidgetAction();
    }

    var actionType = json["actionType"];
    if (actionType == null) {
      throw Exception("Empty action type field detected");
    }
    WidgetAction action = WidgetAction();
    action.setProperties(json);
    return action;
  }
}
