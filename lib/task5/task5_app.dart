import 'package:flutter/material.dart';
import 'package:flutter_study/task5/sreach_screen.dart';

class Task5App extends StatelessWidget {
  const Task5App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Task5 List  Go',
      theme: ThemeData(
        useMaterial3: true,
        primarySwatch: Colors.blue
      ),
      home: const SreachScreen(),
    );
  }
}
