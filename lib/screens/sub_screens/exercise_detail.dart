import 'package:flutter/material.dart';
import 'package:gym_tracker/firestore_db.dart';

import '../../exercise.dart';

class ExerciseDetail extends StatefulWidget {
  final Exercise exercise;

  const ExerciseDetail({super.key, required this.exercise});

  @override
  State<ExerciseDetail> createState() => _ExerciseDetailState();
}

class _ExerciseDetailState extends State<ExerciseDetail> {
  bool editMode = false;
  int? newNumSets;
  int? newNumReps;
  double? newWeight;

  void saveChanges() {
    if (newNumReps != null || newNumSets != null || newWeight != null) {
      Exercise newExercise = Exercise(
        name: widget.exercise.name,
        sets: newNumSets ?? widget.exercise.sets,
        reps: newNumReps ?? widget.exercise.reps,
        weight: newWeight ?? widget.exercise.weight,
        id: widget.exercise.id,
      );

      FirestoreDB db = FirestoreDB();
      db.editExercise(newExercise);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Hero(
          tag: widget.exercise.id,
          child: Text(
            widget.exercise.name,
            style: Theme.of(context).textTheme.headlineSmall,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            // Save potential changes before popping
            saveChanges();
            Navigator.of(context).pop();
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              // Delete the exercise
              FirestoreDB().deleteExercise(widget.exercise);
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          // Sets
          ListTile(
            title: const Text("Sets"),
            subtitle: editMode
                ? TextField(
                    keyboardType: TextInputType.number,
                    controller:
                        TextEditingController(text: "${widget.exercise.sets}"),
                    onChanged: (value) {
                      if (value.isNotEmpty) {
                        newNumSets = int.parse(value);
                      }
                    },
                  )
                : Text(
                    "${newNumSets ?? widget.exercise.sets}",
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
          ),

          // Reps
          ListTile(
            title: const Text("Reps"),
            subtitle: editMode
                ? TextField(
                    keyboardType: TextInputType.number,
                    controller:
                        TextEditingController(text: "${widget.exercise.reps}"),
                    onChanged: (value) {
                      if (value.isNotEmpty) {
                        newNumReps = int.parse(value);
                      }
                    },
                  )
                : Text(
                    "${newNumReps ?? widget.exercise.reps}",
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
          ),

          // Weight
          ListTile(
            title: const Text("Weight"),
            subtitle: editMode
                ? TextField(
                    keyboardType: TextInputType.number,
                    controller: TextEditingController(
                        text: "${widget.exercise.weight}"),
                    onChanged: (value) {
                      if (value.isNotEmpty) {
                        newWeight = double.parse(value);
                      }
                    },
                  )
                : Text(
                    "${newWeight ?? widget.exercise.weight} kg",
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: editMode ? const Icon(Icons.save) : const Icon(Icons.edit),
        onPressed: () => setState(() {
          if (editMode) {
            // Save the changes
            saveChanges();
          }
          editMode = !editMode;
        }),
      ),
    );
  }
}
