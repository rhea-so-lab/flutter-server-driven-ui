import 'package:flutter/widgets.dart';

import '../core/base_widget.dart';
import '../type/json.type.dart';

class TextWidget extends BaseWidget {
  late String data;
  late Color color;
  late int fontSize;

  @override
  void setProperties(JSON json) {
    data = json["data"] ?? "";
    color = Color(
        int.parse((json["color"] ?? "#000000").substring(1, 7), radix: 16) +
            0xFF000000);
    fontSize = json["fontSize"] ?? 12;
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      style: TextStyle(fontSize: double.tryParse("$fontSize"), color: color),
    );
  }
}
