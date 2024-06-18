import 'package:flutter/material.dart';
import 'package:gym_tracker/database.dart';
import 'package:gym_tracker/exercise_card.dart';

void main() {
  runApp(const GymTracker());
}

class GymTracker extends StatelessWidget {
  const GymTracker({super.key});

  @override
  Widget build(BuildContext context) {
    var db = ExerciseDB();
    var dbFuture = db.openDB();
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
          return Scaffold(
              appBar: AppBar(
                title: const Text('Gym Tracker'),
              ),
              body: FutureBuilder(
                builder: (BuildContext context,
                    AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
                  if (snapshot.connectionState != ConnectionState.done) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return ListView.builder(
                    itemCount: snapshot.data?.length,
                    itemBuilder: (BuildContext context, int index) {
                      if (snapshot.data == null) {
                        return const Center(child: Text('No exercises'));
                      }
                      return ExerciseCard(
                        exerciseName: snapshot.data?[index]['name'],
                        numSets: snapshot.data?[index]['sets'],
                        numReps: snapshot.data?[index]['reps'],
                        weight: snapshot.data?[index]['weight'],
                      );
                    },
                  );
                },
                future: db.getExercises(),
              ),
              floatingActionButton: FloatingActionButton(
                onPressed: () {
                  db.insertExercise("Squat", 3, 15, 225);
                },
                child: const Icon(Icons.add),
              ));
        },
        future: dbFuture,
      ),
    );
  }
}
