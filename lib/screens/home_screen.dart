import 'package:flutter/material.dart';
import 'package:gym_tracker/exercise.dart';
import 'package:gym_tracker/main.dart';
import 'package:watch_it/watch_it.dart';

import '../exercise_db.dart';
import '../widgets/exercise_list.dart';
import 'navigable_screen.dart';
import 'sub_screens/new_exercise_screen.dart';

class HomeScreen extends WatchingWidget implements NavigableScreen {
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
    );
  }

  @override
  final String title = 'Gym Tracker';

  @override
  FloatingActionButton? get floatingActionButton => FloatingActionButton(
        onPressed: () => navigatorKey.currentState?.push(
          MaterialPageRoute(
            builder: (context) => const NewExerciseScreen(),
          ),
        ),
        child: const Icon(Icons.add),
      );
}
