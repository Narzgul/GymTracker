import 'package:flutter/material.dart';

import '../exercise.dart';
import '../screens/sub_screens/exercise_detail.dart';

class ExerciseCard extends StatefulWidget {
  final Exercise exercise;

  const ExerciseCard({super.key, required this.exercise});

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
            builder: (context) => ExerciseDetail(exercise: widget.exercise),
          ),
        );
      },
      child: Card(
        child: Column(
          children: <Widget>[
            ListTile(
              title: Hero(
                tag: widget.exercise.id,
                child: Text(
                  widget.exercise.name,
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
              ),
            ),
            ListTile(
              title: Text("Sets: ${widget.exercise.sets}"),
            ),
            ListTile(
              title: Text("Reps: ${widget.exercise.reps}"),
            ),
            ListTile(
              title: Text("Weight: ${widget.exercise.weight} kg"),
            ),
          ],
        ),
      ),
    );
  }
}
