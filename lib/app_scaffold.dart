import 'package:flutter/material.dart';
import 'package:gym_tracker/screens/navigable_screen.dart';

class AppScaffold extends StatefulWidget {
  const AppScaffold({super.key, required this.screens});

  final List<NavigableScreen> screens;

  @override
  State<AppScaffold> createState() => _AppScaffoldState();
}

class _AppScaffoldState extends State<AppScaffold> {
  int _currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.screens[_currentPageIndex].title),
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
            for (final screen in widget.screens)
              ListTile(
                title: Text(screen.title),
                onTap: () {
                  setState(() {
                    _currentPageIndex = widget.screens.indexOf(screen);
                  });
                  Navigator.pop(context);
                },
              ),
          ],
        ),
      ),
      floatingActionButton:
          widget.screens[_currentPageIndex].floatingActionButton,
      body: widget.screens[_currentPageIndex],
    );
  }
}
