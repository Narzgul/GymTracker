import 'package:flutter/material.dart';

import '../exercise.dart';
import 'exercise_card.dart';

class ExerciseList extends StatefulWidget {
  final List<Exercise> exercises;

  const ExerciseList({super.key, required this.exercises});

  @override
  State<ExerciseList> createState() => _ExerciseListState();
}

class _ExerciseListState extends State<ExerciseList> {
  @override
  Widget build(BuildContext context) {
    // If there are no exercises, display a message
    if (widget.exercises.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'No exercises',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const Text(
              'Add an exercise using the button below to get started',
            ),
          ],
        ),
      );
    }

    // If there are exercises, display them in a list
    return Column(
      children: [
        SizedBox(
          height: 5,
          child: TweenAnimationBuilder(
            duration: const Duration(milliseconds: 250),
            tween: Tween<double>(
                begin: 0,
                end: widget.exercises.where((e) => e.finished).length /
                    widget.exercises.length),
            builder: (context, value, _) =>
                LinearProgressIndicator(value: value),
          ),
        ),
        Flexible(
          child: ListView.builder(
            itemCount: widget.exercises.length,
            itemBuilder: (BuildContext context, int index) => ExerciseCard(
                exercise: widget.exercises[index],
                onExerciseFinished: (bool finished) {
                  setState(() {
                    widget.exercises[index].finished = finished;
                  });
                }),
          ),
        ),
      ],
    );
  }
}
