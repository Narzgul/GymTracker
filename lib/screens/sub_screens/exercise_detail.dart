import 'package:flutter/material.dart';
import 'package:watch_it/watch_it.dart';

import '../../exercise_db.dart';

class ExerciseDetail extends StatefulWidget {
  final String exerciseName;
  final int numSets;
  final int numReps;
  final double weight;
  final String heroTag;

  const ExerciseDetail({
    super.key,
    required this.exerciseName,
    required this.numSets,
    required this.numReps,
    required this.weight,
    required this.heroTag,
  });

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
          tag: 'exerciseName${widget.exerciseName}',
          child: Text(
            widget.exerciseName,
            style: Theme.of(context).textTheme.headlineSmall,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            // Save potential changes before popping
            if (newNumReps != null || newNumSets != null || newWeight != null) {
              GetIt.I<ExerciseDB>().editExercise(
                widget.exerciseName,
                newNumSets ?? widget.numSets,
                newNumReps ?? widget.numReps,
                newWeight ?? widget.weight,
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
              GetIt.I<ExerciseDB>().deleteExercise(widget.exerciseName);
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
                        TextEditingController(text: "${widget.numSets}"),
                    onChanged: (value) {
                      if (value.isNotEmpty) {
                        newNumSets = int.parse(value);
                      }
                    },
                  )
                : Text(
                    "${newNumSets ?? widget.numSets}",
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
                        TextEditingController(text: "${widget.numReps}"),
                    onChanged: (value) {
                      if (value.isNotEmpty) {
                        newNumReps = int.parse(value);
                      }
                    },
                  )
                : Text(
                    "${newNumReps ?? widget.numReps}",
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
          ),

          // Weight
          ListTile(
            title: const Text("Weight"),
            subtitle: editMode
                ? TextField(
                    keyboardType: TextInputType.number,
                    controller: TextEditingController(text: "${widget.weight}"),
                    onChanged: (value) {
                      if (value.isNotEmpty) {
                        newWeight = double.parse(value);
                      }
                    },
                  )
                : Text(
                    "${newWeight ?? widget.weight} kg",
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
              widget.exerciseName,
              newNumSets ?? widget.numSets,
              newNumReps ?? widget.numReps,
              newWeight ?? widget.weight,
            );
          }
          editMode = !editMode;
        }),
      ),
    );
  }
}
