import 'package:flutter/material.dart';
import 'package:gym_tracker/exercise_card.dart';

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
        body: ListView(
          children: const [
            ExerciseCard(
              exerciseName: "Bench Press",
              numSets: 3,
              numReps: 15,
              weight: 135,
            ),
            ExerciseCard(
              exerciseName: "Bicep Curl",
              numSets: 3,
              numReps: 15,
              weight: 25,
            ),
          ],
        ),
      ),
    );
  }
}
