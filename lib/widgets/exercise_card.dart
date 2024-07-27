import 'package:flutter/material.dart';

import '../screens/sub_screens/exercise_detail.dart';

class ExerciseCard extends StatefulWidget {
  final String exerciseName;
  final int numSets;
  final int numReps;
  final double weight;
  final String heroTag;

  const ExerciseCard({
    super.key,
    required this.exerciseName,
    required this.numSets,
    required this.numReps,
    required this.weight,
    required this.heroTag,
  });

  @override
  State<ExerciseCard> createState() => _ExerciseCardState();
}

class _ExerciseCardState extends State<ExerciseCard> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ExerciseDetail(
              exerciseName: widget.exerciseName,
              numSets: widget.numSets,
              numReps: widget.numReps,
              weight: widget.weight,
              heroTag: widget.heroTag,
            ),
          ),
        );
      },
      child: Card(
        child: Column(
          children: <Widget>[
            ListTile(
              title: Hero(
                tag: 'exerciseName${widget.exerciseName}',
                child: Text(
                  widget.exerciseName,
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
              ),
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
      ),
    );
  }
}
