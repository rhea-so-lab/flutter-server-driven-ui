import 'package:server_driven_ui/adapter/http.adapter.dart';
import 'package:server_driven_ui/type/json.type.dart';

abstract class ContentProvider {
  Future<String> getContent();
}

class HTTPContentProvider extends ContentProvider {
  final String _url;
  final JSON data;

  HTTPContentProvider(this._url, {this.data = const {}});

  @override
  Future<String> getContent() async {
    return HTTPAdapter.post(_url, data: data);
  }
}
