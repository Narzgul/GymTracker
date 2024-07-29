import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'exercise.dart';

class FirestoreDB extends ChangeNotifier {
  FirestoreDB();

  Future<void> ensureUser() async {
    FirebaseFirestore db = FirebaseFirestore.instance;
    // get logged in user
    User? user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      return;
    }

    var dbUser = await db.collection('users').doc(user.uid).get();
    if (!dbUser.exists) {
      await db
          .collection('users')
          .doc(user.uid)
          .set({'name': user.displayName});
    }
  }

  Stream<List<Exercise>> getExerciseStream() {
    FirebaseFirestore db = FirebaseFirestore.instance;
    User? user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      return const Stream.empty();
    }

    return db
        .collection('users')
        .doc(user.uid)
        .collection('exercises')
        .snapshots()
        .map(
          (event) => event.docs
              .map(
                (e) => Exercise(
                  name: e['name'],
                  sets: e['sets'],
                  reps: e['reps'],
                  weight: e['weight'],
                ),
              )
              .toList(),
        );
  }

  Future<void> addExercise(Exercise exercise) async {
    FirebaseFirestore db = FirebaseFirestore.instance;
    User? user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      return;
    }

    await db.collection('users').doc(user.uid).collection('exercises').add({
      'name': exercise.name,
      'sets': exercise.sets,
      'reps': exercise.reps,
      'weight': exercise.weight,
    });
  }
}
