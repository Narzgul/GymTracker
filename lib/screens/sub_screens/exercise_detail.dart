import 'package:flutter/material.dart';
import 'package:gym_tracker/firestore_db.dart';
import 'package:gym_tracker/widgets/setting_tile.dart';

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

      // Body
      body: ListView(
        children: <Widget>[
          // Sets
          SettingTile(
            title: 'Sets',
            value: newExercise.sets,
            icon: const Icon(Icons.repeat),
            editMode: editMode,
            onChanged: (value) {
              if (value.isNotEmpty) {
                newExercise.sets = int.parse(value);
              }
            },
          ),

          // Reps
          SettingTile(
            title: 'Reps',
            value: newExercise.reps,
            icon: const Icon(Icons.autorenew),
            editMode: editMode,
            onChanged: (value) {
              if (value.isNotEmpty) {
                newExercise.reps = int.parse(value);
              }
            },
          ),

          // Weight
          SettingTile(
            title: 'Weight',
            value: newExercise.weight,
            icon: const Icon(Icons.fitness_center),
            editMode: editMode,
            onChanged: (value) {
              if (value.isNotEmpty) {
                newExercise.weight = double.parse(value);
              }
            },
          ),

          const Divider(),

          // Settings
          for (String key in newExercise.settings.keys)
            SettingTile(
              title: key,
              value: newExercise.settings[key],
              editMode: editMode,
              onChanged: (value) {
                newExercise.settings[key] = value;
              },
            ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                newExercise.addSetting();
                editMode = true;
              });
            },
            child: const Text('Add setting'),
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
