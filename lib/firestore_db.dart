import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'exercise.dart';

class FirestoreDB extends ChangeNotifier {
  FirestoreDB();

  Future<void> ensureUserInDB() async {
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

  bool userLoggedIn() {
    User? user = FirebaseAuth.instance.currentUser;
    return user != null;
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
        return event.docs.map(
          (e) {
            if (!e.data().containsKey('settings') || e['settings'] == '{}') {
              return Exercise(
                name: e['name'],
                sets: e['sets'],
                reps: e['reps'],
                weight: e['weight'],
                id: e.id,
                settings: {},
                color: e.data().containsKey('color')
                    ? Color(e['color'])
                    : Colors.white,
                finished: e.data().containsKey('finished')
                    ? e['color']
                    : false,
              );
            }
            return Exercise(
              name: e['name'],
              sets: e['sets'],
              reps: e['reps'],
              weight: e['weight'],
              id: e.id,
              settings: Map.from(e[
                  'settings']),
              color: e.data().containsKey('color')
                  ? Color(e['color'])
                  : Colors.white,
              finished: e.data().containsKey('finished')
                  ? e['finished']
                  : false,
            );
          },
        ).toList();
      },
    );
  }

  Future<String> addExercise({
    required String name,
    required int sets,
    required int reps,
    required double weight,
  }) async {
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
      'color': Colors.white.value,
    });
    return documentRef.id;
  }

  Future<Exercise> getExercise(String id, {bool cache = false}) async {
    FirebaseFirestore db = FirebaseFirestore.instance;
    User? user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      return Exercise(
        name: '',
        sets: 0,
        reps: 0,
        weight: 0,
        id: '',
        settings: {},
      );
    }

    DocumentSnapshot<Map<String, dynamic>> doc = await db
        .collection('users')
        .doc(user.uid)
        .collection('exercises')
        .doc(id)
        .get();

    if (!doc.data()!.containsKey('settings') || doc['settings'] == '{}') {
      return Exercise(
        name: doc['name'],
        sets: doc['sets'],
        reps: doc['reps'],
        weight: doc['weight'],
        id: doc.id,
        settings: {},
        color: doc.data()!.containsKey('color')
            ? Color(doc['color'])
            : Colors.white,
        finished: doc.data()!.containsKey('finished')
            ? doc['finished']
            : false,
      );
    }
    return Exercise(
      name: doc['name'],
      sets: doc['sets'],
      reps: doc['reps'],
      weight: doc['weight'],
      id: doc.id,
      settings: Map.from(doc['settings']),
      color: doc.data()!.containsKey('color')
          ? Color(doc['color'])
          : Colors.white,
      finished: doc.data()!.containsKey('finished')
          ? doc['finished']
          : false,
    );
  }

  Future<void> updateExercise(Exercise exercise) async {
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
      'settings': exercise.settings,
      'color': exercise.color.value,
      'finished': exercise.finished,
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
