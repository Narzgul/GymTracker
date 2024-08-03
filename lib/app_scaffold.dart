import 'package:flutter/material.dart';
import 'package:gym_tracker/firestore_db.dart';
import 'package:gym_tracker/screens/home_screen.dart';
import 'package:gym_tracker/screens/login_screen.dart';
import 'package:gym_tracker/screens/navigable_screen.dart';

class AppScaffold extends StatefulWidget {
  const AppScaffold({super.key});

  @override
  State<AppScaffold> createState() => _AppScaffoldState();
}

class _AppScaffoldState extends State<AppScaffold> {
  int _currentPageIndex = 0;
  final List<NavigableScreen> screens = const [HomeScreen(), LoginScreen()];

  @override
  void initState() {
    super.initState();
    FirestoreDB db = FirestoreDB();
    if (!db.userLoggedIn()) {
      _currentPageIndex = 1;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(screens[_currentPageIndex].title),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
              ),
              child: Text(
                'Gym Tracker',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ),
            for (final screen in screens)
              ListTile(
                title: Text(screen.title),
                onTap: () {
                  setState(() {
                    _currentPageIndex = screens.indexOf(screen);
                  });
                  Navigator.pop(context);
                },
              ),
          ],
        ),
      ),
      floatingActionButton: screens[_currentPageIndex].floatingActionButton,
      body: screens[_currentPageIndex],
    );
  }
}
