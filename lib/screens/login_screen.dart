import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:gym_tracker/firestore_db.dart';

import 'navigable_screen.dart';

class LoginScreen extends StatelessWidget implements NavigableScreen {
  const LoginScreen({super.key});

  bool checkUser() {
    User? user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      print("No user logged in");
      return false;
    } else {
      print(user.displayName);
      return true;
    }
  }

  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  signOutGoogle() async {
    await GoogleSignIn().signOut();
    await FirebaseAuth.instance.signOut();
    print("User Signed Out");
  }

  testFirestore() {
    var db = FirestoreDB();
    db.ensureUser().then((value) => print("User ensured"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Login Screen'),
            ElevatedButton(
              onPressed: () => signInWithGoogle(),
              child: const Text('Sign in with Google'),
            ),
            ElevatedButton(
              onPressed: () => signOutGoogle(),
              child: const Text('Sign out'),
            ),
            ElevatedButton(
              onPressed: () => checkUser(),
              child: const Text("Check if User logged in"),
            ),
            ElevatedButton(
              onPressed: () => testFirestore(),
              child: const Text("Test Firestore"),
            ),
          ],
        ),
      ),
    );
  }

  @override
  final String title = 'Login';

  @override
  FloatingActionButton? get floatingActionButton => null;
}
