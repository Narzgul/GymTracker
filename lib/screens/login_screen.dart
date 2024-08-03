import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:gym_tracker/firestore_db.dart';

import 'navigable_screen.dart';

class LoginScreen extends StatelessWidget implements NavigableScreen {
  const LoginScreen({super.key});

  bool checkUser(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      // Open Dialog informing user to login
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return const AlertDialog(
            title: Text("Not logged in"),
            content: Text("Please login to continue!"),
          );
        },
      );
      return false;
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Logged in"),
            content: Text("You are logged in as ${user.displayName}!"),
          );
        },
      );
      return true;
    }
  }

  Future<void> signInWithGoogle() async {
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
    await FirebaseAuth.instance.signInWithCredential(credential);
    var db = FirestoreDB();
    db.ensureUserInDB();
  }

  signOutGoogle(BuildContext context) async {
    await GoogleSignIn().signOut();
    await FirebaseAuth.instance.signOut();

    if(!context.mounted) return;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return const AlertDialog(
          title: Text("Logged out"),
          content: Text("You are no longer logged in with Google!"),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => signInWithGoogle(),
              child: const Text('Sign in with Google'),
            ),
            const Divider(),
            ElevatedButton(
              onPressed: () => signOutGoogle(context),
              child: const Text('Sign out'),
            ),
            ElevatedButton(
              onPressed: () => checkUser(context),
              child: const Text("Check if User logged in"),
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
