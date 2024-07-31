import 'dart:convert';

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
      (event) {
        for (var doc in event.docs) {
          print(doc['settings']);
          print(Map.from(doc['settings']));
        }
        return event.docs
            .map(
              (e) {
                print('returning exercise');
                if(e['settings'] == null || e['settings'] == {}) {
                  return Exercise(
                    name: e['name'],
                    sets: e['sets'],
                    reps: e['reps'],
                    weight: e['weight'],
                    id: e.id,
                  );
                }
                return Exercise(
                name: e['name'],
                sets: e['sets'],
                reps: e['reps'],
                weight: e['weight'],
                id: e.id,
                settings: Map.from(e['settings']),
              );
              },
            )
            .toList();
      },
    );
  }

  Future<String> addExercise(
      {required String name,
      required int sets,
      required int reps,
      required double weight}) async {
    FirebaseFirestore db = FirebaseFirestore.instance;
    User? user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      return '';
    }

    DocumentReference<Map<String, dynamic>> documentRef =
        await db.collection('users').doc(user.uid).collection('exercises').add({
      'name': name,
      'sets': sets,
      'reps': reps,
      'weight': weight,
      'settings': json.encode({}),
    });
    return documentRef.id;
  }

  Future<Exercise> getExercise(String id, {bool cache = false}) async {
    FirebaseFirestore db = FirebaseFirestore.instance;
    User? user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      return Exercise(name: '', sets: 0, reps: 0, weight: 0, id: '');
    }

    DocumentSnapshot<Map<String, dynamic>> doc = await db
        .collection('users')
        .doc(user.uid)
        .collection('exercises')
        .doc(id)
        .get();

    return Exercise(
      name: doc['name'],
      sets: doc['sets'],
      reps: doc['reps'],
      weight: doc['weight'],
      id: doc.id,
    );
  }

  Future<void> editExercise(Exercise exercise) async {
    FirebaseFirestore db = FirebaseFirestore.instance;
    User? user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      return;
    }
    if (await getExercise(exercise.id, cache: true) == exercise) {
      return;
    }

    await db
        .collection('users')
        .doc(user.uid)
        .collection('exercises')
        .doc(exercise.id)
        .update({
      'name': exercise.name,
      'sets': exercise.sets,
      'reps': exercise.reps,
      'weight': exercise.weight,
    });
  }

  Future<void> deleteExercise(Exercise exercise) async {
    FirebaseFirestore db = FirebaseFirestore.instance;
    User? user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      return;
    }

    await db
        .collection('users')
        .doc(user.uid)
        .collection('exercises')
        .doc(exercise.id)
        .delete();
  }
}
