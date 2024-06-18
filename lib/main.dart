import 'package:flutter/material.dart';
import 'package:gym_tracker/exercise_db.dart';
import 'package:watch_it/watch_it.dart';

import 'home_screen.dart';

void main() {
  runApp(const GymTracker());
}

class GymTracker extends StatelessWidget {
  const GymTracker({super.key});

  @override
  Widget build(BuildContext context) {
    var db = ExerciseDB();
    var dbFuture = db.openDB();
    if (!GetIt.I.isRegistered<ExerciseDB>()) {
      GetIt.I.registerSingleton<ExerciseDB>(db);
    }

    return MaterialApp(
      title: 'Gym Tracker',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.blue),
      ),
      home: FutureBuilder(
        builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return const HomeScreen();
        },
        future: dbFuture,
      ),
    );
  }
}