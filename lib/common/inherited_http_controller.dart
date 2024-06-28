import 'package:flutter/material.dart';
import 'package:wherehome/common/controllers/http_controller.dart';

class HttpControllerInherited extends InheritedWidget {
  const HttpControllerInherited({
    super.key,
    required super.child,
    required this.api,
  });

  final HttpController api;

  static HttpControllerInherited of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<HttpControllerInherited>()!;
  }

  @override
  bool updateShouldNotify(HttpControllerInherited oldWidget) {
    return oldWidget.api != api;
  }
}
