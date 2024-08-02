import 'package:flutter/material.dart';
import 'package:gym_tracker/firestore_db.dart';
import 'package:gym_tracker/main.dart';
import 'package:watch_it/watch_it.dart';

import '../widgets/exercise_list.dart';
import 'navigable_screen.dart';
import 'sub_screens/new_exercise_screen.dart';

class HomeScreen extends WatchingWidget implements NavigableScreen {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    FirestoreDB db = FirestoreDB();
    return StreamBuilder(
      stream: db.getExerciseStream(),
      builder: (context, snapshot) {
        return ExerciseList(
          exercises: snapshot.data ?? [],
        );
      },
    );
  }

  @override
  final String title = 'Home';

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
