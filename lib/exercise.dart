import 'package:flutter/foundation.dart';

class Exercise {
  String name;
  int sets;
  int reps;
  double weight;
  String id;
  Map<String, String> settings;

  Exercise({
    required this.name,
    required this.sets,
    required this.reps,
    required this.weight,
    required this.id,
    this.settings = const {},
  });

  @override
  bool operator ==(Object other) {
    return other is Exercise &&
        other.id == id &&
        other.name == name &&
        other.sets == sets &&
        other.reps == reps &&
        other.weight == weight &&
        mapEquals(settings, other.settings);
  }

  @override
  int get hashCode => Object.hashAll([name, sets, reps, weight, id, settings]);

  @override
  String toString() {
    return 'Exercise(name: $name, sets: $sets, reps: $reps, weight: $weight, id: $id, settings: $settings)';
  }
}
