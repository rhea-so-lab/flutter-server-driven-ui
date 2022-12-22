import 'package:flutter/material.dart';
import 'package:server_driven_ui/core/action.dart';
import 'package:server_driven_ui/core/content_provider.dart';
import 'package:server_driven_ui/core/json_parser.dart';
import 'package:server_driven_ui/core/page_transition_registry.dart';
import 'package:server_driven_ui/core/route_widget.dart';
import 'package:server_driven_ui/core/base_widget.dart';
import 'package:server_driven_ui/core/widget_registry.dart';
import 'package:server_driven_ui/type/json.type.dart';

class ScaffoldWidget extends BaseWidget {
  late BaseWidget title;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: getChildWidget(context),
        appBar: AppBar(
          title: title.build(context),
        ));
  }

  @override
  void setProperties(JSON json) {
    title = JSONParser.toWidget(json["title"]);
  }
}

class ColumnWidget extends BaseWidget {
  @override
  Widget build(BuildContext context) {
    return Column(children: getChildrenWidget(context));
  }

  @override
  void setProperties(JSON json) {}
}

class TextWidget extends BaseWidget {
  late String message;
  late WidgetAction onClick;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Text(message),
      onTap: () {
        onClick.execute(context, data: {'test': 'Hello, World!'});
      },
    );
  }

  @override
  void setProperties(JSON json) {
    message = json["message"] ?? "";
    onClick = JSONParser.toAction(json["onClick"]);
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

Future<void> main() async {
  WidgetRegistry.register('Scaffold', () => ScaffoldWidget());
  WidgetRegistry.register('Column', () => ColumnWidget());
  WidgetRegistry.register('Text', () => TextWidget());
  PageTransitionRegistry.register('vertical', verticalTransition);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: RouteWidget(
            provider: HTTPContentProvider('http://localhost:4001')));
  }
}
