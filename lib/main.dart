import 'package:flutter/material.dart';
import 'package:gym_tracker/exercise_db.dart';
import 'package:gym_tracker/login_screen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:watch_it/watch_it.dart';

import 'home_screen.dart';
import 'auth/secrets.dart';

void main() async {
  // Required by Supabase, because it needs native code
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(url: supabaseURL, anonKey: supabaseAnonKey);

  runApp(const GymTracker());
}

class GymTracker extends StatelessWidget {
  const GymTracker({super.key});

  @override
  Widget build(BuildContext context) {
    var db = ExerciseDB(supabase: Supabase.instance.client);
    if (!GetIt.I.isRegistered<ExerciseDB>()) {
      GetIt.I.registerSingleton<ExerciseDB>(db);
    }

    return MaterialApp(
      title: 'Gym Tracker',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.blue),
      ),
      home: const LoginScreen(),
    );
  }
}
