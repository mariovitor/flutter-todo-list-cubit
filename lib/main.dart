import 'package:flutter/material.dart';
import 'package:todo_list_cubit/src/core/core.dart';
import 'package:todo_list_cubit/src/presentation/home/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Locator.init();
  runApp(const TaskApp());
}

class TaskApp extends StatelessWidget {
  const TaskApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Task App',
      theme: ThemeData(colorSchemeSeed: Colors.blue),
      debugShowCheckedModeBanner: false,
      onGenerateRoute: onGenerateRoute,
      onUnknownRoute: onUnknownRoute,
      initialRoute: HomePage.route,
    );
  }
}
