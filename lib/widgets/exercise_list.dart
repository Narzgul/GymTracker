import 'package:flutter/material.dart';

import '../exercise.dart';
import 'exercise_card.dart';

class ExerciseList extends StatelessWidget {
  final List<Exercise> exercises;

  const ExerciseList({super.key, required this.exercises});

  @override
  Widget build(BuildContext context) {
    // If there are no exercises, display a message
    if (exercises.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'No exercises',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const Text(
              'Add an exercise using the button below to get started',
            ),
          ],
        ),
      );
    }

    // If there are exercises, display them in a list
    return ListView.builder(
      itemCount: exercises.length,
      itemBuilder: (BuildContext context, int index) =>
          ExerciseCard(exercise: exercises[index]),
    );
  }
}
