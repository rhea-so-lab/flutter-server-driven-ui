import 'package:flutter/widgets.dart';
import 'package:server_driven_ui/type/json.type.dart';

abstract class BaseWidget {
  List<BaseWidget> children = <BaseWidget>[];
  bool hasChildren() => children.isNotEmpty;
  BaseWidget? getChild() => children.isEmpty ? null : children.first;
  Widget? getChildWidget(BuildContext context) =>
      children.isEmpty ? null : children.first.build(context);
  List<BaseWidget> getChildren() => children;
  List<Widget> getChildrenWidget(BuildContext context) =>
      children.map((e) => e.build(context)).toList();
  void setProperties(JSON json) {}
  Widget build(BuildContext context);
}
