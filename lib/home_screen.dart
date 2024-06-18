import 'package:flutter/material.dart';
import 'package:gym_tracker/exercise.dart';
import 'package:watch_it/watch_it.dart';

import 'exercise_db.dart';
import 'exercise_list.dart';

class HomeScreen extends WatchingWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    ExerciseDB db = GetIt.I<ExerciseDB>();
    db.loadExercises();
    List<Exercise> exercises = watchPropertyValue((ExerciseDB db) => db.exercises);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gym Tracker'),
      ),
      body: ExerciseList(exercises: exercises),
      floatingActionButton: FloatingActionButton(
        onPressed: () => db.insertExercise("Squat", 3, 15, 225),
        child: const Icon(Icons.add),
      ),
    );
  }
}
