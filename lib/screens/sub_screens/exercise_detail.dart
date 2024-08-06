import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:gym_tracker/firestore_db.dart';
import 'package:gym_tracker/widgets/editable_tile.dart';

import '../../exercise.dart';
import '../../widgets/settings_tile.dart';

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
    db.updateExercise(newExercise);
  }

  @override
  void dispose() {
    // Save the changes also when the user uses the back button / gesture
    super.dispose();
    saveChanges();
  }

  Color _getBestIconColor(Color backgroundColor) {
    final double relativeLuminance = backgroundColor.computeLuminance();
    if (relativeLuminance > 0.5) {
      return Colors.black;
    } else {
      return Colors.white;
    }
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
            // Changes are automatically saved when the widget is disposed
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
          EditableTile(
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
          EditableTile(
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
          EditableTile(
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

          // Color
          ListTile(
            title: const Text('Color'),
            trailing: CircleAvatar(
              backgroundColor: newExercise.color,
              child: editMode
                  ? IconButton(
                      icon: const Icon(Icons.edit),
                      color: _getBestIconColor(newExercise.color),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: const Text('Pick a color'),
                            content: SingleChildScrollView(
                              child: HueRingPicker(
                                pickerColor: newExercise.color,
                                onColorChanged: (color) {
                                  newExercise.color = color;
                                  setState(() {});
                                },
                              ),
                            ),
                          ),
                        );
                      },
                    )
                  : null,
            ),
          ),

          const Divider(),

          // Settings
          for (String key in newExercise.settings.keys)
            SettingsTile(
              title: key,
              value: newExercise.settings[key],
              editMode: editMode,
              onChangedValue: (String value) {
                newExercise.settings[key] = value;
              },
              onChangedTitle: (String value) {
                setState(() {
                  newExercise.addSetting(
                    key: value,
                    value: newExercise.settings[key] ?? '',
                  );
                  newExercise.settings.remove(key);
                });
              },
              onDelete: () {
                setState(() {
                  newExercise.settings.remove(key);
                });
              },
            ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () {
                setState(() {
                  newExercise.addSetting();
                  editMode = true;
                });
              },
              child: const Text('Add setting'),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: editMode ? const Icon(Icons.save) : const Icon(Icons.edit),
        onPressed: () => setState(() {
          if (editMode) {
            saveChanges();
          }
          editMode = !editMode;
        }),
      ),
    );
  }
}
