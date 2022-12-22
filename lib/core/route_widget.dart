// ignore_for_file: library_private_types_in_public_api, no_logic_in_create_state

import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:server_driven_ui/type/json.type.dart';

import 'content_provider.dart';
import 'json_parser.dart';

class RouteWidget extends StatefulWidget {
  final ContentProvider provider;
  const RouteWidget({super.key, required this.provider});
  @override
  _RouteWidgetState createState() => _RouteWidgetState(provider: provider);
}

class _RouteWidgetState extends State<RouteWidget> {
  ContentProvider provider;
  late Future<String> content;

  _RouteWidgetState({required this.provider});

  @override
  void initState() {
    content = provider.getContent();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: content,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          throw Exception(snapshot.error.toString());
        }
        if (!snapshot.hasData) {
          return SizedBox(); // Loading
        }
        JSON json = jsonDecode(snapshot.data!);
        return (JSONParser.toWidget(json)).build(context);
      },
    );
  }
}
