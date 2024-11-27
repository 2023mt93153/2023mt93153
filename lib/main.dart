import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quicktask/screens/task_list_screen.dart';  // Ensure this import is correct
import 'screens/auth_screen.dart';
import 'providers/task_provider.dart';  // Import your TaskProvider class

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => TaskProvider()),  // Register TaskProvider here
      ],
      child: QuickTaskApp(),
    ),
  );
}

class QuickTaskApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'QuickTask',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',  // Define the initial route
      routes: {
        '/': (ctx) => AuthScreen(),  // Auth screen as the home route
        '/tasks': (ctx) => TaskListScreen(),  // Tasks list screen route
      },
    );
  }
}
