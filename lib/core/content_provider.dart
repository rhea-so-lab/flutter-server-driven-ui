import 'package:server_driven_ui/adapter/http.adapter.dart';
import 'package:server_driven_ui/type/json.type.dart';

abstract class ContentProvider {
  Future<String> getContent();
}

class HTTPContentProvider extends ContentProvider {
  final String url;
  final JSON data;

  HTTPContentProvider({required this.url, this.data = const {}});

  @override
  Future<String> getContent() async {
    return HTTPAdapter.post(url, data: data);
  }
}

class StaticContentProvider extends ContentProvider {
  final String content;

  StaticContentProvider({required this.content});

  @override
  Future<String> getContent() async {
    return content;
  }
}
