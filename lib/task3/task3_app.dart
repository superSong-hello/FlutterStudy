
import 'package:flutter/material.dart';
import 'package:flutter_study/task3/time_out.dart';
class Task3App extends StatelessWidget {
  const Task3App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Task3 Time out',
      theme: ThemeData(
        useMaterial3: true,
        primarySwatch: Colors.red
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Task3 Time out"),
        ),
        body: const TimeOut(),
      ),
    );
  }
}
