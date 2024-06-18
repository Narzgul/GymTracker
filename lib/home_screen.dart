import 'package:flutter/material.dart';
import 'package:gym_tracker/exercise.dart';
import 'package:watch_it/watch_it.dart';

import 'exercise_db.dart';
import 'exercise_list.dart';
import 'new_exercise_screen.dart';

class HomeScreen extends WatchingWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    GetIt.I<ExerciseDB>().loadExercises();
    List<Exercise> exercises =
        watchPropertyValue((ExerciseDB db) => db.exercises);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gym Tracker'),
      ),
      body: ExerciseList(exercises: exercises),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const NewExerciseScreen(),
          ),
        ),
        child: const Icon(Icons.add),
      ),
    );
  }
}
