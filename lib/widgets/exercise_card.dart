import 'package:flutter/material.dart';
import 'package:gym_tracker/firestore_db.dart';

import '../exercise.dart';
import '../screens/sub_screens/exercise_detail.dart';

class ExerciseCard extends StatefulWidget {
  final Exercise exercise;

  const ExerciseCard({super.key, required this.exercise});

  @override
  State<ExerciseCard> createState() => _ExerciseCardState();
}

class _ExerciseCardState extends State<ExerciseCard> {
  Color _getBestTextColor(Color backgroundColor) {
    final double relativeLuminance = backgroundColor.computeLuminance();
    if (relativeLuminance > 0.5) {
      return Colors.black;
    } else {
      return Colors.white;
    }
  }

  @override
  Widget build(BuildContext context) {
    Color bestTextColor = _getBestTextColor(widget.exercise.color);

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
        color: widget.exercise.color,
        child: Row(
          children: [
            Flexible(
              child: Column(
                children: <Widget>[
                  ListTile(
                    title: Hero(
                      tag: widget.exercise.id,
                      child: Text(
                        widget.exercise.name,
                        style:
                            Theme.of(context).textTheme.headlineSmall?.copyWith(
                                  color: bestTextColor,
                                ),
                      ),
                    ),
                  ),
                  ListTile(
                    title: Text("Sets: ${widget.exercise.sets}"),
                    textColor: bestTextColor,
                  ),
                  ListTile(
                    title: Text("Reps: ${widget.exercise.reps}"),
                    textColor: bestTextColor,
                  ),
                  ListTile(
                    title: Text("Weight: ${widget.exercise.weight} kg"),
                    textColor: bestTextColor,
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(8.0),
              width: 100,
              // Scale the checkbox
              transform: Transform.scale(scale: 2).transform,
              transformAlignment: Alignment.center,
              child: Checkbox(
                value: widget.exercise.finished,
                onChanged: (bool? value) {
                  if (value == null) return;
                  setState(() {
                    widget.exercise.finished = value;
                    FirestoreDB db = FirestoreDB();
                    db.updateExercise(widget.exercise);
                  });
                },
                side: BorderSide(
                  color: bestTextColor,
                ),
                checkColor: bestTextColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
