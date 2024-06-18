import 'package:flutter/material.dart';
import 'package:watch_it/watch_it.dart';

import 'exercise_db.dart';

class ExerciseDetail extends StatefulWidget {
  final String exerciseName;
  final int numSets;
  final int numReps;
  final double weight;

  const ExerciseDetail({
    super.key,
    required this.exerciseName,
    required this.numSets,
    required this.numReps,
    required this.weight,
  });

  @override
  State<ExerciseDetail> createState() => _ExerciseDetailState();
}

class _ExerciseDetailState extends State<ExerciseDetail> {
  bool editMode = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Hero(
          tag: 'exerciseName${widget.exerciseName}',
          child: Text(
            widget.exerciseName,
            style: Theme.of(context).textTheme.headlineSmall,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              // Delete the exercise
              GetIt.I<ExerciseDB>().deleteExercise(widget.exerciseName);
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          ListTile(
            title: const Text("Sets"),
            subtitle: editMode
                ? TextField(
                    keyboardType: TextInputType.number,
                    controller:
                        TextEditingController(text: "${widget.numSets}"),
                  )
                : Text(
                    "${widget.numSets}",
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
          ),
          ListTile(
            title: const Text("Reps"),
            subtitle: editMode
                ? TextField(
                    keyboardType: TextInputType.number,
                    controller:
                        TextEditingController(text: "${widget.numReps}"),
                  )
                : Text(
                    "${widget.numReps}",
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
          ),
          ListTile(
            title: const Text("Weight"),
            subtitle: editMode
                ? TextField(
                    keyboardType: TextInputType.number,
                    controller: TextEditingController(text: "${widget.weight}"),
                  )
                : Text(
                    "${widget.weight} kg",
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: editMode ? const Icon(Icons.save) : const Icon(Icons.edit),
        onPressed: () => setState(() => editMode = !editMode),
      ),
    );
  }
}
