import 'package:flutter/material.dart';
import 'package:gym_tracker/firestore_db.dart';


class NewExerciseScreen extends StatefulWidget {
  const NewExerciseScreen({super.key});

  @override
  State<NewExerciseScreen> createState() => _NewExerciseScreenState();
}

class _NewExerciseScreenState extends State<NewExerciseScreen> {
  final TextEditingController _nameController = TextEditingController();
  String? get _nameError => errorText(_nameController.text);
  final TextEditingController _setsController = TextEditingController();
  String? get _setsError => errorText(_setsController.text, isInt: true);
  final TextEditingController _repsController = TextEditingController();
  String? get _repsError => errorText(_repsController.text, isInt: true);
  final TextEditingController _weightController = TextEditingController();
  String? get _weightError => errorText(_weightController.text, isNumber: true);

  String? errorText(String input, {bool isNumber = false, bool isInt = false}) {
    if (input.isEmpty) {
      return 'Can\'t be empty';
    }
    if (isInt) {
      if (int.tryParse(input) == null) {
        return 'Must be a whole number';
      }
    } else if (isNumber) {
      if (double.tryParse(input) == null) {
        return 'Must be a number';
      }
    }
    return null;
  }

  bool triedSave = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Exercise'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: 'Name',
                errorText: triedSave ? _nameError : null,
              ),
              onChanged: (value) => triedSave ? setState(() {}) : null,
            ),
            TextField(
              controller: _setsController,
              decoration: InputDecoration(
                labelText: 'Sets',
                errorText: triedSave ? _setsError : null,
              ),
              onChanged: (value) => triedSave ? setState(() {}) : null,
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: _repsController,
              decoration: InputDecoration(
                labelText: 'Reps',
                errorText: triedSave ? _repsError : null,
              ),
              onChanged: (value) => triedSave ? setState(() {}) : null,
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: _weightController,
              decoration: InputDecoration(
                labelText: 'Weight',
                errorText: triedSave ? _weightError : null,
              ),
              onChanged: (value) => triedSave ? setState(() {}) : null,
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16.0), // Add some space
            ElevatedButton(
              onPressed: () {
                setState(() {
                  triedSave = true;
                });
                if (_nameError != null ||
                    _setsError != null ||
                    _repsError != null ||
                    _weightError != null) {
                  return;
                }
                FirestoreDB db = FirestoreDB();
                db.addExercise(
                  name: _nameController.text,
                  sets: int.parse(_setsController.text),
                  reps: int.parse(_repsController.text),
                  weight: double.parse(_weightController.text),
                );
                Navigator.of(context).pop();
              },
              child: const Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}
