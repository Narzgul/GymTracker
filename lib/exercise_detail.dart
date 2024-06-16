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
  bool editMode = false;

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
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () => setState(() => editMode = !editMode),
          )
        ],
      ),
      body: Column(
        children: <Widget>[
          ListTile(
            title: const Text("Sets"),
            subtitle: editMode
                ? TextField(
                    keyboardType: TextInputType.number,
                    controller:
                        TextEditingController(text: "${widget.numSets}"),
                  )
                : Text(
                    "${widget.numSets}",
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
          ),
          ListTile(
            title: const Text("Reps"),
            subtitle: editMode
                ? TextField(
                    keyboardType: TextInputType.number,
                    controller:
                        TextEditingController(text: "${widget.numReps}"),
                  )
                : Text(
                    "${widget.numReps}",
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
          ),
          ListTile(
            title: const Text("Weight"),
            subtitle: editMode
                ? TextField(
                    keyboardType: TextInputType.number,
                    controller: TextEditingController(text: "${widget.weight}"),
                  )
                : Text(
                    "${widget.weight} kg",
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
          ),
        ],
      ),
    );
  }
}
