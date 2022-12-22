import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:server_driven_ui/adapter/http.adapter.dart';
import 'package:server_driven_ui/core/content_provider.dart';
import 'package:server_driven_ui/core/json_parser.dart';
import 'package:server_driven_ui/core/page_transition.dart';
import 'package:server_driven_ui/core/route_widget.dart';
import 'package:server_driven_ui/type/json.type.dart';

class WidgetAction {
  String type = "";
  String url = "";
  String animationType = "";
  int animationTime = 500;
  bool force = false;

  void setProperties(JSON json) {
    type = json["actionType"] ?? type;
    url = json["url"] ?? url;
    force = json["force"] ?? force;
    animationType = json["animationType"] ?? animationType;
    animationTime = json["animationTime"] ?? animationTime;
  }

  Future<dynamic> execute(BuildContext context, {JSON data = const {}}) {
    switch (type.toLowerCase()) {
      case 'route':
        return _route(context);

      case 'command':
        return _command(context, data);

      default:
        return Future.value(null);
    }
  }

  Future<void> _route(BuildContext context) async {
    if (url == '..') {
      Navigator.pop(context);
      return;
    }

    if (!url.startsWith('http://') && !url.startsWith('https://')) {
      throw Exception('Only can route url with starts http or https');
    }

    if (force) {
      Navigator.pushReplacement(
          context,
          PageRouteBuilder(
              pageBuilder: (context, animation1, animation2) =>
                  RouteWidget(provider: HTTPContentProvider(url)),
              transitionDuration: Duration(milliseconds: animationTime),
              reverseTransitionDuration: Duration(milliseconds: animationTime),
              transitionsBuilder: getPageTransition(animationType)));
    } else {
      Navigator.push(
        context,
        PageRouteBuilder(
            pageBuilder: (context, animation1, animation2) =>
                RouteWidget(provider: HTTPContentProvider(url)),
            transitionDuration: Duration(milliseconds: animationTime),
            reverseTransitionDuration: Duration(milliseconds: animationTime),
            transitionsBuilder: getPageTransition(animationType)),
      );
    }
  }

  Future<void> _command(BuildContext context, JSON data) async {
    var response = (jsonDecode(await HTTPAdapter.post(url, data: data)));
    if (response is JSON && response.isNotEmpty) {
      WidgetAction action = JSONParser.toAction(response);
      await action.execute(context);
    }
  }
}
