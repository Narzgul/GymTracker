import 'package:flutter/material.dart';
import 'package:watch_it/watch_it.dart';

import '../../exercise.dart';
import '../../exercise_db.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Hero(
          tag: 'exerciseName${widget.exercise.name}',
          child: Text(
            widget.exercise.name,
            style: Theme.of(context).textTheme.headlineSmall,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            // Save potential changes before popping
            if (newNumReps != null || newNumSets != null || newWeight != null) {
              GetIt.I<ExerciseDB>().editExercise(
                widget.exercise.name,
                newNumSets ?? widget.exercise.sets,
                newNumReps ?? widget.exercise.reps,
                newWeight ?? widget.exercise.weight,
              );
            }
            Navigator.of(context).pop();
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              // Delete the exercise
              GetIt.I<ExerciseDB>().deleteExercise(widget.exercise.name);
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
            GetIt.I<ExerciseDB>().editExercise(
              widget.exercise.name,
              newNumSets ?? widget.exercise.sets,
              newNumReps ?? widget.exercise.reps,
              newWeight ?? widget.exercise.weight,
            );
          }
          editMode = !editMode;
        }),
      ),
    );
  }
}
