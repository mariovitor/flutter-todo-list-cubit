import 'package:flutter/material.dart';
import 'package:todo_list_cubit/src/presentation/pages/home_page.dart';

Route<dynamic> onGenerateRoute(RouteSettings settings) {
  final widget = switch (settings.name) {
    HomePage.route => const HomePage(),
    _ => null,
  };
  if (widget is! Widget) return onUnknownRoute(settings);
  return MaterialPageRoute(
    settings: settings,
    builder: (context) {
      return widget!;
    },
  );
}

Route<dynamic> onUnknownRoute(RouteSettings settings) {
  return MaterialPageRoute(
    settings: settings,
    builder: (context) {
      return const Scaffold(
        body: Center(
          child: Text('Rota desconhecida'),
        ),
      );
    },
  );
}
