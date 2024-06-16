import 'package:flutter/material.dart';

void main() {
  runApp(const GymTracker());
}

class GymTracker extends StatelessWidget {
  const GymTracker({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gym Tracker',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.blue),
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Gym Tracker'),
        ),
        body: const Center(
          child: Text('Welcome to Gym Tracker!'),
        ),
      ),
    );
  }
}
