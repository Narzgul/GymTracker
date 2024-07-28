import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'exercise.dart';

class FirestoreDB extends ChangeNotifier {

  List<Exercise> _exercises = [];
  set exercises(List<Exercise> value) {
    _exercises = value;
    notifyListeners();
  }

  FirestoreDB() {
    // If no user in db add one
  }

  Future<void> ensureUser() async {
    FirebaseFirestore db = FirebaseFirestore.instance;
    // get logged in user
    User? user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      return;
    }

    var dbUser = await db.collection('users').doc(user.uid).get();
    if (!dbUser.exists) {
      await db.collection('users').doc(user.uid).set({'name': user.displayName});
    }
  }
}
