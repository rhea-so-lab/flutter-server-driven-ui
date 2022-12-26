<img
  src="https://avatars.githubusercontent.com/u/100199692?s=400&u=89bb3f9a03370171391fc1f06d6fa296122a62a1"
  align="right"
  width="100" />

# Flutter Server Driven UI

> 🚀 Server Driven UI Module for Flutter. New features to be deployed on all platforms simultaneously via a backend change, without releasing new versions of the native apps.

## 🚀 Quick Start

Download the package:

```sh
flutter pub add server_driven_ui
```

Get JSON & Parsing json to widget:

```dart
void main() {
  String json = """
  {
    "widgetName": "Scaffold"
  }
  """;

  runApp(MyApp(json: json));
}

class MyApp extends StatelessWidget {
  late String json;

  MyApp({required this.json});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: RouteWidget(
        provider: StaticContentProvider(content: json),
      ),
    );
  }
}
```

Also can create and use custom widget:

```dart
class CustomWidget extends BaseWidget {
  @override
  Widget build(BuildContext context) {
    return Text("Hello, World!");
  }
}

void main() {
  // Argument = WidgetName, WidgetFactory
  WidgetRegistry.register('CustomWidget', () => CustomWidget()); // Registering your custom widget into server-driven-ui widget factory storage.

  String json = """
  {
    "widgetName": "Scaffold"
    "child": {
      "widgetName": "CustomWidget"
    }
  }
  """;

  runApp(MyApp(json: json));
}
```

## 🖼️ Architecture

Currently writing...

## 📄 Documentation

Go to [flutter-server-driven-ui GitHub Wiki](https://github.com/rhea-so-lab/flutter-server-driven-ui/wiki).

## 📄 License

flutter-server-driven-ui is [BSD-3-Clause Licensed](./LICENSE).
