import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Exercise {
  String name;
  int sets;
  int reps;
  double weight;
  String id;
  Map<String, String> settings;
  Color color = Colors.white;
  bool finished = false;

  Exercise({
    required this.name,
    required this.sets,
    required this.reps,
    required this.weight,
    required this.id,
    required this.settings,
    this.color = Colors.white,
    this.finished = false,
  });

  void addSetting({String key = '', String value = ''}) {
    if (key == '') {
      int i = 1;
      while (settings.containsKey('Setting ${settings.length + i}')) {
        i++;
      }
      settings['Setting ${settings.length + i}'] = value;
    } else if (!settings.containsKey(key)) {
      settings[key] = value;
    }
  }

  @override
  bool operator ==(Object other) {
    return other is Exercise &&
        other.id == id &&
        other.name == name &&
        other.sets == sets &&
        other.reps == reps &&
        other.weight == weight &&
        mapEquals(settings, other.settings) &&
        other.color == color &&
        other.finished == finished;
  }

  @override
  int get hashCode =>
      Object.hashAll([name, sets, reps, weight, id, settings, color, finished]);

  @override
  String toString() {
    return 'Exercise(name: $name, sets: $sets, reps: $reps, weight: $weight, id: $id, settings: $settings)';
  }
}
