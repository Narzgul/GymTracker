import 'dart:io';

import 'package:sqflite_common_ffi/sqflite_ffi.dart';

class ExerciseDB {
  late Database db;

  ExerciseDB() {
    if (Platform.isWindows || Platform.isLinux) {
      // Initialize FFI
      sqfliteFfiInit();
    }
    // Change the default factory. On iOS/Android, if not using `sqlite_flutter_lib` you can forget
    // this step, it will use the sqlite version available on the system.
    databaseFactory = databaseFactoryFfi;
  }

  Future<void> openDB() async {
    String dbPath = await getDatabasesPath();
    db = await openDatabase(
      '$dbPath/gym_tracker.db',
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute(
            'CREATE TABLE exercises (id INTEGER PRIMARY KEY, name TEXT, sets INTEGER, reps INTEGER, weight REAL)');
      },
    );
  }

  Future<void> insertExercise(String name, int sets, int reps, double weight) async {
    await db.insert(
      'exercises',
      {
        'name': name,
        'sets': sets,
        'reps': reps,
        'weight': weight,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // Get all exercises
  Future<List<Map<String, dynamic>>> getExercises() async {
    return await db.query('exercises');
  }
}
