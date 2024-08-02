import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:gym_tracker/app_scaffold.dart';
import 'package:gym_tracker/screens/home_screen.dart';
import 'package:gym_tracker/screens/login_screen.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const GymTracker());
}

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class GymTracker extends StatelessWidget {
  const GymTracker({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gym Tracker',
      navigatorKey: navigatorKey,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.blue),
      ),
      home: const AppScaffold(screens: [LoginScreen(), HomeScreen()]),
    );
  }
}
