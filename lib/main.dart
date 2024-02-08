import 'package:flutter/material.dart';
import 'package:todo_list_cubit/src/core/routes.dart';
import 'package:todo_list_cubit/src/presentation/pages/home_page.dart';

void main() {
  runApp(const TaskApp());
}

class TaskApp extends StatelessWidget {
  const TaskApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Task App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      onGenerateRoute: onGenerateRoute,
      onUnknownRoute: onUnknownRoute,
      initialRoute: HomePage.route,
    );
  }
}
