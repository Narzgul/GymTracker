import 'package:flutter/material.dart';
import 'package:gym_tracker/exercise.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ExerciseDB extends ChangeNotifier {
  SupabaseClient supabase;

  List<Exercise> _exercises = [];
  set exercises(List<Exercise> value) {
    _exercises = value;
    notifyListeners();
  }

  List<Exercise> get exercises => _exercises;

  ExerciseDB({required this.supabase});

  // Get all exercises
  Future<void> loadExercises() async {
    List<Map<String, dynamic>> rawExercises =
        await supabase.from('exercises').select();
    exercises = rawExercises
        .map((e) => Exercise(
              name: e['name'],
              sets: e['sets'],
              reps: e['reps'],
              weight: e['weight'] as double,
            ))
        .toList();
  }

  Future<void> addExercise(
      String name, int sets, int reps, double weight) async {
    await supabase.from('exercises').insert(
      {
        'name': name,
        'sets': sets,
        'reps': reps,
        'weight': weight,
      },
    );
  }

  Future<void> editExercise(
      String name, int sets, int reps, double weight) async {
    await supabase.from('exercises').update(
      {
        'sets': sets,
        'reps': reps,
        'weight': weight,
      },
    ).eq('name', name);
    loadExercises();
  }

  Future<void> deleteExercise(String name) async {
    await supabase.from('exercises').delete().eq('name', name);
    loadExercises();
  }
}
