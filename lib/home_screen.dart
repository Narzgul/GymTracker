import 'package:flutter/material.dart';

import 'exercise_db.dart';
import 'exercise_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({
    super.key,
    required this.db,
  });

  final ExerciseDB db;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gym Tracker'),
      ),
      body: FutureBuilder(
        // Load exercises from the database and display them
        future: db.getExercises(),
        builder: (BuildContext context,
            AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator());
          }
          // If there are no exercises, display a message
          if (snapshot.data == null || snapshot.data!.isEmpty) {
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
          List<Map<String, dynamic>> exercises = snapshot.data!;
          return ListView.builder(
            itemCount: exercises.length,
            itemBuilder: (BuildContext context, int index) {
              return ExerciseCard(
                exerciseName: exercises[index]['name'],
                numSets: exercises[index]['sets'],
                numReps: exercises[index]['reps'],
                weight: exercises[index]['weight'],
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => db.insertExercise("Squat", 3, 15, 225),
        child: const Icon(Icons.add),
      ),
    );
  }
}
