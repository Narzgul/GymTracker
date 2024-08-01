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
  late Exercise newExercise = widget.exercise;
  late Exercise oldExercise = widget.exercise;

  void saveChanges() {
    FirestoreDB db = FirestoreDB();
    db.editExercise(newExercise);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Hero(
          tag: widget.exercise.id,
          child: editMode
              ? TextField(
                  controller: TextEditingController(text: newExercise.name),
                  onChanged: (value) {
                    newExercise.name = value;
                  },
                )
              : Text(
                  newExercise.name,
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
      body: ListView(
        children: <Widget>[
          // Sets
          ListTile(
            title: const Text("Sets"),
            subtitle: editMode
                ? TextField(
                    keyboardType: TextInputType.number,
                    controller: TextEditingController(
                        text: newExercise.sets.toString()),
                    onChanged: (value) {
                      if (value.isNotEmpty) {
                        newExercise.sets = int.parse(value);
                      }
                    },
                  )
                : Text(
                    newExercise.sets.toString(),
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
          ),

          // Reps
          ListTile(
            title: const Text("Reps"),
            subtitle: editMode
                ? TextField(
                    keyboardType: TextInputType.number,
                    controller: TextEditingController(
                        text: newExercise.reps.toString()),
                    onChanged: (value) {
                      if (value.isNotEmpty) {
                        newExercise.reps = int.parse(value);
                      }
                    },
                  )
                : Text(
                    newExercise.reps.toString(),
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
                        text: newExercise.weight.toString()),
                    onChanged: (value) {
                      if (value.isNotEmpty) {
                        newExercise.weight = double.parse(value);
                      }
                    },
                  )
                : Text(
                    newExercise.weight.toString(),
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
          ),

          // Settings
          for (String key in newExercise.settings.keys)
            ListTile(
              title: Text(key),
              subtitle: editMode
                  ? TextField(
                      controller: TextEditingController(
                          text: newExercise.settings[key]),
                      onChanged: (value) {
                        newExercise.settings[key] = value;
                      },
                    )
                  : Text(
                      newExercise.settings[key]!,
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
