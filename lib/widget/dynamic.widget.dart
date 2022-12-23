import 'package:flutter/widgets.dart';
import 'package:server_driven_ui/core/content_provider.dart';
import 'package:server_driven_ui/core/route_widget.dart';
import 'package:server_driven_ui/type/json.type.dart';

import '../core/base_widget.dart';

class DynamicWidget extends BaseWidget {
  late String url;
  late JSON data;

  @override
  void setProperties(JSON json) {
    url = json["url"] ?? "";
    data = json["data"] ?? {};
  }

  @override
  Widget build(BuildContext context) {
    return RouteWidget(provider: HTTPContentProvider(url, data: data));
  }
}
