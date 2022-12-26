import 'package:flutter/material.dart';
import 'package:server_driven_ui/server_driven_ui.dart';

class ScaffoldWidget extends BaseWidget {
  late BaseWidget title;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: getChildWidget(context),
        appBar: AppBar(title: title.build(context)));
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

void main() {
  WidgetRegistry.register('Scaffold', () => ScaffoldWidget());
  WidgetRegistry.register('Column', () => ColumnWidget());
  PageTransitionRegistry.register('vertical', verticalTransition);
  runApp(const MyApp());
}

String json = """
{
  "widgetName": "Scaffold",
  "properties": {
    "title": {
      "widgetName": "Text",
      "properties": {
        "data": "앱 제목",
        "fontSize": 20,
        "color": "#FFFFFF"
      }
    }
  },
  "child": {
    "widgetName": "Text",
    "properties": {
      "data": "http://localhost:60004/",
      "color": "#000000"
    }
  }
}
""";

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: RouteWidget(provider: StaticContentProvider(content: json)));
  }
}
