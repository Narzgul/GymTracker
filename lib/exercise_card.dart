import 'package:flutter/material.dart';

class ExerciseCard extends StatefulWidget {
  final String exerciseName;
  final int numSets;
  final int numReps;
  final double weight;

  const ExerciseCard({
    super.key,
    required this.exerciseName,
    required this.numSets,
    required this.numReps,
    required this.weight,
  });

  @override
  State<ExerciseCard> createState() => _ExerciseCardState();
}

class _ExerciseCardState extends State<ExerciseCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: <Widget>[
          ListTile(
            title: Text(widget.exerciseName),
          ),
          ListTile(
            title: Text("Sets: ${widget.numSets}"),
          ),
          ListTile(
            title: Text("Reps: ${widget.numReps}"),
          ),
          ListTile(
            title: Text("Weight: ${widget.weight} kg"),
          ),
        ],
      ),
    );
  }
}
