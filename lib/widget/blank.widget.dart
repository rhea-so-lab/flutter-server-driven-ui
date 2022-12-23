import 'package:flutter/widgets.dart';

import '../core/base_widget.dart';

class BlankWidget extends BaseWidget {
  @override
  Widget build(BuildContext context) {
    return Container(color: Color.fromRGBO(255, 0, 0, 1.0));
  }
}
