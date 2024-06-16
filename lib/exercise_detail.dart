import 'package:flutter/material.dart';

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
      ),
      body: Column(
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
