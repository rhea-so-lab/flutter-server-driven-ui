import 'package:flutter/widgets.dart';

import '../core/base_widget.dart';

class BlankWidget extends BaseWidget {
  String reason;

  BlankWidget({this.reason = ""});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromRGBO(255, 0, 0, 1.0),
      child: Text(
        reason,
        style: TextStyle(color: Color.fromRGBO(255, 255, 255, 1.0)),
      ),
    );
  }
}
